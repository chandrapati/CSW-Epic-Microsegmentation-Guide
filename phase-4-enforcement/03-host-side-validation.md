# Step 4.3 — Host-side validation

Control-plane checks (CSW UI/API) prove intent; **host-side proof** proves
the rule landed on the Epic server. Use for POV evidence and troubleshooting.

---

## 1. Collect agent diagnostic bundle

**Manage → Agents → [host] → Download Diagnostic Logs**

Or CLI on Linux host:

```bash
sudo /opt/cisco/secure-workload/bin/csw-agent diagnostics collect \
  -o /tmp/epic-host-csw-logs.tar.gz
```

Bundle name pattern: `*_csw-logs`

## 2. What to look for

| Artifact in bundle | Proves |
|--------------------|--------|
| Policy version / timestamp | Rule set applied after `T_apply` |
| nftables / iptables dump | Deny rule present for negative test 5-tuple |
| Enforcement state | Agent in enforce mode |
| EFE delivery timing | Control plane → host latency |

## 3. Parse with CSW-POV-Tooling

```bash
# From CSW-POV-Tooling repo
python3 parse_enforcer_timeline.py /path/to/*_csw-logs.tar.gz
```

Document:
- Policy version applied at `T_host_apply`
- Functional tests must use `T_test > T_host_apply`

See [CSW-POV-Tooling docs/logs-check](https://github.com/chandrapati/CSW-POV-Tooling/tree/main/docs/logs-check).

## 4. Two-host timing comparison (optional)

When app → db test involves two agents, compare both bundles:

```text
App server T_host_apply  vs  DB server T_host_apply
```

Write findings as `CSW-Enforcement-Timing-Comparison-<app>-vs-<db>.md` in
customer POV repo.

## 5. Evidence checklist

- [ ] Bundle collected within 24h of enforce test
- [ ] Negative test 5-tuple appears in deny chain on source or dst host
- [ ] No policy version lag > agreed SLA (document if exceeded)

---

**Phase 4 complete.** Proceed to [`phase-5-operations/README.md`](../phase-5-operations/README.md)
