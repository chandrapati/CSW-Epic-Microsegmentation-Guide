# Step 1.2 — Epic scope hierarchy

Build the CSW scope tree that mirrors Epic tiers and HIPAA boundaries.

---

## 1. Create root scope

**Defend → Scopes → New Scope**

| Field | Value |
|-------|-------|
| Name | `Healthcare-Org` |
| Description | Organization root — all healthcare workloads |
| Parent | (none) |

## 2. Create Epic production subtree

Under `Healthcare-Org`, create:

| Scope name | Maps to tier | Notes |
|------------|--------------|-------|
| `Epic-Production` | Parent | Production Epic boundary |
| `Epic-Clinical-Access` | T0 | VDI, Citrix, clinical jump hosts |
| `Epic-Web` | T1 | OHS, web front ends |
| `Epic-Application` | T2 | Chronicles, module app servers |
| `Epic-Integration` | T3 | Interconnect, Bridges, API gateways |
| `Epic-Reporting` | T4 | Clarity, Caboodle, ETL |
| `Epic-Database` | T5 | ODB, Clarity DB, Caboodle DB |
| `Shared-Infrastructure` | T6 | AD, DNS, backup, monitoring |

## 3. Create non-production scopes

| Scope name | Purpose |
|------------|---------|
| `Epic-Train` | Training environment — **never** merge policy with prod |
| `Epic-Dev` | Build/test — optional for POV |

## 4. Create compliance overlay scope (optional)

| Scope name | Purpose |
|------------|---------|
| `PHI-Zone` | Cross-cutting ePHI boundary for HIPAA exports |

`PHI-Zone` may **include** workloads from multiple tiers via filters
(`compliance=hipaa` OR `data=phi`). Use for audit reports that span tiers.

## 5. Assign scope owners

| Scope | Owner team | CSW RBAC role |
|-------|------------|---------------|
| Epic-Application | Epic platform | Epic-Policy-Admin |
| Epic-Database | Epic DBA + security | Epic-DB-Admin (limited) |
| Epic-Integration | Interface team | Epic-Integration-Admin |

## 6. Verification

```text
Investigate → Inventory → filter by scope "Epic-Production"
```

Initially empty — populated in Step 1.3 and Phase 2.

---

## Scope diagram

```text
Healthcare-Org
├── Epic-Production
│   ├── Epic-Clinical-Access
│   ├── Epic-Web
│   ├── Epic-Application
│   ├── Epic-Integration
│   ├── Epic-Reporting
│   └── Epic-Database
├── Epic-Train
├── PHI-Zone (filter-driven overlay)
└── Shared-Infrastructure
```

---

**Next:** [`03-labels-and-filters.md`](./03-labels-and-filters.md)
