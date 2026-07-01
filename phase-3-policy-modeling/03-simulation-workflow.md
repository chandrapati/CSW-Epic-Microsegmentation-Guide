# Step 3.3 — Simulation workflow

Simulation predicts denies **without blocking**. Required gate before
any Epic production enforce.

---

## 1. Enable Simulation mode

**Defend → Segmentation → [workspace] → Settings**

| Setting | Value |
|---------|-------|
| Enforcement mode | **Simulation** |
| Workspace | Linked to correct scope |

Confirm agents remain in **Monitor** globally until pilot enforce (Phase 4).

## 2. Simulation monitoring calendar

| Day | Check |
|-----|-------|
| 1–2 | Simulation hits appear; no clinical outage reports |
| 3–5 | Review top simulated denies — classify false positive vs true risk |
| 6–7 | Include overnight ETL window |
| 8+ | Epic TS sign-off on false positive fixes |

## 3. Triage simulated denies

| Category | Example | Action |
|----------|---------|--------|
| **True risk** | Clinical → DB | Keep deny; accelerate enforce |
| **Missing allow** | New lab interface | Add allow; change ticket |
| **ADM gap** | Monthly job not in window | Extend ADM; re-simulate |
| **Bad label** | Train → prod | Fix labels |

## 4. False positive fix patterns

| Symptom | Fix |
|---------|-----|
| Batch job blocked in sim | Time-bound allow OR label `job=clarity-etl` |
| LB health check blocked | Allow from LB subnet to web tier |
| Epic patch window traffic | Temporary allow rule with expiry date |
| AV update egress | Allow to vendor CDN IPs |

## 5. Simulation report export

**Defend → Segmentation → Reports → Simulation Summary**

Export PDF + attach to change ticket for Phase 4.

## 6. Sign-off gate

| Criteria | Met? |
|----------|------|
| ≥7 days simulation | |
| Zero open P1 false positives | |
| Epic TS written approval | |
| Security written approval | |
| Rollback plan documented | |

---

## Rollback plan (template)

1. Set workspace to **Monitor** (disable enforce).
2. Disable enforcement on pilot scope agents.
3. Confirm clinical test user can access Hyperspace.
4. Open Sev-2 with Cisco TAC if agent issue suspected.

---

**Phase 3 complete.** Proceed to [`phase-4-enforcement/README.md`](../phase-4-enforcement/README.md)
