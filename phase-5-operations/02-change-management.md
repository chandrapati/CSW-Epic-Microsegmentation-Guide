# Step 5.2 — Change management

Integrate CSW policy changes with Epic's change advisory board (CAB).

---

## Change categories

| Category | Examples | Approval |
|----------|----------|----------|
| **Standard** | Label fix, new partner allow (pre-approved template) | Epic integration lead |
| **Normal** | New workspace rule, Simulation start | Security + Epic TS |
| **Emergency** | Break-glass widen for outage | CISO + Epic director; retroactive CAB within 24h |

---

## Joint change record fields

| Field | Description |
|-------|-------------|
| Epic change # | Customer ITSM ticket |
| CSW workspace | Affected policy container |
| Scopes impacted | e.g. Epic-Integration |
| ADM reference | Cluster or flow ID justifying allow |
| Simulation dates | Start / end |
| Enforce window | Maintenance slot |
| Rollback owner | Named engineer |
| Clinical impact assessment | Y/N — Hyperspace test required? |

---

## Epic patch coordination

Epic quarterly updates often change ports or add servers:

| When | CSW action |
|------|------------|
| **T-14 days** | Epic patch notes reviewed |
| **T-7 days** | Extend Simulation on affected scopes |
| **Patch window** | Monitor mode if major network change |
| **T+3 days** | ADM diff; new flows labeled |
| **T+14 days** | Re-enable enforce after sign-off |

---

## New module / server onboarding

1. Install agent in Monitor.
2. Apply labels `app=epic`, `epic_tier=*`.
3. Wait 7 days ADM on host.
4. Add allows to workspace; Simulation 3 days minimum.
5. Enforce in next CAB window.

---

## Partner onboarding (Interconnect)

1. BAA verified — compliance label `baa=true`.
2. ADM confirms expected 5-tuple OR documented in Interconnect spec.
3. Add allow rule with `partner=<id>` label.
4. Simulation 24–72h minimum (message volume dependent).
5. Negative test from non-partner IP.
