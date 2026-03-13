# {{AGENT_NAME}} Agent Contracts

## Scope
- Active specialized tasks owned by `{{AGENT_ID}}`
- Backend: `duckdb` (`{{DB_PATH}}`)
- Payload contracts are stable across channels

## Task Contracts

### {{TASK_ID}}
Required:
- domain-required input field keys

Behavior:
- Apply capability-specific policy in agent spec.
- Respect correction/inference rules from subtype binding.

Returns (typical):
- execution status
- normalized result object
- `meta.trace_id`

## Canonical Task Artifact Location
- `capabilities_standards/agents/_agent_template/tasks/_task_template/*`
