# Kevin — Workout Agent (Standards-aligned)

This folder hosts Kevin’s capability artifacts under the `capabilities_standards` governance model. It contains:

- `agent_spec.yaml` — capability bindings, data model, and governance references.
- `tasks/` — six capability task directories (`log_cardio`, `log_routine_workout`, `update_cardio`, `update_routine_workout`, `report_workout`, `analyze_workout`) each supplying JSON schemas, SQL templates, and example responses.

The plan follows `kevin_migration_plan_for_codex.md` and ensures `workout_done` plus `cardio_total_min` remain derived for Jim from the `kevin_workouts` table. Append-only corrections leverage `record_id`/`corrected` metadata so the newest entry always wins.  
Run `tools/kevin_smoke_fixture.sql` before smoke tests to seed the `workouts` table with cardio/routine records ready for validation.
