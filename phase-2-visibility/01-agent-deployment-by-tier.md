# Step 2.1 — Agent deployment by Epic tier

Install CSW agents in **monitor mode** first (default). No enforcement
until Phase 4.

---

## Deployment order (recommended)

Deploy in this order to unblock ADM quickly while derisking database tier:

| Order | Tier | Rationale |
|-------|------|-----------|
| 1 | Epic-Web | Low risk; validates 443 to CSW |
| 2 | Epic-Application | Core ADM signal |
| 3 | Epic-Integration | Partner/HL7 paths |
| 4 | Epic-Reporting | ETL batch patterns |
| 5 | Epic-Clinical-Access | User egress patterns |
| 6 | Epic-Database | Highest change control — last |

---

## Per-OS install (summary)

### Linux (RHEL / Oracle Linux common on Epic app/db)

```bash
# Download agent RPM from CSW console: Manage → Agents → Download
sudo rpm -ivh csw-agent-*.rpm
sudo /opt/cisco/secure-workload/bin/csw-agent register \
  --cluster your-tenant.tetrationcloud.com \
  --activation-code <from-console>
sudo systemctl enable --now csw-agent
```

### Windows Server (common on web, Clarity, Interconnect)

1. Download MSI from CSW console.
2. Install silently via SCCM — see [CSW-Agent-Installation-Guide](https://github.com/chandrapati/CSW-Agent-Installation-Guide).
3. Verify service **Cisco Secure Workload Agent** running.

---

## Tier-specific notes

### T1 — Web

- Install on **each pool member** behind load balancer.
- ADM will show flows to app tier — VIP-only installs miss backend paths.

### T2 — Application (Chronicles)

- Expect high east-west between app servers — normal.
- Capture **month-end** or **payroll** batch if applicable.

### T3 — Integration (Interconnect)

- Document every partner IP/FQDN from ADM — becomes allowlist in Phase 3.
- HL7 MLLP may use non-2575 ports — trust ADM, not assumptions.

### T4 — Reporting (Clarity / Caboodle)

- Batch jobs often run overnight — ADM must span **≥14 days**.

### T5 — Database

- Coordinate with Epic DBA and vendor policy on third-party agents.
- Start with **read replica** or **train** DB if prod install blocked for POV.

### T0 — Clinical access

- VDI: agent on golden image or persistent VMs.
- Citrix: install on VDAs serving Hyperspace.

---

## Post-install verification

| Check | Where | Pass |
|-------|-------|------|
| Agent registered | Manage → Agents | Status = healthy |
| Flows appearing | Investigate → Flows | Recent flows from host |
| Enforcement mode | Agent detail | Monitor (not enforce) |
| Labels present | Inventory | `app=epic`, `epic_tier` set |

---

## API check (optional)

```bash
python3 csw_api.py GET /openapi/v1/sensors | jq '.[] | select(.hostname|test("epic";"i")) | {hostname, status}'
```

---

**Next:** [`02-adm-configuration.md`](./02-adm-configuration.md)
