# Evidence matrix — Epic microsegmentation POV

Map common microsegmentation requirements to evidence artifacts and
scoring status.

**Scoring:** Pass · Pass — design validated · Partial · Not tested · Confirm with Cisco

---

## Visibility (requirements 3.x)

| Req | Description | Primary evidence | Secondary | Typical score |
|-----|-------------|------------------|-----------|---------------|
| 3.1 | L3/L4 flow visibility | ADM + flow export | API flow_search | Pass |
| 3.2 | Process context | ADM with process enabled | Inventory process column | Pass |
| 3.3 | Dependency mapping | ADM diagram Epic tiers | Epic TS sign-off | Pass |
| 3.4 | Label / grouping | Label inventory | ServiceNow connector | Pass / Partial |

---

## Enforcement (requirements 4.x)

| Req | Description | Primary evidence | Secondary | Typical score |
|-----|-------------|------------------|-----------|---------------|
| 4.1 | Monitor vs enforce modes | Workspace mode screenshot | Agent status | Pass |
| 4.2 | Allow / deny tests | Functional test sheet | Denied Connections | Pass |
| 4.3 | Host firewall method | Agent mode + log bundle | nftables dump | Pass |
| 4.4 | Granularity L3/L4 | Policy 5-tuple rules | quick_analysis | Pass |
| 4.5 | Process granularity | Process-qualified rule | OS matrix note | Partial |

---

## Epic-specific extensions

| Req | Description | Primary evidence | Typical score |
|-----|-------------|------------------|---------------|
| E-01 | Tier isolation web→app→db | Tier policy export | Pass |
| E-02 | Clinical cannot reach DB direct | Negative test clinical→ODB | Pass |
| E-03 | Interconnect partner allowlist | Integration policy + ADM | Pass |
| E-04 | Train/prod separation | Deny rule + label proof | Pass |
| E-05 | Clarity ETL path only to reporting DB | ADM + allow rules | Partial |

---

## Integrations (requirements 8.x)

| Req | Description | Primary evidence | Typical score |
|-----|-------------|------------------|---------------|
| 8.1 | ServiceNow labels | Connector status + sample CI | Partial |
| 8.2 | AD / Entra identity | Identity connector inventory | Partial |
| 8.3 | SIEM export | Sample alarm / syslog | Not tested |

---

## Policy lifecycle (requirements 10.x)

| Req | Description | Primary evidence | Typical score |
|-----|-------------|------------------|---------------|
| 10.1 | ADM → policy | Import screenshot | Pass |
| 10.2 | Simulation | Simulation report | Pass |
| 10.3 | Publish / version | Version history | Pass |
| 10.4 | Enforce enablement | Enforce sequence doc | Pass |
| 10.5 | OpenAPI automation | API script output | Partial |

---

## Compliance (requirements 13.x)

| Req | Description | Primary evidence | Typical score |
|-----|-------------|------------------|---------------|
| 13.1 | HIPAA segmentation evidence | Quarterly pack sample | Pass — design validated |
| 13.2 | Audit log | Administration export | Pass |
| 13.3 | RBAC | Role screenshot | Pass |

---

## Open items log (template)

| ID | Item | Owner | Target date |
|----|------|-------|-------------|
| | | | |
