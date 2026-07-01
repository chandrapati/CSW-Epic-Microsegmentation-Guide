# POV test plan — Epic microsegmentation

Phased test plan with pass criteria for CSW + Epic POV engagements.

---

## Scope assumptions

- POV duration: 6–8 weeks
- Minimum hosts per [`docs/03-prerequisites.md`](../docs/03-prerequisites.md)
- Production enforce limited to **one pilot scope**
- Customer anonymized in external write-ups

---

## Phase 1 — Foundation (Week 1–2)

| ID | Test | Pass criteria | Evidence |
|----|------|---------------|----------|
| F-01 | CSW tenant login + RBAC | Roles separated | Screenshot |
| F-02 | Scope tree created | All Epic tiers present | Screenshot |
| F-03 | Labels on POV hosts | ≥80% labeled | Inventory CSV |
| F-04 | Filter validation | No train in prod scope | Filter validate output |

---

## Phase 2 — Visibility (Week 2–4)

| ID | Test | Pass criteria | Evidence |
|----|------|---------------|----------|
| V-01 | Agent install web tier | 100% POV web hosts healthy | Agent report |
| V-02 | Agent install app tier | 100% POV app hosts healthy | Agent report |
| V-03 | Agent install integration | 100% POV int hosts healthy | Agent report |
| V-04 | ADM collection | ≥14 days data | ADM screenshot |
| V-05 | Flow baseline sign-off | Epic TS signed matrix | Signed PDF |

---

## Phase 3 — Policy modeling (Week 4–6)

| ID | Test | Pass criteria | Evidence |
|----|------|---------------|----------|
| P-01 | ADM import to workspace | Policies generated | Export JSON |
| P-02 | Default deny to DB drafted | Rule present | Policy screenshot |
| P-03 | Partner allowlist | Matches Interconnect matrix | Table + ADM |
| P-04 | Simulation ≥7 days | No P1 false positives | Sim report |
| P-05 | quick_analysis spot check | App→DB allow; clinical→DB deny | API output |

---

## Phase 4 — Enforcement (Week 6–8)

| ID | Test | Pass criteria | Evidence |
|----|------|---------------|----------|
| E-01 | Pilot enforce enabled | Workspace + agents enforcing | Screenshot |
| E-02 | Positive functional test | Allowed flow works post-T_apply | Test log |
| E-03 | Negative functional test | Denied flow blocked post-T_apply | Test log |
| E-04 | Denied Connections | Negative 5-tuple logged | Export CSV |
| E-05 | Host log bundle (optional) | Rule on host | Analysis doc |

---

## Phase 5 — Operations (Week 8)

| ID | Test | Pass criteria | Evidence |
|----|------|---------------|----------|
| O-01 | Quarterly pack dry run | 10 artifacts exported | ZIP manifest |
| O-02 | Change template | Joint Epic+CSW fields | Template doc |
| O-03 | Rollback drill | Monitor mode <15 min | Runbook sign-off |

---

## POV exit summary

| Metric | Target |
|--------|--------|
| Requirements tested | ≥80% of in-scope questionnaire |
| Pass rate | Document Pass / Partial / Not tested |
| Open items | "Confirm with Cisco" list for BU |

Scoring: [`02-evidence-matrix.md`](./02-evidence-matrix.md)
