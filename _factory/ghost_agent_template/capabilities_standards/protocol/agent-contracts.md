# Agent Contracts (Protocol Skeleton)

## Non-negotiable
- Declared backend is source of truth.
- Envelope schema cannot be broken.
- Missing required inputs return structured errors.
- JSON envelope first; human rendering optional.

## Capability Set
- `log`
- `update`
- `report`
- `analyze`
- `prescribe`

## Generic Contract Templates

### log
Required: `payload`
Optional: `timestamp`, `idempotency_key`, domain metadata
Returns: `record_id`, `stored_at`, optional normalized fields

### update
Required: `selector`, `updates`
Optional: `strategy`, `reason`
Returns: `matched_count`, `updated_count`, optional revision identifiers

### report
Required: one timeframe selector
Optional: filters, include_entries
Returns: `timeframe`, `totals`, `count`, optional `entries`, optional `data_quality`

### analyze
Required: one timeframe selector
Optional: filters, include_evidence
Returns: `findings[]`, `confidence`, optional evidence summary

### prescribe
Required: `goal` or `problem_statement`
Optional: constraints, preferences, risk tolerance
Returns: `options[]`, `rationale`, `safety_notes`, `next_actions`
