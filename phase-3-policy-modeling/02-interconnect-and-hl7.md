# Step 3.2 — Interconnect and HL7 segmentation

Epic **Interconnect** and interface engines are the highest-risk
lateral movement paths — partners, legacy HL7, and ad-hoc TCP ports.

---

## 1. Scope integration tier separately

Ensure `Epic-Integration` scope contains only:

- Interconnect servers
- Bridges / Mirth / Rhapsody (if used)
- MyChart / FHIR edge proxies
- VPN endpoints for named partners (if hosted on dedicated hosts)

## 2. Build partner allowlist from ADM

Export all **inbound** and **outbound** flows from integration tier:

| Direction | Partner IP/FQDN | Port | Protocol | BAA on file? |
|-----------|-----------------|------|----------|--------------|
| Inbound | | | HL7 MLLP / FHIR | |
| Outbound | | | | |

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
| HL7 v2 MLLP | Persistent TCP | Port may ≠ 2575 — use ADM |
| FHIR REST | HTTPS 443 | Often same as web tier proxies |
| File-based interfaces | SMB/FTP | Label `integration_type=file`; restrict to drop zones |

## 5. Partner label strategy

| Label | Example |
|-------|---------|
| `partner` | `clearinghouse-a`, `lab-corp-b` |
| `baa` | `true`, `false` |
| `interface_id` | Epic interconnect channel ID |

Policies reference `label:partner=*` instead of raw IPs where possible.

## 6. Simulation focus for integration

Run Simulation through:

- [ ] Peak HL7 message volume window
- [ ] Nightly batch retransmit window
- [ ] New partner onboarding test (if scheduled in POV)

---

## FHIR / MyChart edge

Often collocated with `Epic-Web`. Options:

1. Split labels `epic_tier=integration` vs `web` on same host (not ideal).
2. Use **process-based** allows: `process contains "interconnect"` vs `ohs`.
3. Separate VMs for edge vs core (preferred long-term).

---

**Next:** [`03-simulation-workflow.md`](./03-simulation-workflow.md)
