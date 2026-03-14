# Kevin Migration Plan for Codex

## 1) Objective
Migrate Kevin (Workout agent) from the old flow to the current capabilities standards/template flow used in this workspace, with minimal behavioral change and no full product redesign.

This brief is implementation-facing for Codex and defines the exact migration scope, contracts, and acceptance checks.

## 2) Locked Decisions and Constraints
1. **Migration scope is constrained to standards alignment**
   - Move Kevin into the standardized agent/task structure and governance patterns.
   - Preserve current user-facing intent and outcomes.

2. **Workout dimension is explicitly two-track (locked decision)**
   - **Cardio track**: `did_cardio` (yes/no) + `cardio_type` + `cardio_minutes`.
   - **Routine track**: structured routine day execution sourced from `routine_workout.json`.
   - **No full redesign expected**.

3. **Governance is mandatory for any non-locked change**
   - Any design/behavior addition or ambiguity follows: **proposal -> user OK -> implementation**.
   - Do not silently infer product decisions from templates.

4. **Minimal data evolution**
   - Prefer additive fields and compatibility adapters over schema replacement.
   - Corrections must be append-only (no destructive historical overwrite).

5. **Downstream outputs required for Jim remain available**
   - `workout_done`
   - `cardio_total_min`

6. **Canonical capability-start marker is locked**
   - User-facing outputs that execute a capability must start with the canonical emoji as the first token.
   - Mapping: `log` ✏️, `update` 📝, `report` 📖, `analyze` 📈, `prescribe` 🔮, `prescribe_delegation` 🧭.
   - Conversational/meta responses do not require an emoji.

## 3) Source Context (Read First)
Read these inputs before implementation; treat them as the authoritative migration context and standards baseline.

- `/home/ubuntu/codex_projects/habits_claw_user_stories.md`
- `/home/ubuntu/habit_tracker/reference/routine_workout.json`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/governance/agent_spec_template.yaml`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/governance/capability_definitions.yaml`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/governance/action_patterns.yaml`
- `/home/ubuntu/.openclaw/workspace/DAILY_LOG_CONTRACT.md`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/mindy/agent_spec.yaml`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/mindy/tasks/log_meal/`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/mindy/tasks/update_meal/`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/mindy/tasks/report_meal/`
- `/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/mindy/tasks/analyze_meal/`
- `/home/ubuntu/.openclaw/workspace/tools/daily_manager_report.py`
- `/home/ubuntu/.openclaw/workspace/AGENT_REGISTRY.md`
- `/home/ubuntu/.openclaw/workspace/_archive/legacy_templates_2026-03/pm_flow.md`

## 4) Target Deliverables (Files to Create/Update)
Implement Kevin under:
`/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/kevin/`

Planned deliverables:

1. `agent_spec.yaml`
   - Based on governance template shape.
   - Declare Kevin capabilities and action/task mapping.
   - Mark `prescribe` as orchestration-owned (not Kevin-owned).

2. Task directories (parallel to Mindy layout), each with required contract files (e.g., spec/prompt/schema/examples/tests as required by current standards):
   - `tasks/log_cardio/`
   - `tasks/log_routine_workout/`
   - `tasks/update_cardio/`
   - `tasks/update_routine_workout/`
   - `tasks/report_workout/`
   - `tasks/analyze_workout/`

3. Required Kevin prompt artifacts (mirror Mindy split):
   - `AGENT_CORE_PROMPT`-style file for Kevin (conversation behavior, tone, interaction rules, user-facing response behavior).
   - `AGENT_ARCHITECTURE`-style file for Kevin (capability map, task routing logic, boundaries, redirects, constraints).

4. Optional Kevin-local supporting assets only if needed for standards compliance:
   - Normalization maps (cardio types, routine aliases)
   - Validation snippets
   - Test fixtures for routine-day execution payloads

5. Registry/governance touchpoints (only if required by existing standards workflow):
   - Add/verify Kevin entry in registry/indexes according to current repo conventions.

## 5) Capability Design (Kevin)
Kevin capability surface for this migration:

- `log_cardio`
- `log_routine_workout`
- `update_cardio`
- `update_routine_workout`
- `report_workout`
- `analyze_workout`

Ownership notes:
- `prescribe` is **owned by orchestration**, not Kevin.
- Kevin focuses on capture/update/report/analyze of workout data only.

Behavior notes:
1. **log_cardio**
   - Collect and persist cardio track fields: yes/no, type, minutes.
   - Validate minutes as non-negative integer (or standards-compliant numeric rule).

2. **log_routine_workout**
   - Record structured routine execution aligned to `routine_workout.json` day schema.
   - Track completion granularity compatible with downstream reporting.

3. **update_cardio / update_routine_workout**
   - Corrections implemented as append-only events/patches with lineage.
   - Latest effective value resolved at read/report time.

4. **report_workout**
   - Produce daily and range summaries aligned with Daily contract.
   - Must emit or support derivation of Jim-required fields.

5. **analyze_workout**
   - Provide descriptive insights on adherence/patterns.
   - No prescriptive programming redesign.

## Prompt Parity Requirement (Mirror Mindy)
Kevin prompt architecture is a required migration deliverable.

1. Kevin must include two prompt artifacts equivalent to Mindy split:
   - `AGENT_CORE_PROMPT`-style file for conversation behavior, tone, interaction rules, and user-facing response behavior.
   - `AGENT_ARCHITECTURE`-style file for capability map, task routing logic, boundaries, redirects, and constraints.
2. Separation rule is mandatory:
   - No architecture contracts inside the core prompt.
   - No conversational style/voice rules inside the architecture prompt.
3. Codex must treat this prompt split as required scope, not optional cleanup.

## 6) Data Model Strategy (Minimal Change)
1. Keep existing conceptual model; evolve with additive fields only. Kevin will persist workouts in a single `workouts` table keyed by `date` + `record_id`.
   - Proposed columns: `date`, `cardio_minutes`, `cardio_type`, `routine_completed`, `works_out` (boolean for any activity), `corrected`, `record_id`.
   - Keep `cardio_minutes` nullable and default 0 to avoid schema breaks, `routine_completed` boolean default 0, `corrected` flag for append-only corrections.
2. Represent workout as two composable tracks under the same row context:
   - Cardio track uses `cardio_minutes`/`cardio_type`.
   - Routine track uses `routine_completed`.
3. Add metadata to every row:
   - `record_id` is required so updates can reference it and append corrections (e.g., `<original>-correction`).
   - `corrected` flag indicates a superseded record; reports/analyze must filter `corrected = 0` for effectiveness.
4. Corrections are append-only:
   - Each `update_*` marks the matched row `corrected=1`, writes a new row with `corrected=0`, and preserves `record_id`.
   - `workout_done` evaluation uses only the non-corrected rows for each day.
5. Derived daily outputs required by Jim:
   - `workout_done`: true if either `cardio_minutes > 0` (after correction) or `routine_completed = 1`.
   - `cardio_total_min`: sum of non-corrected cardio rows for the date.

## 7) Task Contracts to Implement
For each Kevin task folder, implement standards-aligned contract artifacts consistent with governance and Mindy examples.

Minimum contract expectations per task:
1. **Purpose/when-to-use**
2. **Inputs schema** (required/optional fields)
3. **Validation rules**
4. **Output schema** (including normalized fields for reporting)
5. **Error handling contract** (recoverable vs blocking)
6. **Examples** (happy path + correction path)
7. **Test cases** (unit-level and smoke-level)

Task-specific contract highlights:
- `log_cardio`: input includes yes/no gate, type, minutes.
- `log_routine_workout`: input references routine day structure from `routine_workout.json`.
- `update_*`: must include record locator and correction payload; preserve lineage.
- `report_workout`: supports daily and date-range modes.
- `analyze_workout`: consumes report-ready normalized data, returns non-prescriptive analysis.

## 8) Implementation Phases
1. **Phase 0 — Read & Align**
   - Read all Source Context paths.
   - Extract Kevin-relevant user stories and Daily/Jim dependencies.

2. **Phase 1 — Skeleton & Spec**
   - Create Kevin folder structure and `agent_spec.yaml`.
   - Register capabilities and task routing per standards.
   - Mirror Mindy’s prompt/architecture split inside `workspace-kevin/`, so Kevin has both `KEVIN_PROMPT.md` and `KEVIN_ARCHITECTURE.md` with the same structure but tailored to his persona and tasks.

3. **Phase 2 — Task Contract Authoring**
   - Implement six task contracts with schemas, prompts/specs, examples, and tests.

4. **Phase 3 — Data/Derivation Wiring**
   - Implement two-track model wiring and correction-chain resolution.
   - Ensure derivation of `workout_done` and `cardio_total_min` in reporting outputs.

5. **Phase 4 — Validation & Regression**
   - Execute smoke tests and user-story traceability checks.
   - Fix contract mismatches and edge-case failures.

6. **Phase 5 — Review Gate**
   - For any non-locked behavior choice, pause at **proposal -> user OK -> implementation**.

## 9) Acceptance Criteria (User-story aligned)
Migration is complete when all are true:
1. Kevin exists under standards folder with valid `agent_spec.yaml` and six task directories.
2. Cardio and routine tracks are both implemented and independently loggable/updatable.
3. No full redesign behavior introduced beyond approved migration scope.
4. Append-only correction chain works for both cardio and routine updates.
5. Daily and range reporting operate on corrected effective state.
6. Jim-required handoff fields are present/derivable: `workout_done`, `cardio_total_min`.
7. User stories tied to Kevin/Daily workout flow map to implemented tasks with passing smoke tests.
8. Kevin prompt parity is implemented with both required prompt artifacts present (`AGENT_CORE_PROMPT`-style + `AGENT_ARCHITECTURE`-style).
9. Prompt artifacts are cleanly separated by concern (no architecture contracts in core prompt; no conversational style rules in architecture prompt).
10. Capability outputs comply with canonical capability-start markers (emoji as first token when executing `log/update/report/analyze/prescribe/prescribe_delegation`).

## 10) Validation & Smoke Tests
Practical checklist (must pass):

1. **Log cardio**
   - Input: cardio=yes, type=run, minutes=30.
   - Expected: record created; daily shows cardio contribution.

2. **Log routine**
   - Input: routine day execution matching `routine_workout.json` structure.
   - Expected: routine execution stored and report-visible.

3. **Daily report**
   - Expected includes effective day summary and Jim handoff fields.

4. **Range report**
   - Multi-day aggregation works; cardio minutes aggregate correctly.

5. **Correction chain (cardio)**
   - Log 30 min, then update to 25 min.
   - Expected: history preserved; effective value=25; `cardio_total_min`=25.

6. **Correction chain (routine)**
   - Log routine completion state, then correction.
   - Expected: lineage preserved; effective state reflected in reports.

7. **Jim handoff fields**
   - Validate explicit output presence/derivability:
     - `workout_done`
     - `cardio_total_min`

8. **Prompt artifact existence check**
   - Verify both Kevin prompt files exist at expected Kevin paths (`AGENT_CORE_PROMPT`-style and `AGENT_ARCHITECTURE`-style).

9. **Prompt separation spot-check**
   - Verify content-level separation by spot-checking that concerns are not mixed across the two prompt files.

10. **Canonical marker spot-check**
   - For one sample per capability (`log/update/report/analyze`), verify the user-facing response starts with the mapped emoji as first token.
   - Verify conversational/meta replies can omit emoji.

_Before running these smoke tests, load `tools/kevin_smoke_fixture.sql` into DuckDB to seed cardio/routine rows; this script resets the week’s rows, flags corrections, and ensures reporting derives Jim’s fields._

## 11) Out of Scope
1. Redesign of Kevin product behavior beyond standards migration.
2. New coaching/prescription logic within Kevin.
3. Changes to orchestration ownership boundaries (including `prescribe`).
4. Major schema rewrites requiring destructive historical migration.
5. Expansion into unrelated wellness dimensions.

## 12) Open Questions Requiring User Approval
**Do not implement until user approves (proposal -> user OK -> implementation):**
1. Exact threshold rule for `workout_done` when cardio is marked yes but minutes are missing/zero.
2. Allowed vocabulary/normalization list for `cardio_type` if not fully specified in existing assets.
3. Routine completion granularity definition (binary day done vs partial scoring) if ambiguous in current stories.
4. Confirm exact Kevin prompt file paths/names to mirror Mindy prompt convention.

## Appendix A — Suggested File Skeleton
```text
/home/ubuntu/.openclaw/workspace/capabilities_standards/agents/kevin/
  agent_spec.yaml
  tasks/
    log_cardio/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
    log_routine_workout/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
    update_cardio/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
    update_routine_workout/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
    report_workout/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
    analyze_workout/
      task.yaml
      prompt.md
      input.schema.json
      output.schema.json
      examples.md
      test_cases.md
```

## Appendix B — Mapping from User Stories to Tasks
Use this mapping as the implementation traceability table for Kevin/Daily shared stories.

1. **Story intent: user logs cardio activity for the day**
   - Primary task: `log_cardio`
   - Follow-up correction: `update_cardio`
   - Reporting surface: `report_workout`

2. **Story intent: user logs planned routine day execution**
   - Primary task: `log_routine_workout`
   - Follow-up correction: `update_routine_workout`
   - Reporting surface: `report_workout`

3. **Story intent: user asks what was done today / this week**
   - Primary task: `report_workout` (daily/range modes)
   - Optional interpretation: `analyze_workout`

4. **Story intent: user corrects previously logged workout info**
   - Primary tasks: `update_cardio` or `update_routine_workout`
   - Data behavior: append-only correction chain
   - Verification: reflected in subsequent `report_workout`

5. **Story intent: downstream Daily/Jim needs normalized workout handoff**
   - Producing task: `report_workout`
   - Required handoff fields: `workout_done`, `cardio_total_min`

6. **Story intent: user requests trend/adherence insight without new prescription logic**
   - Primary task: `analyze_workout`
   - Constraint: descriptive analysis only; no orchestration-owned prescribe behavior

### Addendum — Story references
- Link relevant user stories from `codex_projects/habits_claw_user_stories.md` to Kevin tasks:
  1. Workout logging stories → `log_cardio`, `log_routine_workout`, `report_workout`, `analyze_workout`
  2. Daily management stories → `report_workout` (feeds `workout_done`/`cardio_total_min`)
  3. Targets/memory stories → `report_workout` + eventual template to expose current plan to Kevin flows
