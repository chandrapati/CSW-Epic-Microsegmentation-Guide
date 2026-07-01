# Step 4.2 — Functional tests

Structured allow/deny tests for Epic pilot enforce. Record timestamps
relative to policy apply (`T_apply`).

---

## Test environment

| Field | Value |
|-------|-------|
| Pilot scope | |
| Test date | |
| T_apply (from logs) | |
| Tester | |

---

## Test 1 — Allowed path (positive)

**Goal:** Confirm legitimate Epic traffic still works after enforce.

| Pilot scope | Example test |
|-------------|--------------|
| Integration | Send test HL7 message partner → Interconnect → app ACK |
| Application | App server health check / Epic utility login |
| Web | Hyperspace login via test user |
| Database | App → DB SQL*Net (from app tier only) |

| Step | Action | Expected | Pass? |
|------|--------|----------|-------|
| 1 | Record time `T_test` > `T_apply` | | |
| 2 | Execute allowed flow | Success | |
| 3 | Check CSW flow table | Flow = allowed | |

---

## Test 2 — Denied path (negative)

**Goal:** Prove segmentation blocks unauthorized tier crossing.

| Test case | Source | Destination | Port | Expected |
|-----------|--------|-------------|------|----------|
| Clinical → DB | Clinical access host | Production ODB | 1521 | **Blocked** |
| Internet → Integration | External test IP | Interconnect | 2575 | **Blocked** |
| Train → Prod | Train app host | Prod app | 443 | **Blocked** |
| Rogue partner | Unlisted IP | Interconnect | 2575 | **Blocked** |

| Step | Action | Expected | Pass? |
|------|--------|----------|-------|
| 1 | `T_test` > `T_apply` | | |
| 2 | Attempt denied flow | Connection timeout/refused | |
| 3 | CSW Denied Connections | Entry with 5-tuple | |
| 4 | Source host flow does not succeed | | |

### Example (Linux source)

```bash
# Negative test — clinical should NOT reach DB
nc -zv <odb-ip> 1521 -w 5
# Expect: timeout or refused AFTER T_apply
```

---

## Test 3 — quick_analysis correlation

```bash
python3 csw_api.py POST /openapi/v1/policies/{rootScopeID}/quick_analysis \
  --json '{"src_ip":"<src>","dst_ip":"<dst>","dst_port":1521,"protocol":"tcp"}'
```

| Test | Expected action |
|------|-----------------|
| App → DB | allow |
| Clinical → DB | deny |

---

## Test results summary

| Test ID | Description | Result | Evidence link |
|---------|-------------|--------|---------------|
| T-001 | | Pass / Fail | |
| T-002 | | Pass / Fail | |

---

**Next:** [`03-host-side-validation.md`](./03-host-side-validation.md)
