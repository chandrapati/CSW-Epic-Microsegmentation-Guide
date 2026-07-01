# Index — jump table

Fast navigation by question, Epic tier, and POV phase.

## By question

| I want to… | Go to |
|---|---|
| Understand Epic tiers and where to put CSW agents | [`docs/01-epic-architecture-tiers.md`](./docs/01-epic-architecture-tiers.md) |
| Learn CSW terms in healthcare language | [`docs/02-csw-primer-healthcare.md`](./docs/02-csw-primer-healthcare.md) |
| Know prerequisites (ports, accounts, change windows) | [`docs/03-prerequisites.md`](./docs/03-prerequisites.md) |
| Find official Cisco / Epic documentation | [`docs/00-official-references.md`](./docs/00-official-references.md) |
| Stand up tenant, connectors, and Epic scope tree | [`phase-1-foundation/README.md`](./phase-1-foundation/README.md) |
| Deploy agents per Epic tier | [`phase-2-visibility/01-agent-deployment-by-tier.md`](./phase-2-visibility/01-agent-deployment-by-tier.md) |
| Run ADM on the Epic estate | [`phase-2-visibility/02-adm-configuration.md`](./phase-2-visibility/02-adm-configuration.md) |
| Build tier-isolation policies | [`phase-3-policy-modeling/01-tier-isolation-policies.md`](./phase-3-policy-modeling/01-tier-isolation-policies.md) |
| Segment Interconnect / HL7 paths | [`phase-3-policy-modeling/02-interconnect-and-hl7.md`](./phase-3-policy-modeling/02-interconnect-and-hl7.md) |
| Run Simulation before enforce | [`phase-3-policy-modeling/03-simulation-workflow.md`](./phase-3-policy-modeling/03-simulation-workflow.md) |
| Enable enforcement safely | [`phase-4-enforcement/01-enforcement-sequence.md`](./phase-4-enforcement/01-enforcement-sequence.md) |
| Run allow/deny functional tests | [`phase-4-enforcement/02-functional-tests.md`](./phase-4-enforcement/02-functional-tests.md) |
| Prove policy on the host (log bundle) | [`phase-4-enforcement/03-host-side-validation.md`](./phase-4-enforcement/03-host-side-validation.md) |
| Build HIPAA quarterly evidence pack | [`phase-5-operations/01-hipaa-evidence-pack.md`](./phase-5-operations/01-hipaa-evidence-pack.md) |
| Integrate with Epic change control | [`phase-5-operations/02-change-management.md`](./phase-5-operations/02-change-management.md) |
| Troubleshoot "policy not working" | [`phase-5-operations/03-troubleshooting.md`](./phase-5-operations/03-troubleshooting.md) |
| Run a POV end-to-end | [`validation/01-pov-test-plan.md`](./validation/01-pov-test-plan.md) |
| Score requirements with evidence | [`validation/02-evidence-matrix.md`](./validation/02-evidence-matrix.md) |

## By Epic tier

| Tier | Typical workloads | Primary phase docs |
|------|-------------------|-------------------|
| Clinical access | VDI, Citrix, Hyperspace clients | Phase 2 agents; Phase 3 clinical→web allow |
| Web / presentation | OHS, reverse proxies, load balancers | Phase 2 ADM; Phase 3 web→app rules |
| Application | Chronicles, OpTime, Willow, Beaker app servers | Phase 2–3 core transactional paths |
| Integration | Interconnect, Bridges, MyChart edge | [`phase-3-policy-modeling/02-interconnect-and-hl7.md`](./phase-3-policy-modeling/02-interconnect-and-hl7.md) |
| Reporting / analytics | Clarity, Caboodle, ETL, Cognos | Phase 3 read-path isolation from production DB |
| Database | Chronicles ODB, Clarity/Caboodle DB | Phase 3 strict default-deny; Phase 4 pilot enforce |
| Shared services | AD, DNS, backup, monitoring, patch | Phase 1 labels; Phase 3 shared-service allowlists |

## By POV phase

| Phase | Activity | Doc |
|---|---|---|
| 1 — Foundation | Tenant, scope tree, labels | [`phase-1-foundation/`](./phase-1-foundation/) |
| 2 — Visibility | Agents + ADM baseline | [`phase-2-visibility/`](./phase-2-visibility/) |
| 3 — Modeling | Policies + Simulation | [`phase-3-policy-modeling/`](./phase-3-policy-modeling/) |
| 4 — Enforcement | Enforce + tests + host proof | [`phase-4-enforcement/`](./phase-4-enforcement/) |
| 5 — Operations | Evidence + change control | [`phase-5-operations/`](./phase-5-operations/) |
| POV scoring | Pass/Partial matrix | [`validation/02-evidence-matrix.md`](./validation/02-evidence-matrix.md) |
