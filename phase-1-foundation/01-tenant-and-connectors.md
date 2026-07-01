# Step 1.1 — Tenant and connectors

## 1. Verify CSW tenant access

1. Log in to CSW SaaS or on-prem console.
2. Confirm **Administration → About** shows expected cluster and version.
3. Create role-separated accounts:
   - `csw-epic-admin` — policy publish (production)
   - `csw-epic-readonly` — ADM review, audit exports
   - `csw-epic-pov` — POV environment only (if separate tenant)

## 2. Configure Secure Workload Edge (if on-prem connectors)

For SaaS tenants connecting to on-prem Epic VLANs:

1. Deploy Edge appliance per Cisco guide.
2. Confirm Edge → CSW cloud on TCP 443.
3. Register Edge in **Platform → Edges**.

> Private subnets with no inbound Internet: use
> [csw-secure-connector](https://github.com/chandrapati/csw-secure-connector)
> instead of or in addition to Edge.

## 3. Optional connectors (recommended order)

| Order | Connector | Epic benefit |
|-------|-----------|--------------|
| 1 | VMware vCenter | VM name, cluster, port group labels |
| 2 | ServiceNow | `epic_tier` from CMDB CI class |
| 3 | Active Directory | Clinician / service account identity labels |
| 4 | Cloud (Azure/AWS) | If Epic modules run in cloud |

### ServiceNow label mapping example

```text
CMDB field u_epic_tier  →  CSW label epic_tier
CMDB field u_environment → CSW label env
CMDB class = epic_server → CSW label app=epic
```

## 4. Enable audit logging

**Administration → Audit Log** — confirm events record:
- Scope changes
- Policy publish
- Enforcement mode changes

Export sample for HIPAA evidence folder.

## 5. Document tenant facts

| Field | Value |
|-------|-------|
| Tenant URL | |
| CSW version | |
| Edge name(s) | |
| Connectors enabled | |
| POV start date | |

---

**Next:** [`02-scope-hierarchy.md`](./02-scope-hierarchy.md)
