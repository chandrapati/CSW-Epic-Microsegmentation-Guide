# Step 2.3 — Flow baseline checklist

Sign-off document before any policy is authored. Epic TS and security
both sign.

---

## Inventory coverage

| Tier | POV hosts planned | Agents healthy | % coverage |
|------|-------------------|----------------|------------|
| Clinical access | | | |
| Web | | | |
| Application | | | |
| Integration | | | |
| Reporting | | | |
| Database | | | |

**Target:** ≥95% on POV host list; document exceptions.

---

## ADM cluster sign-off

| ADM cluster name | Epic application (official) | Tier | Owner sign-off |
|------------------|----------------------------|------|----------------|
| | | | |
| | | | |

---

## Approved flow matrix (seed for Phase 3)

Document **expected** flows Epic TS agrees should exist:

| Source tier | Destination tier | Ports | Protocol / app | Business justification |
|-------------|------------------|-------|----------------|------------------------|
| clinical-access | web | 443 | HTTPS / Hyperspace | User access |
| web | app | 443 | HTTPS | Presentation to app |
| app | db | *ADM* | Chronicles | Transactional DB |
| integration | app | *ADM* | HL7 / APIs | Interface engine |
| reporting | db | *ADM* | ETL | Analytics pipeline |
| all | shared-infra | 53, 88, 636 | DNS, Kerberos, LDAPS | Identity |

Ports in *italics* must be filled from ADM export — not guessed.

---

## Anomalies and remediation

| Flow observed | Risk | Remediation before enforce |
|---------------|------|---------------------------|
| | | |

---

## Sign-off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Epic technical lead | | | |
| Security architect | | | |
| Compliance (optional) | | | |

---

**Phase 2 complete.** Proceed to [`phase-3-policy-modeling/README.md`](../phase-3-policy-modeling/README.md)
