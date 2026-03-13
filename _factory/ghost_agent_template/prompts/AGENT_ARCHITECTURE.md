# {{AGENT_NAME}} — Architecture Template

## Purpose
Internal implementation reference for `{{AGENT_ID}}`.
Covers wiring, contracts, storage, validation, and execution controls.

## Prompt vs Architecture Split
- Prompt owns: behavior, tone, decision framing.
- Architecture owns: implementation, task contracts, schemas, data sources, persistence.

## Canonical Capabilities
| capability | task_id | task_path |
|---|---|---|
| log | {{TASK_ID}} | {{TASK_PATH}} |
| update | {{TASK_ID}} | {{TASK_PATH}} |
| report | {{TASK_ID}} | {{TASK_PATH}} |
| analyze | {{TASK_ID}} | {{TASK_PATH}} |
| prescribe | {{TASK_ID}} | {{TASK_PATH}} |

## Task Contract System
Each task folder should contain:
- `input.schema.json`
- `output.schema.json`
- `output.format.md`
- `examples.json`
- `query.template.sql`

## Template-first Execution Rule
For SQL-backed capabilities, use `query.template.sql` by default.
Inline query fallback is allowed only on explicit template failure and must be declared.

## Data Sources
- Primary backend: `duckdb`
- Primary location/identifier: `{{DB_PATH}}`
- Main table: `{{PRIMARY_TABLE}}`
- Target table (if enabled): `{{TARGETS_TABLE}}`

## Validation Checklist
- JSON/YAML parse passes for all task/governance/protocol files.
- Task schemas align with output format and examples.
- Boundaries and redirects are present in agent spec.
