# Kevin Migration Plan — Analysis & Proposed Adjustments

## Context review
- The existing migration brief already defines the objective (Kevin aligned with capability standards), locked decisions, and deliverables (agent spec + six task folders).  
- The Source Context list is comprehensive and overlaps heavily with Mindy’s contracts, governance definitions, the Daily Log contract, and `routine_workout.json`.  
- Kevin’s surface currently mirrors Mindy’s capability set (log/update/report/analyze) but split into cardio vs. routine tracks, with append-only correction rules and derived Daily outputs (`workout_done`, `cardio_total_min`).

## Key observations
1. **Daily Log dependency already exists:** `DAILY_LOG_CONTRACT.md` prescribes the `workout_done`/`cardio_total_min` fields, which Kevin must keep feeding.  
2. **Governance constraints are the same as Mindy’s:** templates enforce template-first SQL, schema + examples, and activation gate requirements.  
3. **Existing user stories** (see `habits_claw_user_stories.md`) emphasize logging, reporting, analysis, and target awareness; Kevin’s tasks should map to those stories, plus the routine/cardio split.  
4. **Routine schema reference:** `routine_workout.json` is the canonical structure and should be referenced directly by Kevin’s routine-task inputs.

## Proposed updates to the migration plan
1. **Explicit data tables:** Add a section specifying the new DuckDB tables (e.g., `cardio_events`, `routine_events`, or a unified `workouts` table) and their columns, so implementation knows exactly where to persist data while keeping compatibility with Jim’s outputs.  
2. **Story-to-task mapping appendix:** Extend Appendix B with a mapping from `habits_claw_user_stories.md` entries (cardio/routine/day summary) to the Kevin task names, showing which story each contract implements.  
3. **Template-first checklist for Kevin tasks:** Copy Mindy’s requirement list (schemas, template query, examples) into the plan and note where to plug in Kevin-specific SQL, ensuring we don’t forget the activation gate.  
4. **Clarify derived field logic:** Spell out the effective rules for `workout_done` and `cardio_total_min` (e.g., `workout_done` true if any cardio minutes>0 or any routine day marked complete) so the implementation phase avoids ambiguity.  
5. **Add correction tracing guidance:** Since Kevin’s updates must be append-only, specify the metadata fields required (e.g., `corrected`, `correction_of`, `updated_at`) and how the report/analyze tasks should pick the latest entry.  
6. **Smoke-test data seeds:** Suggest including sample CSV/JSON fixtures for both cardio and routine logs so the validation checklist can quickly spin up test rows before running smoke tests.  
7. **Governance reminder for `prescribe`:** Emphasize within Section 5 that any mention of `prescribe` must remain in orchestration scope and that Kevin’s analyze output should explicitly include confidence+data-quality (per governance definitions).  

## Next steps
1. Incorporate these clarifications into `kevin_migration_plan_for_codex.md` so the implementation phase has precise data model and testing guidance.  
2. Once the plan is updated, I can begin scaffolding the Kevin agent under `capabilities_standards/agents/kevin` and producing the six task folders with Mindy-style contracts.
