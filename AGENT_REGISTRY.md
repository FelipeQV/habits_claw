# AGENT_INVENTORY.md

| agent_id | name | dimension | description | status | channel | spec_path | spec_version | active_tasks | notes |
|---|---|---|---|---|---|---|---|---|---|
| main | Main | orchestration | Primary orchestration agent handling routing and coordination across agents. | active | webchat | — | — | routing, coordination | — |
| jim | Jim | daily_management | Daily management agent for journaling and routine tracking workflows. | active | telegram | capabilities_standards/agents/jim/agent_spec.yaml | 1.3 | log_daily_log (planned) | — |
| mindy | Mindy | nutrition | Nutrition tracking agent for meal logging and meal update operations. | active | telegram | capabilities_standards/agents/mindy/agent_spec.yaml | 1.3 | log_meal, update_meal | DuckDB-only enforcement is active. |
| kevin | Kevin | workout | Workout agent for training-related logging and workflow support. | active | telegram | capabilities_standards/agents/kevin/agent_spec.yaml | 1.0 | log_cardio, log_routine_workout, report_workout, analyze_workout | pending updates to regressions |
| pam | Pam | organization | Organization agent for reading/todo capture, triage, and focus reminders. | active | telegram | capabilities_standards/agents/pam/agent_spec.yaml | 1.0 | add_reading_item, categorize_reading_item, list_unread_reading, mark_reading_as_read, search_reading, add_todo, update_todo_status, prioritize_todos, list_focus_queue, remind_focus | standards migration draft |
| automation | Automation Agent | file_operations | Internal automation agent responsible for file operations and workspace mutations. | active | internal | — | — | file mutations | Delegated file mutations. |

## Conventions

- `spec_path` points to the canonical spec.
- `spec_version` mirrors the spec file version.
- `active_tasks` reflects currently enabled tasks.
- `spec_path` `—` means not migrated yet.

## Change Log

- 2026-03-10: Mindy migrated to canonical spec (`capabilities_standards/agents/mindy/agent_spec.yaml`) with spec version `1.3`.
- 2026-03-10: Factory/template-based registry fields deprecated in favor of inventory format with explicit `description` field.
