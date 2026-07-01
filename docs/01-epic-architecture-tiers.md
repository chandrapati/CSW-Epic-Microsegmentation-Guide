# Epic architecture tiers for microsegmentation

How to think about Epic estates when designing CSW scopes, labels, and
policies. This is a **reference model** — your implementation will differ
by modules (Inpatient, Ambulatory, OpTime, Beaker, Radiant, etc.), hosting
(on-prem, private cloud, hybrid), and interface mix.

---

## Why tier-based segmentation

Epic environments typically grow as **flat "Epic VLANs"** that bundle web,
app, and database traffic. That model fails three common audit questions:

1. *Can a compromised clinical workstation reach the production database
   directly?*
2. *Can a reporting / analytics tier pull from transactional DB without
   going through approved ETL paths?*
3. *Can a partner interface server talk to systems outside its BAA scope?*

CSW microsegmentation answers these with **workload-to-workload policy**
informed by **observed flows (ADM)**, not static firewall diagrams alone.

---

## Reference tier model

| Tier | ID | Typical workloads | ePHI exposure | CSW priority |
|------|----|-------------------|---------------|--------------|
| **T0 — Clinical access** | `clinical-access` | VDI pools, Citrix, fat-client jump boxes | High (user session) | Monitor first; enforce egress to web tier |
| **T1 — Web / presentation** | `epic-web` | OHS, Apache/IIS front ends, WAF, LB VIP backends | High | ADM + enforce web→app only |
| **T2 — Application** | `epic-app` | Chronicles, module app servers, cache, MCI | High | Core transactional policy |
| **T3 — Integration** | `epic-integration` | Interconnect, Bridges, MyChart edge, FHIR gateways | High (interface data) | Strict partner + HL7 allowlists |
| **T4 — Reporting** | `epic-reporting` | Clarity ETL, Caboodle, SlicerDicer, Cognos | High (copy of PHI) | Isolate from T2/T5 except ETL paths |
| **T5 — Database** | `epic-db` | Chronicles ODB, Clarity DB, Caboodle DB | Highest | Default-deny; smallest allow surface |
| **T6 — Shared infra** | `shared-infra` | AD, DNS, NTP, backup, patch, SIEM, monitoring | Medium | Label + controlled allow to all tiers |

```text
  [T0 Clinical] ──443──► [T1 Web] ──► [T2 App] ──► [T5 Prod DB]
                              │            │
                              │            └──► [T3 Integration] ──► partners
                              │
                              └──► [T4 Reporting] ──ETL──► [T5 Analytics DB]

  [T6 Shared] ──LDAP/DNS/NTP/monitor──► (all tiers, tightly allowlisted)
```

---

## Ports and protocols — validate with ADM

**Do not copy these into production policy without ADM confirmation.**
Epic versions and modules change port usage.

| Flow | Common ports / protocols | Notes |
|------|---------------------------|-------|
| Hyperspace / web UI | TCP 443 (HTTPS) | May traverse Citrix/VDI first |
| App server ↔ app server | TCP 443, Epic-proprietary | ADM shows process names |
| App → Chronicles ODB | TCP 1521 (Oracle), varies | Often highest sensitivity |
| Clarity ETL | TCP 1433/1521, batch windows | Time-bound allows possible |
| HL7 v2 (MLLP) | TCP 2575 (classic), site-specific | Interconnect matrix is authoritative |
| FHIR / REST APIs | TCP 443 | Growing share of interfaces |
| LDAP / AD | TCP 389, 636 (LDAPS preferred) | Shared infra tier |
| Kerberos | TCP/UDP 88 | AD dependency |
| DNS | UDP/TCP 53 | |
| CSW agent → cluster | TCP 443 outbound | Required on every agent host |
| Backup (Commvault, etc.) | Site-specific | Label `role=backup` |

### Inventory filter hints (CSW)

Use these to **discover** Epic workloads before formal CMDB tagging:

```text
Filter: Epic-Candidates
  - Process name contains (case-insensitive): epic, chronicles, clarity, caboodle,
    interconnect, hyperspace, mirth (if used)
  - Hostname contains: ehr, epic, emr, clarity, cab, interconnect
  - Listening port in: 443, 1521, 1433, 2575

Filter: Epic-Database-Tier
  - Process: oracle, sqlservr, postgres
  - Label app=epic AND tier=db (after manual confirmation)
```

---

## Scope tree example

```text
Healthcare-Org (root)
├── Epic-Production
│   ├── Epic-Clinical-Access      (T0)
│   ├── Epic-Web                  (T1)
│   ├── Epic-Application          (T2)
│   ├── Epic-Integration          (T3)
│   ├── Epic-Reporting            (T4)
│   └── Epic-Database             (T5)
├── Epic-NonProduction
│   ├── Epic-Train-Web
│   └── Epic-Train-App
├── PHI-Zone (compliance boundary — may span multiple tiers)
└── Shared-Infrastructure         (T6)
```

**Rule of thumb:** one **workspace** per scope (or sub-scope) you intend to
enforce independently. Start with `Epic-Application` + `Epic-Database` for
the first enforcement pilot.

---

## Label schema

| Label key | Example values | Used for |
|-----------|----------------|----------|
| `app` | `epic` | All Epic workloads |
| `epic_module` | `inpatient`, `ambulatory`, `beaker`, `radiant` | Module-specific policy |
| `epic_tier` | `web`, `app`, `integration`, `reporting`, `db` | Tier isolation |
| `env` | `production`, `train`, `dev` | Train/dev must never share policy with prod |
| `compliance` | `hipaa`, `phi` | HIPAA evidence exports |
| `data` | `phi`, `sensitive` | Scope filters |
| `owner` | `epic-platform`, `clinical-ops` | RACI / change tickets |

---

## Multi-site and cloud variants

| Pattern | CSW approach |
|---------|--------------|
| **Single datacenter Epic** | Straight tier scopes; agents on all tiers |
| **Active/active or DR pair** | Duplicate scope labels with `site=a|b`; ADM per site |
| **Epic on VMware** | Standard OS agents on VMs |
| **Epic modules in cloud (Azure/AWS)** | Cloud connector + agents where supported |
| **Citrix-published Hyperspace** | Agents on VDI hosts + web tier; user identity via [CSW Identity Guide](https://github.com/chandrapati/CSW-Identity-Integration-Guide) |

---

## Next steps

1. Reconcile this model with your Epic **Network Requirements** PDF.
2. Proceed to [`phase-1-foundation/02-scope-hierarchy.md`](../phase-1-foundation/02-scope-hierarchy.md) to build the CSW scope tree.
3. Deploy agents per [`phase-2-visibility/01-agent-deployment-by-tier.md`](../phase-2-visibility/01-agent-deployment-by-tier.md).
