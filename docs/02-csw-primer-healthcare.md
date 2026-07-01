# CSW primer for healthcare teams

Short glossary for clinical IT, Epic platform owners, and compliance
auditors who are new to Cisco Secure Workload.

---

## What CSW does on Epic servers

| Capability | Plain language | Epic example |
|------------|----------------|--------------|
| **Inventory** | Knows every server, process, port | "Which hosts run Interconnect?" |
| **Flow telemetry** | Records who talked to whom, on which port | "Does Clarity ETL hit production ODB directly?" |
| **ADM** | Draws dependency map from real traffic | Replace stale Visio diagram |
| **Microsegmentation** | Host firewall rules pushed by central policy | Block workstation → database except approved paths |
| **Vulnerability context** | CVE + reachability from other tiers | "Is this Oracle patch urgent given exposure?" |

CSW does **not** replace Epic application security, Hyperspace RBAC, or
database TDE. It controls **network paths between workloads**.

---

## Key CSW terms

| Term | Meaning |
|------|---------|
| **Agent (sensor)** | Lightweight software on each Epic server/VM |
| **Scope** | Logical boundary (e.g. `Epic-Database`) |
| **Label** | Tag on a workload (`epic_tier=db`) |
| **Filter** | Query that auto-assigns workloads to scopes |
| **Workspace** | Policy container for one scope |
| **ADM** | Application Dependency Mapping — learns traffic patterns |
| **Monitor** | Observe only; no blocking |
| **Simulation** | Predict what would be blocked before enforcing |
| **Enforce** | Actively block traffic that violates policy |
| **Denied Connections** | Audit log of blocked flows |

---

## Safe rollout sequence (Epic)

```text
1. Monitor     — agents installed, flows collected, no blocking
2. ADM         — 2–4 weeks baseline including month-end batch jobs
3. Simulation  — policy published in sim mode; review false positives
4. Enforce     — one tier at a time (recommend: Integration or App before DB)
5. Operate     — quarterly evidence exports for HIPAA
```

**Never** jump to Enforce on `Epic-Database` before Simulation on
application and integration tiers — batch ETL windows will surprise you.

---

## Console map

| Area | Use for Epic |
|------|--------------|
| **Investigate → Inventory** | Confirm 100% agent coverage per tier |
| **Investigate → Flows** | Ad-hoc flow search during incidents |
| **Investigate → ADM** | Dependency maps for change requests |
| **Defend → Segmentation** | Author and publish Epic tier policies |
| **Manage → Agents** | Agent health, enforcement status |
| **Platform → Connectors** | Cloud, ServiceNow, AD identity |
| **Administration → Audit** | Who changed policy and when |

---

## HIPAA one-liner mapping

| Auditor question | CSW artifact |
|------------------|--------------|
| Is ePHI network-isolated? | Scope + enforce screenshot + policy export |
| What talks to the EHR DB? | ADM diagram + flow export |
| Prove blocking works | Denied Connections + negative functional test |
| Show ongoing effectiveness | Quarterly inventory + drift report |

Full mapping: [CSW-Compliance-Mapping — HIPAA](https://github.com/chandrapati/CSW-Compliance-Mapping/tree/main/HIPAA)

---

## Next step

[`docs/03-prerequisites.md`](./03-prerequisites.md) — accounts, ports, and stakeholders.
