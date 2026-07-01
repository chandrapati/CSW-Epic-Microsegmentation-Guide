# Phase 1 — Foundation

**Goal:** CSW tenant ready, Epic scope tree created, labels and filters
applied so Phase 2 ADM captures the right workloads.

**Duration:** Days 1–10

---

## Steps in this phase

| Step | Doc | Output |
|------|-----|--------|
| 1.1 | [`01-tenant-and-connectors.md`](./01-tenant-and-connectors.md) | Tenant verified; optional connectors live |
| 1.2 | [`02-scope-hierarchy.md`](./02-scope-hierarchy.md) | Epic scope tree in CSW |
| 1.3 | [`03-labels-and-filters.md`](./03-labels-and-filters.md) | Labels on inventory; filters populating scopes |

---

## Exit criteria (do not proceed to Phase 2 until met)

- [ ] Root scope `Healthcare-Org` (or equivalent) exists
- [ ] `Epic-Production` child scopes match tier model from [`docs/01-epic-architecture-tiers.md`](../docs/01-epic-architecture-tiers.md)
- [ ] ≥80% of POV host list has `app=epic` and `epic_tier=*` labels (manual OK initially)
- [ ] Agent install change tickets approved for Phase 2
- [ ] Baseline API snapshot captured (agent count, scopes) — optional via OpenAPI

---

## API baseline (optional)

```bash
# Requires CSW_API_* env vars — see CSW-POV-Tooling
python3 csw_api.py GET /openapi/v1/sensors
python3 csw_api.py GET /openapi/v1/app_scopes
python3 csw_api.py GET /openapi/v1/applications
```

Save JSON exports to customer POV repo — **not** this public guide repo.

---

## Next phase

[`phase-2-visibility/README.md`](../phase-2-visibility/README.md)
