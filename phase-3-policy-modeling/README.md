# Phase 3 — Policy modeling

**Goal:** Author Epic tier policies from ADM, run Simulation, obtain
change-board approval — **no enforcement yet**.

**Duration:** Days 29–45

---

## Steps in this phase

| Step | Doc | Output |
|------|-----|--------|
| 3.1 | [`01-tier-isolation-policies.md`](./01-tier-isolation-policies.md) | Workspace policies per tier |
| 3.2 | [`02-interconnect-and-hl7.md`](./02-interconnect-and-hl7.md) | Integration allowlists |
| 3.3 | [`03-simulation-workflow.md`](./03-simulation-workflow.md) | Simulation report; false positives resolved |

---

## Policy design principles (Epic)

1. **Default deny** inbound to `Epic-Database` and `Epic-Application`.
2. **Explicit allow** only paths in signed flow baseline.
3. **Log** unmatched inbound to integration tier (partner drift detection).
4. **Deny** `Epic-Train` → `Epic-Production` at policy level.
5. **Break-glass** jump hosts — narrow allow, heavy logging, quarterly review.

---

## Exit criteria

- [ ] Workspaces created for each enforced scope (pilot: Integration or App)
- [ ] Policies imported from ADM and manually refined
- [ ] Simulation ran **≥7 days** including one batch window
- [ ] Zero unresolved **P1** false positives (clinical or batch broken)
- [ ] Change ticket approved for Phase 4 enforce pilot

---

## Next phase

[`phase-4-enforcement/README.md`](../phase-4-enforcement/README.md)
