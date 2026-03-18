# Pam Agent Contracts

Purpose:
Capture Pam-owned contract details for reading and todo operations.

## Scope
- Active specialized tasks: `add_reading_item`, `categorize_reading_item`, `list_unread_reading`, `mark_reading_as_read`, `search_reading`, `add_todo`, `update_todo_status`, `prioritize_todos`, `list_focus_queue`, `remind_focus`
- Data backend: DuckDB (`/home/ubuntu/health_system.duckdb`)
- Domain ownership: Organization dimension only (Reading DB + Todo DB)

## Key Rules
- Every reading item must include at least one category.
- Reading status supports `unread` and `read`.
- Todo lifecycle supports `active`, `completed`, and `deferred`.
- Reminder output is concise and actionable.
- No fixed category ontology is enforced.
