# PAM_ARCHITECTURE.md

## Purpose
Implementation reference for Pam. This file owns task wiring, schema/contracts, data sources, and execution guardrails.

## Prompt vs Architecture Split
- Prompt owns: conversational behavior, tone, and routing style.
- Architecture owns: task contracts, data model, schema rules, SQL templates, and runtime constraints.

## Decision Priority
1. Safety/policy constraints.
2. User explicit intent.
3. Prompt routing rules.
4. Capability standards governance.
5. Style preferences.

## Canonical Capabilities and Tasks
| capability | task_id | task_path |
|---|---|---|
| log | add_reading_item | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/add_reading_item/ |
| update | categorize_reading_item | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/categorize_reading_item/ |
| report | list_unread_reading | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/list_unread_reading/ |
| update | mark_reading_as_read | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/mark_reading_as_read/ |
| report | search_reading | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/search_reading/ |
| log | add_todo | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/add_todo/ |
| update | update_todo_status | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/update_todo_status/ |
| update | prioritize_todos | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/prioritize_todos/ |
| report | list_focus_queue | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/list_focus_queue/ |
| analyze | remind_focus | /home/ubuntu/.openclaw/workspace/capabilities_standards/agents/pam/tasks/remind_focus/ |

`prescribe` remains orchestration-owned.

## Data Sources
Primary DB: `/home/ubuntu/health_system.duckdb`

Owned tables:
- `pam_reading_items`
- `pam_todos`

## Task Artifact Contract
Each task directory must include:
- `input.schema.json`
- `output.schema.json`
- `output.format.md`
- `examples.json`
- `query.template.sql`

Operational support files per task:
- `task.yaml`
- `README.md`
- `prompt.md`
- `test_cases.md`

## Template-First SQL Rule
For Pam tasks, execute `query.template.sql` by default.
Inline SQL fallback is only allowed if template execution fails explicitly and must be declared in technical telemetry.

## Reading Contract Rules
- `add_reading_item` requires: `url`, `description`, `categories` (min 1).
- Initial reading status is `unread`.
- Allowed reading statuses: `unread`, `read`.
- `mark_reading_as_read` supports both read and reopen (`unread`).
- Search/list filtering supports status/category/keyword/source/date window.
- Taxonomy is open/evolving; no hardcoded global category list.

## Todo Contract Rules
- `add_todo` requires actionable `title`.
- Initial todo status is `active`.
- Allowed todo statuses: `active`, `completed`, `deferred`.
- `prioritize_todos` supports `priority_label` and/or `priority_rank`.
- `list_focus_queue` sorts deterministically by priority, urgency, and recency.

## Reminder Rules
- `remind_focus` generates concise, action-oriented nudges.
- Inputs gate inclusion of reading/todo context.
- Output includes confidence payload (`level`, `basis`) per analyze capability governance.

## Rendering Guardrail
When a capability executes, user-facing output must start with the canonical capability emoji and never expose task IDs.

## Boundary and Redirect
- If request requires cross-domain strategic planning, provide in-scope organization context and redirect strategic remainder to `orchestration_agent`.
- Do not run operations outside Pam-owned tables or contracts.
