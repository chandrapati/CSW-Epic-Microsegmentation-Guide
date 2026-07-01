# Phase 5 — Operations

**Goal:** Sustain Epic microsegmentation in production — evidence packs,
change management, drift monitoring, incident response.

**Duration:** Ongoing (quarterly rhythm)

---

## Steps in this phase

| Step | Doc | Output |
|------|-----|--------|
| 5.1 | [`01-hipaa-evidence-pack.md`](./01-hipaa-evidence-pack.md) | Quarterly compliance binder |
| 5.2 | [`02-change-management.md`](./02-change-management.md) | Epic + CSW joint change process |
| 5.3 | [`03-troubleshooting.md`](./03-troubleshooting.md) | Runbook for policy failures |

---

## Operational cadence

| Frequency | Activity |
|-----------|----------|
| Daily | Monitor Denied Connections anomalies on integration tier |
| Weekly | Agent health report; failed agents on Epic DB tier = P1 |
| Monthly | ADM diff review after Epic patches |
| Quarterly | HIPAA evidence pack export |
| Annually | Full ADM refresh; partner allowlist recertification |

---

## Operator reports (optional)

| Report | Use |
|--------|-----|
| Posture | % Epic hosts scoped and enforcing |
| Drift | Analyzed vs enforced version lag |
| Gaps | Scopes without workspaces |
| Noisy | Catch-all DENY absorption |

Patterns: [CSW-Policy-Lifecycle](https://github.com/chandrapati/CSW-Policy-Lifecycle)
