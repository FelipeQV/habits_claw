# DEPRECATED (Legacy)
This implementation note is deprecated and superseded by:
- capabilities_standards/agents/mindy/agent_spec.yaml
- capabilities_standards/agents/mindy/tasks/log_meal/
- capabilities_standards/agents/mindy/tasks/update_meal/

# Mindy log_meal-only v1 Implementation Guide

## Flow (v1)
1. Parse incoming `log_meal` request.
2. Validate input and output against protocol schemas.
3. Insert a single row into DuckDB `meals` table.
4. Return canonical JSON envelope, then a short human confirmation.

## Minimal SQL Insert Example

```sql
INSERT INTO meals (date, meal_type, items, kcal, protein_g, carbs_g, fat_g, fiber_g, notes)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
```

## Canonical Return Pattern
- `protocol_version` must be `1.0.0`
- `task` must be `log_meal`
- `meta.source` must be `duckdb`
- Envelope must satisfy `capabilities_standards/agents/mindy/tasks/log_meal/output.schema.json`

Human confirmation example:
- "Logged lunch for 2026-03-09: chicken salad."

## Acceptance Tests (v1)
1. **Happy path**: valid input inserts exactly one `meals` row and returns `ok=true`, `error=null`, `data` object.
2. **Validation failure**: missing required field (e.g., `items`) returns `ok=false` with `error.code=VALIDATION_ERROR` and no DB write.
3. **DB failure**: simulated SQL/connection error returns `ok=false` with `error.code` in DB error set (e.g., `DB_QUERY_ERROR`).
