# Agent Migration Playbook (General, Post-Kevin)

## 1) Purpose
This playbook defines a reusable migration process for any agent into `capabilities_standards`, based on lessons learned during Kevin migration, so future migrations avoid the same failures.

## 2) Scope and non-goals
- Scope: standards alignment, contract correctness, runtime behavior parity, safe rollout, and reviewability.
- Non-goals: feature redesign unless explicitly approved.

## 3) Migration principles (must-follow)
1. **Mirror known-good structure first, customize second**
   - Start from a stable reference agent folder structure (e.g., Mindy) and then adapt content.
2. **Single source of truth per concern**
   - Prompt = personality + interaction behavior.
   - Architecture = technical wiring, contracts, routing, data dependencies.
3. **No legacy carryover by default**
   - Deprecated commands/flows must be explicitly removed; never reintroduce by template inertia.
4. **Contract-first implementation**
   - Tasks are valid only when contracts are complete and standards-compliant.
5. **Append-only correction semantics**
   - Updates must preserve lineage and effective-state resolution.
6. **Branch-safe delivery**
   - Work only on feature branch; never merge/push directly to `main`.

## 4) Pre-migration intake (mandatory)
Before writing code, document and lock:
1. **Active runtime surfaces**
   - Where the agent actually runs from (prompt path, architecture path, registry pointers).
2. **Data surfaces**
   - Real DB/tables/columns in production (verify with read-only schema checks).
3. **Current capability surface**
   - Existing commands/subtypes/tasks actually exposed to users.
4. **Deprecated surfaces**
   - Commands, files, or data models to explicitly ban in new artifacts.
5. **Out-of-repo dependencies**
   - External JSON/PDF/state files not tracked by the migration repo.

## 5) Canonical artifact set (task-level)
For each task in migrated agents, require:
- `input.schema.json`
- `output.schema.json`
- `output.format.md`
- `examples.json`
- `query.template.sql` (when data access is required)

Notes:
- Supplemental files (`task.yaml`, `prompt.md`, `README.md`, `test_cases.md`) are optional support, not replacements.

## 6) Prompt/architecture separation contract
### Core prompt must contain only:
- persona/voice
- interaction rules
- command UX
- boundaries and redirections (user-facing)

### Architecture must contain only:
- capability/task map
- routing logic
- data sources, paths, tables
- correction semantics
- derivation logic
- technical constraints

### Anti-patterns to reject
- prompt containing SQL/table/column/update execution logic
- architecture containing style/tone/persona prose

## 7) Migration phases
1. **Phase A — Discovery and gap map**
   - Compare legacy implementation vs standards target.
   - Produce mismatch list: structure, contracts, runtime, data model, deprecated flows.

2. **Phase B — Skeleton parity**
   - Create folder/file structure matching the reference agent.
   - Wire registry/spec pointers without behavior changes yet.

3. **Phase C — Contract hardening**
   - Build/upgrade task contracts to canonical artifact set.
   - Ensure schemas align with real DB columns.

4. **Phase D — Runtime parity and deprecation cleanup**
   - Remove deprecated commands everywhere.
   - Align command surface between prompt, architecture, and task set.

5. **Phase E — Data + correction validation**
   - Validate append-only updates and effective-state reporting.
   - Confirm derived downstream fields remain available.

6. **Phase F — Smoke test + handoff**
   - Execute smoke checks.
   - Publish review diff and merge instructions.

## 8) Validation matrix (must pass before merge)
1. **Surface consistency**
   - Prompt commands == architecture routes == available tasks.
2. **Contract consistency**
   - Task schemas and SQL align with real DB schema.
3. **Deprecation enforcement**
   - No deprecated command/flow appears in prompt, architecture, tasks, examples, or docs.
4. **Data derivation continuity**
   - Downstream required fields still derivable.
5. **Correction-chain behavior**
   - Update marks prior as corrected and appends replacement.
6. **External source pointer validity**
   - Active pointer files resolve to valid versioned assets.
7. **Language policy compliance**
   - Documentation language and prompt language follow project policy.
8. **Git safety**
   - Changes are on feature branch only; push target is feature branch only.

## 9) Common failure modes seen in Kevin migration (generalized)
1. **Runtime file mismatch**
   - Updating standards files but forgetting runtime prompt/architecture path used by live agent.
2. **Legacy drift**
   - Deprecated commands survive in one layer (prompt/architecture/task docs) and reappear in behavior.
3. **Schema assumption drift**
   - Docs/contracts reference old storage (CSV/legacy) instead of current DB table.
4. **Over-normalization risk**
   - Aggressive matching/normalization adds complexity and regressions; prefer controlled aliasing or source correction.
5. **Repo boundary confusion**
   - Critical runtime assets outside repo are changed but not visible in git review.
6. **Prompt architecture contamination**
   - Personality docs leak implementation details, confusing maintenance and future migrations.

## 10) Controlled change policy for ambiguous items
If uncertain whether a behavior is agent-specific or general:
1. mark as `AMBIGUOUS` in migration notes,
2. provide two options (generalized vs agent-specific),
3. pause for explicit user decision before implementation.

## 11) Required deliverables for every agent migration
1. `migration_gap_report.md` (what differs from standards)
2. `migration_plan.md` (phases, tasks, acceptance checks)
3. updated agent artifacts (spec + tasks + runtime prompt/architecture)
4. smoke test evidence (commands + key outputs)
5. review guide (`what changed`, `risks`, `what to verify`)

## 12) Quick execution checklist (operator view)
- [ ] Confirm branch is not `main`.
- [ ] Confirm live runtime file paths for this agent.
- [ ] Confirm real DB schema (read-only).
- [ ] Build reference-structure parity.
- [ ] Enforce canonical task contract artifacts.
- [ ] Remove deprecated commands everywhere.
- [ ] Validate prompt/architecture separation.
- [ ] Run correction-chain and downstream derivation smoke tests.
- [ ] Verify out-of-repo dependency impacts explicitly.
- [ ] Commit and push feature branch only.

## 13) Recommended naming convention for future migrations
- `codex_projects/<agent>_migration_gap_report.md`
- `codex_projects/<agent>_migration_plan.md`
- `codex_projects/<agent>_migration_review_checklist.md`

