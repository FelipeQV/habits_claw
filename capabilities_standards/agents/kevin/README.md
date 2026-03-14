# Kevin — Workout Agent (Standards-aligned)

This folder hosts Kevin’s capability artifacts under the `capabilities_standards` governance model. It contains:

- `agent_spec.yaml` — capability bindings, data model, and governance references.
- `tasks/` — six capability task directories (`log_cardio`, `log_routine_workout`, `update_cardio`, `update_routine_workout`, `report_workout`, `analyze_workout`) each supplying JSON schemas, SQL templates, and example responses.

The plan follows `kevin_migration_plan_for_codex.md` and ensures `workout_done` plus `cardio_total_min` remain derived for Jim from the `kevin_workouts` table. Append-only corrections leverage `record_id`/`corrected` metadata so the newest entry always wins. Exercise-level memory is persisted in `kevin_exercise_history` so Kevin can report the latest prior weight by exercise.  
Run `tools/kevin_smoke_fixture.sql` before smoke tests to seed the `workouts` table with cardio/routine records ready for validation.

Routine source selection is versioned:
- Active pointer: `/home/ubuntu/habit_tracker/reference/routine_workout.active.json`
- Versioned files: `/home/ubuntu/habit_tracker/reference/routine_workout_YYYY-MM.json`
- Publisher: `tools/publish_routine_version.sh` (creates new versioned routine JSON files without overwriting historical ones)
