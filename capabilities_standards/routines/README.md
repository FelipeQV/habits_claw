# Routine versioning process

- Versioned routine files must be immutable once published (example: `routine_workout_2026-03.json`).
- Publish a new routine by generating a new versioned JSON and updating `routine_workout.active.json`.
- Keep all historical routine versions for auditability and rollback.
- The active pointer is the source of truth for Kevin's routine selection; agents should resolve `active_version` first.

## Canonical files

- Active pointer: `/home/ubuntu/habit_tracker/reference/routine_workout.active.json`
- Versioned routines: `/home/ubuntu/habit_tracker/reference/routine_workout_YYYY-MM.json`
- Optional backward-compat file: `/home/ubuntu/habit_tracker/reference/routine_workout.json`

## Publish command

Use:

`tools/publish_routine_version.sh --version YYYY-MM --effective-from YYYY-MM-DD --pdf /abs/path/plan.pdf --json /abs/path/parsed.json`

This command:

1. Creates a new immutable version file under `/home/ubuntu/habit_tracker/reference/`.
2. Updates `routine_workout.active.json` to point to that new version.
3. Leaves existing versions untouched.

