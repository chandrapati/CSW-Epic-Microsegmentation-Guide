# Step 5.1 — HIPAA evidence pack

Quarterly export bundle for risk analysis and audit — maps to CSW
artifacts and HIPAA §164.312 controls.

Full framework mapping: [CSW-Compliance-Mapping — HIPAA](https://github.com/chandrapati/CSW-Compliance-Mapping/tree/main/HIPAA)

**Companion docs in this programme:**

| Doc | Link |
|-----|------|
| HIPAA technical runbook | [CSW-HIPAA-Technical-Runbook.md](https://github.com/chandrapati/CSW-Compliance-Mapping/blob/main/HIPAA/CSW-HIPAA-Technical-Runbook.md) |
| HIPAA 2025 NPRM (proposed rule) | [CSW-HIPAA-NPRM-Technical-Runbook.md](https://github.com/chandrapati/CSW-Compliance-Mapping/blob/main/HIPAA-2025-NPRM/CSW-HIPAA-NPRM-Technical-Runbook.md) |
| HITRUST CSF v11 | [CSW-HITRUST-Technical-Runbook.md](https://github.com/chandrapati/CSW-Compliance-Mapping/blob/main/HITRUST-CSF/CSW-HITRUST-Technical-Runbook.md) |
| Compliance evidence playbook | [compliance-evidence-playbook.md](https://github.com/chandrapati/CSW-Compliance-Mapping/blob/main/docs/compliance-evidence-playbook.md) |
| Epic tier rollout (step-by-step) | [CSW-Epic-Microsegmentation-Guide](https://github.com/chandrapati/CSW-Epic-Microsegmentation-Guide) — Phase 5 §5.1 maps to this pack |

---

## Quarterly pack contents

| # | Artifact | CSW source | HIPAA mapping |
|---|----------|------------|---------------|
| 1 | Epic inventory by tier | Inventory CSV export | §164.312(a)(1) access control |
| 2 | Scope + enforce screenshot | Defend → Scopes | §164.312(a)(1) |
| 3 | Policy export (PHI scopes) | Workspace export JSON | §164.312(a)(1) |
| 4 | ADM diagram (current quarter) | ADM export | §164.308(a)(1) risk analysis |
| 5 | Denied Connections sample | Investigate → Denied | §164.312(b) audit |
| 6 | Simulation report (if changes) | Segmentation reports | §164.308(a)(8) evaluation |
| 7 | Vulnerability report (PHI scope) | Vulnerability report | §164.308(a)(1) |
| 8 | CSW audit log extract | Administration → Audit | §164.312(b) |
| 9 | Agent coverage report | Manage → Agents | §164.312(e) integrity |
| 10 | Exception register | Customer GRC tool | §164.308(a)(1) |

---

## Export procedure

### Inventory

```text
Investigate → Inventory → Filter: scope PHI-Zone OR label compliance=hipaa
→ Export CSV → epic-inventory-YYYY-QN.csv
```

### Policy

```text
Defend → Segmentation → [workspace] → Export
→ epic-policy-YYYY-QN.json
```

### Denied connections

```text
Investigate → Denied Connections → Last 90 days → Export
→ epic-denies-YYYY-QN.csv
```

---

## Storage and retention

- Store encrypted at rest per organizational policy.
- Align retention to HIPAA — many entities retain **6 years** for audit
  documentation; CSW flow retention is separate (configure in platform).
- **Do not** store packs in this public GitHub repo.

---

## Narrative template (for auditors)

> Cisco Secure Workload enforces workload-level microsegmentation on Epic
> ePHI tiers. Quarterly exports demonstrate: (1) complete inventory of
> in-scope hosts, (2) enforced deny-default policy on database and
> application tiers, (3) logged denied connection attempts, and (4)
> behaviour-derived dependency maps refreshed this quarter.
