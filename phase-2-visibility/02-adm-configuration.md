# Step 2.2 — ADM configuration

Application Dependency Mapping (ADM) is the **source of truth** for Epic
tier policies. Configure it to capture process context and full business cycles.

---

## 1. Create ADM workspace

**Investigate → Application Dependency Mapping → New**

| Field | Recommended value |
|-------|-------------------|
| Name | `Epic-Production-ADM` |
| Scope | `Epic-Production` (or start with `Epic-Application` for smaller POV) |
| Collection period | **Minimum 14 days**; 28 days preferred |
| Process context | **Enabled** |
| User context | Enable if Windows agents + identity integration |

## 2. Time window requirements

Ensure ADM spans:

| Event | Why |
|-------|-----|
| Weekday clinical peak | Hyperspace → web → app paths |
| Weekend / overnight ETL | Clarity → DB batch |
| Month-end reporting | Caboodle / analytics surge |
| Interface batch (if scheduled) | Interconnect partner windows |

If POV is shorter than 14 days, document **gap** and plan production ADM extension.

## 3. ADM review cadence

| Week | Activity |
|------|----------|
| 1 | Confirm clusters forming; fix missing agents |
| 2 | Epic TS maps clusters → official application names |
| 3 | Flag anomalous flows (DB direct from clinical, internet egress) |
| 4 | Export diagram for Phase 3 policy workshop |

## 4. Export ADM artifacts

- PNG/PDF dependency diagram per tier
- CSV cluster export
- Screenshot of top 20 flows for `Epic-Database` scope

Store in customer POV repo under `docs/adm-baseline/`.

---

## ADM analysis questions (Epic-specific)

| # | Question | Action if "yes" |
|---|----------|-----------------|
| 1 | Clinical tier talks directly to `epic_tier=db`? | Priority deny candidate |
| 2 | Reporting tier hits production ODB (not Clarity copy)? | Route via approved ETL only |
| 3 | Integration server talks to internet unpredictably? | Partner allowlist + alert |
| 4 | Train hosts appear in production ADM? | Fix labels/filters |
| 5 | Unencrypted LDAP (389) to AD? | Require LDAPS in Phase 3 |
| 6 | HTTP (80) carrying app traffic? | TLS remediation or explicit deny |

---

## API flow search (supplement)

```bash
# Example: flows to database tier in last 7 days
python3 csw_api.py POST /openapi/v1/flow_search/flows \
  --json '{"filters":[{"field":"dst_scope","value":"Epic-Database"}],"time_range":"7d"}'
```

---

**Next:** [`03-flow-baseline-checklist.md`](./03-flow-baseline-checklist.md)
