# Step 4.1 — Enforcement sequence

**Customer change-control required** for every step below.

---

## Pre-enforce checklist

- [ ] Simulation sign-off complete ([`phase-3`](../phase-3-policy-modeling/03-simulation-workflow.md))
- [ ] Maintenance window scheduled with Epic ops
- [ ] Rollback owners on bridge call
- [ ] TAC case number open (optional)

---

## Sequence (pilot scope: Epic-Integration example)

### Step A — Publish final analyzed policy

1. **Defend → Segmentation → Epic-Integration-Isolation**
2. Verify rules match signed baseline.
3. **Publish** → note **analyzed version ID** and timestamp `T0`.

### Step B — Enable workspace enforcement

1. Workspace **Settings → Enforcement mode → Enforce**
2. Note timestamp `T1` (workspace enforce enabled).

### Step C — Enable agent enforcement on scope

1. **Defend → Segmentation → Scopes → Epic-Integration**
2. **Enable Enforcement** on scope (or per-application workspace binding per your CSW version UI).
3. Note timestamp `T2`.

### Step D — Verify control plane

| Check | Location | Expected |
|-------|----------|----------|
| Workspace enforce | Application details | `enforcement_enabled: true` |
| Agent status | Manage → Agents | `enforcing` on integration hosts |
| Policy version | Workspace versions | Analyzed = enforced target |

```bash
python3 csw_api.py GET /openapi/v1/applications | jq '.[] | select(.name|test("Integration"))'
python3 csw_api.py GET /openapi/v1/sensors | jq '.[] | {hostname, enforcement_status}'
```

### Step E — Wait for policy propagation

Allow **5–15 minutes** (environment-dependent) before functional tests.
Record actual apply time from agent log bundle as `T_apply` — tests must
occur **after** `T_apply`.

---

## Expand beyond pilot

Repeat Steps A–E per scope. **Do not** enable all Epic scopes in one
change — stagger by at least one business week.

---

## Emergency disable

1. Workspace → **Monitor** (or disable enforce).
2. Scope → **Disable Enforcement**.
3. Document in incident log; root-cause before re-enable.

---

**Next:** [`02-functional-tests.md`](./02-functional-tests.md)
