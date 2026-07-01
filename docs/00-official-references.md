# Official references

Cross-reference for Cisco Secure Workload and Epic-related documentation.
**When this guide and vendor docs disagree, vendor docs win.**

## Cisco Secure Workload

| Topic | Link |
|-------|------|
| Product overview | [Cisco Secure Workload](https://www.cisco.com/c/en/us/products/security/workload-security/index.html) |
| SaaS User Guide 4.0 | [User Guide — SaaS v4.0](https://www.cisco.com/c/en/us/td/docs/security/workload_security/secure_workload/user-guide/4_0/cisco-secure-workload-user-guide-saas-v40.html) |
| On-Prem User Guide 4.0 | [User Guide — On-Prem v4.0](https://www.cisco.com/c/en/us/td/docs/security/workload_security/secure_workload/user-guide/4_0/cisco-secure-workload-user-guide-on-prem-v40.html) |
| Agent installation | [Install and Manage Agents](https://www.cisco.com/c/en/us/td/docs/security/workload_security/secure_workload/user-guide/4_0/cisco-secure-workload-user-guide-saas-v40/m-install-and-manage-agents.html) |
| Connectors | [Configure and Manage Connectors](https://www.cisco.com/c/en/us/td/docs/security/workload_security/secure_workload/user-guide/4_0/cisco-secure-workload-user-guide-saas-v40/m-connectors.html) |
| Segmentation / policy | [Segmentation Policies](https://www.cisco.com/c/en/us/td/docs/security/workload_security/secure_workload/user-guide/4_0/cisco-secure-workload-user-guide-saas-v40/m-segmentation-policies.html) |
| OpenAPI | [CSW OpenAPI documentation](https://www.cisco.com/c/en/us/support/security/workload-security/products-programming-reference-guides-list.html) |

## Epic Systems (customer-facing)

Epic documentation is available to organizations under Epic subscription.
Common starting points (login required at [Epic on the Web](https://open.epic.com/)):

| Topic | Typical Epic source |
|-------|---------------------|
| System topology | Technical Overview / Hardware and Software Requirements |
| Network requirements | Network Requirements guide (ports, firewall rules) |
| Interconnect | Interconnect specification (HL7, FHIR, port matrix) |
| Clarity / Caboodle | Reporting database architecture guides |
| Security | Security and Privacy documentation |

> **Practical note.** Export your site's **Network Requirements** and
> **Interconnect port list** before Phase 3 policy authoring. CSW ADM will
> show what actually runs; Epic docs show what was *designed*.

## Healthcare compliance (CSW mapping)

| Framework | Community runbook | Pair with this Epic guide |
|-----------|-------------------|---------------------------|
| HIPAA Security Rule | [HIPAA](./HIPAA/CSW-HIPAA-Technical-Runbook.md) · [repo](https://github.com/chandrapati/CSW-Compliance-Mapping/tree/main/HIPAA) | Phase 5 quarterly pack |
| HIPAA 2025 NPRM (proposed) | [NPRM](./HIPAA-2025-NPRM/CSW-HIPAA-NPRM-Technical-Runbook.md) | Mandatory segmentation narrative |
| HITRUST CSF | [HITRUST](./HITRUST-CSF/CSW-HITRUST-Technical-Runbook.md) | Multi-framework healthcare assessments |
| **Epic EHR microsegmentation** | [**CSW-Epic-Microsegmentation-Guide**](https://github.com/chandrapati/CSW-Epic-Microsegmentation-Guide) | **Step-by-step Epic tier rollout** — scopes, ADM, Interconnect, enforce |

## Related community guides (this author)

- [CSW-Identity-Integration-Guide](https://github.com/chandrapati/CSW-Identity-Integration-Guide) — AD / Entra / ISE identity in policy
- [CSW-Policy-Lifecycle](https://github.com/chandrapati/CSW-Policy-Lifecycle) — publish, enforce, drift
- [CSW-Agent-Installation-Guide](https://github.com/chandrapati/CSW-Agent-Installation-Guide) — enterprise agent rollout
- [csw-secure-connector](https://github.com/chandrapati/csw-secure-connector) — reach private Epic subnets
