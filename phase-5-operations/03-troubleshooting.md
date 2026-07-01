# Step 5.3 — Troubleshooting

Symptom-first flowchart for Epic + CSW enforcement issues.

---

## "Hyperspace / clinical access broken after enforce"

```text
1. Is outage on web tier or app tier?
   → Check Denied Connections for clinical → web 443
2. Workspace still in Enforce?
   → Temporary: set Monitor on Epic-Web workspace
3. LB health checks blocked?
   → Add allow from LB subnet (see Simulation false positive)
4. Wrong test timing?
   → Compare T_test vs T_host_apply from log bundle
5. Path bypass?
   → User on VPN hitting alternate VIP not in policy
```

---

## "HL7 / interface messages failing"

```text
1. Denied Connections on integration host — note 5-tuple
2. Partner IP changed? Update allowlist + partner label
3. Port not 2575? ADM re-export; Epic Interconnect matrix
4. Async ACK path blocked? Allow return path app → partner
5. quick_analysis on message 5-tuple
```

---

## "Clarity / ETL batch failed overnight"

```text
1. Confirm batch start time vs enforce enable time
2. Simulation missed monthly window? Extend ADM + re-simulate
3. ETL uses secondary port? Add from ADM evidence
4. Consider time-bound allow for batch window only
```

---

## "Policy shows enforce but traffic not blocked"

| Layer | Check |
|-------|-------|
| Control plane | `enforcement_enabled` on workspace |
| Agent | `enforcement_status` = enforcing on **both** src and dst |
| Policy version | Enforced version = analyzed version under test |
| Host | Log bundle — rule in nftables? |
| Path | Asymmetric routing, LB, host firewall conflict |

Deep dive: [phase-4-enforcement/03-host-side-validation.md](../phase-4-enforcement/03-host-side-validation.md)

---

## "Agent unhealthy on Epic DB server"

```text
1. TCP 443 outbound to CSW cluster?
2. AV blocking agent process?
3. Disk full on /opt/cisco?
4. Cert rotation — re-register agent
5. Epic DBA maintenance — coordinate read-only agent restart window
```

---

## Escalation

| Level | Contact |
|-------|---------|
| L1 | Epic ops + CSW admin on bridge |
| L2 | Cisco TAC (CSW) + Epic TS |
| L3 | Disable enforce on affected scope; executive notification |
