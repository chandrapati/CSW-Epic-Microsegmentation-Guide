# Prerequisites

Complete before Phase 1. Use as a customer-facing checklist in POV kickoff.

---

## Stakeholders

| Role | Responsibility in this program |
|------|-------------------------------|
| **CISO / Security lead** | Scope approval, enforce go/no-go |
| **Epic technical director / TS liaison** | Tier list, port matrix, change windows |
| **Infrastructure / compute** | Agent install on Windows/Linux Epic hosts |
| **Network team** | Confirm no conflict with existing firewalls; SPAN not required for CSW agents |
| **Compliance / privacy** | HIPAA boundary definition, BAA scope |
| **Clinical operations** | Sign off on ADM clusters (what is production-critical) |
| **Cisco account team** | Sizing, release-specific features, support |

---

## CSW platform

- [ ] CSW SaaS tenant or on-prem cluster provisioned
- [ ] Admin accounts + RBAC roles assigned (separate prod vs POV admins)
- [ ] Outbound **TCP 443** from every Epic server to CSW cluster allowed
- [ ] NTP synchronized on Epic hosts (agent cert and log correlation)
- [ ] Change ticket template for agent install and enforce events

### Optional connectors (recommended)

| Connector | When needed |
|-----------|-------------|
| **VMware / hypervisor** | VM metadata labels |
| **ServiceNow** | CMDB-driven `epic_tier` labels |
| **AWS / Azure** | Epic modules in cloud |
| **Active Directory / Entra** | User/group context for investigations — see [Identity Guide](https://github.com/chandrapati/CSW-Identity-Integration-Guide) |
| **Secure Connector** | Epic subnets with no inbound Internet — see [csw-secure-connector](https://github.com/chandrapati/csw-secure-connector) |

---

## Epic environment inputs (from customer)

Request these artifacts in writing:

- [ ] Current **Network Requirements** / firewall matrix from Epic
- [ ] Interconnect specification (HL7, FHIR, partner list)
- [ ] Host inventory by tier (web, app, db, integration, reporting)
- [ ] Train vs production host naming convention
- [ ] Maintenance windows (patch Tuesday, Clarity/Caboodle batch schedule)
- [ ] List of break-glass / jump hosts for admin access

---

## Agent compatibility

- [ ] OS versions for all Epic tiers documented (Windows Server, RHEL, etc.)
- [ ] Antivirus exclusions for CSW agent processes (per Cisco Hardening Guide)
- [ ] Epic vendor approval for third-party agents on database tier (if required)
- [ ] Deployment method chosen: manual, SCCM, Ansible — see [Agent Installation Guide](https://github.com/chandrapati/CSW-Agent-Installation-Guide)

### Suggested POV coverage (minimum)

| Tier | Hosts (example POV) |
|------|---------------------|
| Web | 2 |
| Application | 3–5 (include Chronicles) |
| Integration | 1–2 (Interconnect) |
| Reporting | 1–2 (Clarity or ETL) |
| Database | 1–2 (non-prod first if policy requires) |
| Clinical access | 2 VDI or Citrix workers |

---

## Network and security

- [ ] Existing perimeter firewalls documented — CSW is **additive** host enforcement
- [ ] Load balancer / VIP flows understood (ADM may show LB IP, not real server)
- [ ] Asymmetric routing ruled out or documented on Epic VLANs
- [ ] SIEM destination for CSW alarms (optional Phase 5)

---

## API access (optional, for automation)

```bash
export CSW_API_URL="https://your-tenant.tetrationcloud.com"
export CSW_API_KEY="..."
export CSW_API_SECRET="..."
```

Use [CSW-POV-Tooling](https://github.com/chandrapati/CSW-POV-Tooling) scripts.
**Never commit credentials** to this repo or customer git.

---

## Change-control gates

Treat these as **customer approval required**:

| Action | Risk |
|--------|------|
| Agent install on production DB | OS-level software on critical tier |
| Policy publish | New rules staged to cluster |
| Simulation → Enforce | Traffic may be blocked |
| Scope commit | Inventory membership changes |

---

## Next step

[`phase-1-foundation/README.md`](../phase-1-foundation/README.md)
