# Phase 2 — Visibility

**Goal:** CSW agents on representative Epic tiers; ADM running long enough
to capture clinical hours, batch ETL, and interface traffic.

**Duration:** Days 11–28 (minimum 2 weeks ADM)

---

## Steps in this phase

| Step | Doc | Output |
|------|-----|--------|
| 2.1 | [`01-agent-deployment-by-tier.md`](./01-agent-deployment-by-tier.md) | Agents installed; 95%+ POV coverage |
| 2.2 | [`02-adm-configuration.md`](./02-adm-configuration.md) | ADM workspace collecting flows |
| 2.3 | [`03-flow-baseline-checklist.md`](./03-flow-baseline-checklist.md) | Signed baseline for policy authoring |

---

## Exit criteria

- [ ] All POV hosts show **agent healthy** in Manage → Agents
- [ ] ADM ran through at least one **Clarity/Caboodle batch window** (if in scope)
- [ ] ADM ran through **peak clinical hours** (weekday 9am–5pm local)
- [ ] Epic TS reviewed ADM clusters and signed tier mapping
- [ ] Unexpected flows documented (shadow IT, rogue DB paths, internet egress)

---

## Next phase

[`phase-3-policy-modeling/README.md`](../phase-3-policy-modeling/README.md)
