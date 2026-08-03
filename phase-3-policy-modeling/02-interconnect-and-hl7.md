# Step 3.2 — Interconnect and HL7 segmentation

Epic **Interconnect** and interface engines are the highest-risk
lateral movement paths — partners, legacy HL7, and ad-hoc TCP ports.

> **Design source.** Epic's [open.epic Design Overview](https://open.epic.com/DesignOverview)
> enumerates the *data-exchange methods* an Epic estate exposes (HL7 v2, FHIR,
> CDA, SMART, CDS Hooks, FHIRCast, Bulk FHIR, reporting, and Epic web services)
> and how each is secured. Use it to enumerate your **interface surface** — the
> flows CSW must allow on the integration tier. It does **not** describe server
> topology; the tier model in
> [`docs/01-epic-architecture-tiers.md`](../docs/01-epic-architecture-tiers.md)
> covers that.

---

## 0. Epic data-exchange methods → segmentation lens

Each Epic exchange method carries a different recency, volume, direction,
trigger, and **security mechanism** — and each drives a different allow-rule
shape. Map every live interface to one of these rows before authoring policy.

| Epic method | Transport / port | Security | Trigger | Segmentation implication |
|-------------|------------------|----------|---------|--------------------------|
| **HL7 v2 interfaces** | TCP/IP, MLLP (site port; classic 2575) | **No application auth** — relies on network + TLS/cert only | Real-time, event-driven | Network microsegmentation is the **primary** control; strict per-partner IP/port allowlist |
| **RESTful FHIR** | HTTPS 443 | OAuth 2.0 | On-demand | Often colocated with MyChart/FHIR edge; N-S egress + token-secured |
| **SMART on FHIR / CDS Hooks / FHIRCast** | HTTPS 443 | OAuth 2.0 | Contextual / event-driven | User-launched apps; N-S to app servers; treat as web-edge |
| **HL7 CDA** | HTTPS / file / interface | Varies | Varies | Document exchange; may ride web or file drop zones |
| **Bulk FHIR** | HTTPS 443 | OAuth 2.0 | Batch / episodic | Large periodic pulls → **time-bound** allow window |
| **Reporting tools** | Non-standard (DB / ODBC / web) | Varies | Batch | Maps to **T4 Reporting**; isolate from **T5** except ETL |
| **Other Epic web services** | HTTPS 443 | Varies | Varies | Confirm each via ADM; do not assume 443-only |

### Why this matters for CSW

Epic states that HL7 v2 over TCP/IP **"won't rely on authentication, but rather
relies on other security mechanisms to secure your data exchange."** For a large
share of Epic interface traffic there is **no app-layer identity** — so
**network microsegmentation is the compensating control**. This is the single
strongest reason CSW belongs on the integration tier: it enforces
workload-to-workload allow-lists (by label/scope, not just IP) for flows that
have no other authentication boundary.

### Direction of exchange — flag writes into Epic

Epic calls out that **writing data into Epic** (orders, results, appointments)
carries patient-safety and data-integrity risk beyond read-only flows. Tag these
paths so policy is tighter and **logging is mandatory**:

| Direction | Example | Risk | Policy posture |
|-----------|---------|------|----------------|
| Read from Epic | registries, schedule pull | Confidentiality | Allowlist + log |
| **Write into Epic** | inbound lab results, order updates | **Integrity / patient safety** | Narrowest allowlist + **always log**; alert on new source |

---

## 1. Scope integration tier separately

Ensure `Epic-Integration` scope contains only:

- Interconnect servers
- Bridges / Mirth / Rhapsody (if used)
- MyChart / FHIR edge proxies
- VPN endpoints for named partners (if hosted on dedicated hosts)

## 2. Build partner allowlist from ADM

Export all **inbound** and **outbound** flows from integration tier:

| Direction | Partner IP/FQDN | Port | Protocol | Writes into Epic? | BAA on file? |
|-----------|-----------------|------|----------|-------------------|--------------|
| Inbound | | | HL7 MLLP / FHIR | | |
| Outbound | | | | | |

Mark any row where the partner **writes into Epic** (orders, results,
appointments) — those get the narrowest allow rule plus mandatory logging.

Cross-check with Epic **Interconnect** port matrix.

## 3. Policy pattern — integration workspace

```text
# Default deny inbound to integration
DENY   any  →  Epic-Integration

# Partner allowlist (one rule per partner or grouped by label partner=*)
ALLOW  label:partner=clearinghouse-a  →  Epic-Integration  tcp/2575
ALLOW  Epic-Integration  →  label:partner=clearinghouse-a  tcp/2575

# Epic internal
ALLOW  Epic-Integration  →  Epic-Application  tcp/<from-ADM>

# No direct integration → database (should route via app)
DENY   Epic-Integration  →  Epic-Database

# Log unmatched for SOC review
LOG    any  →  Epic-Integration
LOG    Epic-Integration  →  any
```

## 4. HL7 vs FHIR

| Type | Typical pattern | CSW note |
|------|-----------------|----------|
| HL7 v2 MLLP | Persistent TCP | Port may ≠ 2575 — use ADM. No app auth → segmentation is the control |
| FHIR REST / SMART / CDS Hooks | HTTPS 443, OAuth 2.0 | Often same as web tier proxies |
| Bulk FHIR | HTTPS 443, batch | Episodic large pull — consider time-bound allow window |
| HL7 CDA | HTTPS / file | Document exchange; may ride web or drop zones |
| File-based interfaces | SMB/FTP | Label `integration_type=file`; restrict to drop zones |

## 5. Partner label strategy

| Label | Example |
|-------|---------|
| `partner` | `clearinghouse-a`, `lab-corp-b` |
| `baa` | `true`, `false` |
| `interface_id` | Epic interconnect channel ID |

Policies reference `label:partner=*` instead of raw IPs where possible.

## 6. Simulation focus for integration

Match Simulation windows to Epic's **trigger types** so episodic flows are not
missed (the same "business-cycle" lesson that causes self-inflicted outages when
enforcement tightens to default-deny):

- [ ] **Event-driven** — peak HL7 message volume window
- [ ] **Batch** — nightly retransmit + **Bulk FHIR / reporting** extract window
- [ ] **On-demand** — patient-initiated FHIR / MyChart API calls
- [ ] **Contextual** — SMART / CDS Hooks / FHIRCast app launches
- [ ] New partner onboarding test (if scheduled in POV)

---

## FHIR / MyChart edge

Often collocated with `Epic-Web`. Options:

1. Split labels `epic_tier=integration` vs `web` on same host (not ideal).
2. Use **process-based** allows: `process contains "interconnect"` vs `ohs`.
3. Separate VMs for edge vs core (preferred long-term).

### External networks — TEFCA / IAS and patient-facing apps

Modern Epic estates expose FHIR to **national exchange frameworks** (TEFCA
Individual Access Services) and hundreds of patient-authorized health apps via
OAuth 2.0. These are **north-south** flows from the FHIR/MyChart edge to external
networks. Keep them on a dedicated egress allowlist (by FQDN/label where
possible), separate from internal T3↔T2 rules, and log new external endpoints
for SOC review.

---

**Next:** [`03-simulation-workflow.md`](./03-simulation-workflow.md)
