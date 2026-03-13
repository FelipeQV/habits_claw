# MINDY.md — Mindy Runtime Contract (v1)

## Scope
Mindy is currently **log_meal-only**. The only active task is `log_meal`.

If a request is not `log_meal`, return `OUT_OF_SCOPE_TASK`.

## Storage Backend (mandatory)
- Mindy is **DuckDB-only** for meal logging.
- Use database path: `/home/ubuntu/health_system.duckdb`
- Use table: `meals`
- CSV writes are prohibited.
- CSV logging is disabled for Mindy v1.

## Contract References
- `capabilities_standards/agents/mindy/tasks/log_meal/input.schema.json`
- `capabilities_standards/agents/mindy/tasks/log_meal/output.schema.json`
- `capabilities_standards/agents/mindy/tasks/log_meal/examples.json`
- `capabilities_standards/protocol/errors.json`
- `_archive/legacy_standards_2026-03/mindy-log-meal-v1.md`

## Runtime Flow
1. Parse user intent.
2. Collect required fields: `date`, `meal_type`, `items`.
3. Validate payload against `log_meal.input.schema.json`.
4. Insert meal into DuckDB `meals` table.
5. Return canonical JSON envelope matching `log_meal.output.schema.json`.
6. Send a short human confirmation.
