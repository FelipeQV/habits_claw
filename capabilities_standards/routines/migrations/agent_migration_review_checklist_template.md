# {{AGENT_ID}} Migration Review Checklist

## Reviewer checks
- [ ] Correct branch (not main)
- [ ] Diff limited to migration scope
- [ ] Prompt/architecture separation is clean
- [ ] Canonical task artifacts are complete
- [ ] SQL/templates align with real DB schema
- [ ] Update flows are append-only
- [ ] Downstream required fields remain available
- [ ] Deprecated commands/flows are absent
- [ ] Out-of-repo dependencies explicitly documented
- [ ] Smoke test evidence attached

## Merge gate
- [ ] What changed documented
- [ ] Risks documented
- [ ] What to verify documented
