# Phase 4 — Enforcement

**Goal:** Enable enforce on a **pilot scope**, prove allow/deny with
functional tests and host-side log bundles.

**Duration:** Days 46–60 (pilot); expand quarterly after

---

## Steps in this phase

| Step | Doc | Output |
|------|-----|--------|
| 4.1 | [`01-enforcement-sequence.md`](./01-enforcement-sequence.md) | Pilot scope enforcing |
| 4.2 | [`02-functional-tests.md`](./02-functional-tests.md) | Pass/fail test sheet |
| 4.3 | [`03-host-side-validation.md`](./03-host-side-validation.md) | Agent log proof |

---

## Recommended pilot order

| Pilot # | Scope | Why first |
|---------|-------|-----------|
| 1 | `Epic-Integration` | Contained blast radius; clear partner allows |
| 2 | `Epic-Application` | Core tier; Simulation already validated |
| 3 | `Epic-Web` | User-facing — change window required |
| 4 | `Epic-Database` | Last — highest impact |

---

## Exit criteria

- [ ] Pilot workspace `enforcement_enabled = true`
- [ ] Agents in pilot scope show `enforcement_status = enforcing`
- [ ] Positive test (allowed flow) passes **after** policy apply timestamp
- [ ] Negative test (denied flow) fails **after** policy apply timestamp
- [ ] Denied Connections log captures negative test
- [ ] Host log bundle analyzed (optional deep proof)

---

## Next phase

[`phase-5-operations/README.md`](../phase-5-operations/README.md)
