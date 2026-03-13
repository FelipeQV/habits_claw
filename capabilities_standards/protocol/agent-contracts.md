# Agent Contracts v1 (Capability-Agnostic Skeleton)

## Non-negotiable
- A declared backend is the source of truth for task execution.
- Agents must not invent envelope fields or break schema contracts.
- If required input is missing, return a structured error.
- JSON envelope first, optional human text second.

## Capability Task Set (Protocol-Level)
- `log`
- `update`
- `report`
- `analyze`
- `prescribe`

> Domain/task specializations (for example, `log_<domain_item>`) are owned by each agent in its own contracts file and must not be defined at protocol level.

## Canonical Envelope

```json
{
  "protocol_version": "1.0.0",
  "task": "<capability_or_specialized_task>",
  "ok": true,
  "data": {},
  "error": null,
  "meta": {
    "source": "<backend>",
    "timestamp": "<ISO-8601>",
    "trace_id": "<id>",
    "agent_id": "<agent>"
  }
}
```

## Generic Capability Contract Templates

### log
Required:
- `payload` (object with domain-defined required fields)

Optional:
- `timestamp`
- `idempotency_key`
- domain metadata fields

Action:
- Persist one new record/event according to domain policy.

Returns (`data`):
- `record_id`
- `stored_at`
- optional normalized fields

---

### update
Required:
- `selector` (deterministic way to find target)
- `updates` (at least one mutable field)

Optional:
- `strategy` (`replace` | `append_only` | domain-defined)
- `reason`

Action:
- Apply domain-defined update semantics to matched record(s).

Returns (`data`):
- `matched_count`
- `updated_count`
- optional `new_record_id` / `revision_id`

---

### report
Required:
- exactly one `timeframe_selector` (`date` OR `from`+`to` OR equivalent)

Optional:
- domain filters
- `include_entries` (default domain-defined)

Action:
- Produce factual aggregation/summary for the selected scope.

Returns (`data`):
- `timeframe`
- `totals` (domain-defined metrics)
- `count`
- optional `entries`
- optional `data_quality`

---

### analyze
Required:
- exactly one `timeframe_selector`

Optional:
- domain filters
- `include_evidence` (default domain-defined)

Action:
- Produce non-definitive pattern analysis for selected scope.

Returns (`data`):
- `timeframe`
- `findings[]`
- `confidence` (`level`, `basis[]`)
- optional `evidence_summary`
- optional `follow_up_recommendations`

Boundary:
- Must respect confidence signaling and domain safety policy.

---

### prescribe
Required:
- `goal` or `problem_statement`
- domain context required by agent policy

Optional:
- constraints/preferences
- risk tolerance / guardrail settings

Action:
- Produce bounded, policy-compliant recommendation options.

Returns (`data`):
- `options[]`
- `rationale`
- `safety_notes`
- `next_actions`

Boundary:
- Must include escalation/delegation path when outside domain scope.
