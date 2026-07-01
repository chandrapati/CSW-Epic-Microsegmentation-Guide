# Step 1.3 — Labels and filters

Automate scope membership and prepare for policy expressions.

---

## 1. Apply static labels (manual or CMDB import)

Minimum label set for every Epic POV host:

| Label | Example | Required |
|-------|---------|----------|
| `app` | `epic` | Yes |
| `epic_tier` | `web`, `app`, `integration`, `reporting`, `db` | Yes |
| `env` | `production`, `train` | Yes |
| `compliance` | `hipaa` | Yes for PHI systems |
| `data` | `phi` | Yes for ePHI |
| `epic_module` | `inpatient`, `ambulatory` | Recommended |

**Investigate → Inventory → select hosts → Actions → Add Labels**

## 2. Create discovery filters

Before all hosts are labeled, use filters to find Epic candidates:

### Filter: `Epic-Discovery`

```text
OR:
  - process_name contains "epic" (case insensitive)
  - process_name contains "chronicles"
  - process_name contains "clarity"
  - process_name contains "interconnect"
  - hostname contains "epic"
  - hostname contains "ehr"
  - listening_port in [443, 1521, 1433, 2575]
```

Review weekly during Phase 2; assign `app=epic` after Epic team confirms.

### Filter: `PHI-Zone-Members`

```text
AND:
  - label app = epic
  - label data = phi
  - label env = production
```

Attach to `PHI-Zone` scope.

## 3. Bind filters to scopes

For each tier scope, set membership rule:

| Scope | Filter rule |
|-------|-------------|
| `Epic-Web` | `app=epic` AND `epic_tier=web` AND `env=production` |
| `Epic-Application` | `app=epic` AND `epic_tier=app` AND `env=production` |
| `Epic-Integration` | `app=epic` AND `epic_tier=integration` AND `env=production` |
| `Epic-Reporting` | `app=epic` AND `epic_tier=reporting` AND `env=production` |
| `Epic-Database` | `app=epic` AND `epic_tier=db` AND `env=production` |
| `Epic-Clinical-Access` | `app=epic` AND `epic_tier=clinical-access` AND `env=production` |

## 4. Validate filter logic

**Defend → Scopes → [scope] → Validate Filter**

Fix false positives (e.g. non-Epic Oracle server) before ADM.

## 5. Export inventory snapshot

**Investigate → Inventory → Export CSV**

Store as Phase 1 evidence: `phase1-inventory-YYYY-MM-DD.csv`

---

## Common mistakes

| Mistake | Fix |
|---------|-----|
| Train hosts in `Epic-Production` scope | Enforce `env=production` in every filter |
| Shared Oracle hosts used by non-Epic apps | Split by process or secondary label `app_owner` |
| Missing LB real-server visibility | Install agents on pool members, not only VIP |

---

**Phase 1 complete.** Proceed to [`phase-2-visibility/README.md`](../phase-2-visibility/README.md)
