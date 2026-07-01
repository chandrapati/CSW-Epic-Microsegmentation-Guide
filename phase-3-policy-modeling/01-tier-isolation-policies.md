# Step 3.1 — Tier isolation policies

Author workspace policies that enforce Epic tier boundaries.

---

## 1. Create policy workspaces

**Defend → Segmentation → New Workspace**

| Workspace name | Scope | Mode (initial) |
|----------------|-------|----------------|
| `Epic-DB-Isolation` | Epic-Database | Simulation |
| `Epic-App-Isolation` | Epic-Application | Simulation |
| `Epic-Integration-Isolation` | Epic-Integration | Simulation |
| `Epic-Web-Isolation` | Epic-Web | Simulation |

Start POV enforce pilot on **Epic-Integration** or **Epic-Application** —
not database first.

## 2. Import ADM policies

Within each workspace:

1. **Actions → Import from ADM** — select `Epic-Production-ADM`.
2. Review auto-generated allows — ADM is permissive by design.
3. Add **explicit denies** below.

## 3. Baseline deny rules (all Epic production scopes)

```text
DENY  any  →  Epic-Database     (scope match: dst in Epic-Database)
      except rules below

DENY  Epic-Clinical-Access  →  Epic-Database   (no direct clinician-to-DB)

DENY  Epic-Train  →  Epic-Production           (label env=train → env=production)

DENY  any  →  internet                       (from scopes with data=phi)
      except Shared-Infrastructure updates / CSW cluster
```

## 4. Tier allow rules (template — replace ports from ADM)

### Epic-Web workspace

```text
ALLOW  Epic-Clinical-Access  →  Epic-Web     tcp/443
ALLOW  Epic-Web              →  Epic-Application  tcp/443
ALLOW  Epic-Web              →  Shared-Infrastructure  tcp/443,636,53
LOG    any                   →  Epic-Web     (unmatched inbound)
```

### Epic-Application workspace

```text
ALLOW  Epic-Web         →  Epic-Application   tcp/443
ALLOW  Epic-Application →  Epic-Application   tcp/443  (east-west — tighten to ADM pairs)
ALLOW  Epic-Application →  Epic-Database      tcp/<from-ADM>
ALLOW  Epic-Integration →  Epic-Application   tcp/<from-ADM>
ALLOW  Epic-Application →  Shared-Infrastructure  tcp/636,88,53
```

### Epic-Database workspace

```text
ALLOW  Epic-Application →  Epic-Database   tcp/<from-ADM>
ALLOW  Epic-Reporting   →  Epic-Database   tcp/<from-ADM>  (ETL only — verify not ODB)
DENY   any              →  Epic-Database   (catch-all)
```

## 5. Process-aware rules (where supported)

Tighten allows using process context from ADM:

```text
ALLOW  Epic-Application → Epic-Database
       when process_name contains "chronicles" OR "wbs"
       tcp/1521
```

Confirm process-based policy support for your OS mix and CSW release.

## 6. Publish analyzed version

1. **Publish** workspace policies to analyzed version.
2. Keep workspace in **Simulation** — not Enforce.
3. Export policy JSON/CSV for change record.

---

## quick_analysis (pre-enforce test)

Before Simulation completes, validate a known 5-tuple:

```bash
python3 csw_api.py POST /openapi/v1/policies/{rootScopeID}/quick_analysis \
  --json '{
    "src_ip": "10.1.2.10",
    "dst_ip": "10.1.5.20",
    "dst_port": 1521,
    "protocol": "tcp"
  }'
```

Expected: `action: allow` for app→db; `deny` for clinical→db.

---

**Next:** [`02-interconnect-and-hl7.md`](./02-interconnect-and-hl7.md)
