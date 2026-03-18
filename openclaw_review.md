# OpenClaw System Review
**As-of:** 2026-03-17
**Purpose:** Identify bloat, structural issues, and improvement opportunities — no changes made yet.

---

## 1. Bulk Safe-to-Delete (Low Risk)

These files are clearly expendable and represent the majority of filesystem noise.

### Deleted automation sessions (130+ files)
**Path:** `agents/automation/sessions/*.jsonl.deleted.*`
All already marked deleted by OpenClaw itself. Safe to wipe the whole folder except `sessions.json`.

### Mindy session detritus
- `agents/mindy/sessions_backup_1771393620/` — old full backup, superseded
- `agents/mindy/sessions/*.jsonl.bak-20260310052233` — manual session backup
- `agents/mindy/sessions/sessions.json.bak-20260310052233`
- `agents/mindy/sessions/sessions.json.bak-manual-20260310-052245`

### Reset/deleted sessions in main and mindy
- `agents/main/sessions/*.jsonl.reset.*` (3 files)
- `agents/mindy/sessions/*.jsonl.reset.*` (2 files)
- `agents/main/sessions/*.jsonl.deleted.*` (2 files)

### Failed delivery queue (21 items)
**Path:** `delivery-queue/failed/`
All from the post-March-15 API failure period. No recovery value — these messages were never delivered and the conversations are stale.

### openclaw.json backups (7 files)
`openclaw.json.bak`, `.bak.1`, `.bak.2`, `.bak.3`, `.bak.4`, `.save`, `.save.1`
Keep at most 1 (the most recent `.bak`). The rest are redundant.

### Cron run history for defunct jobs
**Path:** `cron/runs/`
Only 2 of the 11 files correspond to active jobs (`043947a7` = AM check-in, `21b9903c` = PM check-in).
The other 9 (`1b373a88`, `480cfd31`, `5323d80e`, `5388d3a6`, `628bc361`, `85a6d25c`, `aed83fa6`, `e843cf38`, `04962f78`) are from deleted or test jobs. Safe to remove.

Also: `cron/jobs.json.bak` — redundant backup.

### Inbound media (9 files)
**Path:** `media/inbound/`
2 JPGs, 3 PDFs, 2 more JPGs, 1 more PDF, 1 OGG. Files sent via Telegram that were presumably processed. Verify none are needed, then clear.

---

## 2. Deprecated Workspace Files (Should Archive or Delete)

### workspace/FACTORY.md
**Status:** Explicitly self-labeled `DEPRECATED (Legacy)` at the top.
The Factory persona has been superseded by `capabilities_standards/governance/` + the `_factory/ghost_agent_template` scaffold. Not referenced in AGENTS.md as a bootstrap instruction. **Safe to delete.**

### workspace/README_DRAFT.md
Draft documentation file. Labeled "DRAFT - DO NOT USE". Not loaded by any agent. **Safe to delete.**

### workspace/_archive/detour-2026-02-22/ (3 files)
`CHECKLIST.md`, `FACTORY_PERSONA.md`, `POLICY.md`
Old planning artifacts from a detour in February. **Safe to delete.**

### workspace/_archive/MINDY_PROMPT_DRAFT_DEPRECATED_2026-03-10.md
Deprecated draft. Active prompt is now `workspace-mindy/MINDY_PROMPT.md`. **Safe to delete.**

### workspace/_archive/legacy_templates_2026-03/ (3 files)
`AGENT_DATA_CONTRACT_TEMPLATE.md`, `DAILY_REPORTING_AGENT_TEMPLATE.md`, `pm_flow.md`
Factory-era templates. Factory is deprecated, new system uses `_factory/ghost_agent_template`. **Safe to delete.**

> ⚠️ **Exception — keep:** `workspace/_archive/legacy_standards_2026-03/mindy-log-meal-v1.md`
> Still referenced in `workspace-mindy/AGENTS.md` as a required bootstrap read for Mindy. Do not delete until AGENTS.md is updated.

### workspace-mindy/_archive/MINDY_PROMPT_DEPRECATED.md
Explicitly deprecated. Superseded by `workspace-mindy/MINDY_PROMPT.md`. **Safe to delete.**

### codex_projects/ (7 files)
Planning and migration documents written for OpenAI Codex to consume. Some superseded by actual migrations now in `capabilities_standards/routines/migrations/`:
- `agent_migration_playbook.md` — duplicate of `capabilities_standards/routines/migrations/agent_migration_playbook.md`. **Redundant.**
- `kevin_migration_analysis.md` — duplicate of same path in capabilities_standards. **Redundant.**
- `kevin_migration_plan_for_codex.md` — duplicate. **Redundant.**
- `habits_claw_feature_plan.md`, `habits_claw_feature_strategy.md`, `habits_claw_feature_vision.md`, `habits_claw_user_stories.md` — vision/planning docs for a feature that may or may not have shipped. **Needs your review** before deleting.
- `openclaw_inventory.sh` — shell script for inventory. Unclear if still useful.

---

## 3. Structural Issues (Logic/Consistency Problems)

### 3.1 nutrition_targets.active.json not updated
**Path:** `capabilities_standards/targets/`
`nutrition_targets.active.json` still points to `nutrition_targets_2025-11.json` as the active version, but `nutrition_targets_2026-03.json` also exists and is presumably current.
**Action needed:** Update `active_version` to `nutrition_targets_2026-03.json` (or confirm 2025-11 is still correct).

### 3.2 daily_log.csv lives in workspace alongside DuckDB
**Path:** `workspace/daily_log.csv`
Legacy CSV from before the DuckDB migration. The current system writes to DuckDB. This CSV is likely stale and misleading.
**Action needed:** Confirm whether it's still updated or fully replaced by DuckDB, then archive or delete.

### 3.3 health_system.duckdb exists in workspace/ AND on server
**Path:** `workspace/health_system.duckdb`
The canonical DB is at `/home/ubuntu/health_system.duckdb` on the server. A copy also exists inside the main workspace directory. Could be:
- A stale local backup (no longer maintained)
- An accidentally-created empty file
- An intentional local dev copy
**Action needed:** Check its contents and last-modified date before deleting.

### 3.4 Pam's architecture files in wrong location
Mindy and Kevin follow the pattern: architecture doc + runtime prompt live in their own workspace directory (`workspace-mindy/MINDY_ARCHITECTURE.md`, `workspace-mindy/MINDY_PROMPT.md`; same for Kevin).
Pam does not: `PAM_ARCHITECTURE.md` and `PAM_CORE_PROMPT.md` live inside `capabilities_standards/agents/pam/` instead of `workspace-pam/`. Pam's workspace has no equivalent runtime files.
**Action needed:** Decide if Pam should follow the same workspace pattern as Mindy/Kevin (move files to `workspace-pam/`) or if this is intentional during migration.

### 3.5 Jim's log_daily_log task — schemas exist but task not deployed
`capabilities_standards/agents/jim/` has schemas for `log_daily_log` but the agent registry marks it as `(planned)`. Jim currently handles daily logs via free-form conversation using the cron jobs + `JIM.md` prompt. The structured DuckDB-backed task has not been deployed.
**No immediate action needed** — documenting the gap so it's explicit when you're ready to complete Jim's migration.

### 3.6 Stale git branches in workspace repo
Two feature branches exist: `kevin_new_flow` and `pam_new_flow`, with remote tracking refs.
**Action needed:** Confirm whether these are merged/done, then delete branches locally and remotely.

### 3.7 Nested cron file inside workspace
**Path:** `workspace/.openclaw/cron/jobs.json`
A separate `jobs.json` exists nested inside `workspace/.openclaw/`. Separate from the root-level `cron/jobs.json`. Possibly an artifact from running workspace as its own OpenClaw environment during development.
**Action needed:** Check its contents — if empty or test-only, delete it.

---

## 4. Observations (Context Only — No Action Required Yet)

### BOOTSTRAP.md files not cleaned up
Three workspaces still have a `BOOTSTRAP.md`: `workspace-automation/`, `workspace-mindy/`, `workspace-pam/`.
AGENTS.md instructs agents to delete this after first run. Either these agents never ran their bootstrap, or the cleanup didn't happen. Low priority but worth noting.

### _factory/ghost_agent_template — intentionally incomplete
Scaffolded on 2026-03-11 but deferred per the memory notes from that day. In-progress work, not bloat. Leave alone.

### Pam's workspace has actual live data files
`workspace-pam/notes.md`, `todos.md`, `reading-list.md` — live data, not bloat.

### memory/*.sqlite — no mindy.sqlite
Jim, Kevin, Main, and Pam have SQLite memory files. Mindy has none. This is correct — Mindy uses DuckDB exclusively.

---

## 5. Summary Table

| Priority | Item | Action | Est. Files |
|---|---|---|---|
| High | Deleted automation sessions | Delete | 130+ |
| High | delivery-queue/failed/ | Delete | 21 |
| High | nutrition_targets.active.json pointer | Fix | 1 |
| Medium | openclaw.json backups | Keep 1, delete rest | 6 |
| Medium | workspace/FACTORY.md | Delete | 1 |
| Medium | workspace/_archive/ (most items) | Delete | 6 |
| Medium | workspace-mindy/_archive/ | Delete | 1 |
| Medium | codex_projects/ duplicates | Delete 3, review 4 | 3–7 |
| Medium | Stale git branches | Delete | 2 branches |
| Medium | daily_log.csv | Verify then delete/archive | 1 |
| Medium | health_system.duckdb in workspace/ | Verify | 1 |
| Low | BOOTSTRAP.md cleanup | Delete | 3 |
| Low | Pam architecture location | Decide pattern | — |
| Low | workspace/.openclaw/cron/jobs.json | Verify | 1 |
| Low | Defunct cron run history | Delete | 9 |
| Low | Mindy/Automation session detritus | Delete | ~10 |
| Low | media/inbound/ | Verify then clear | 9 |
| Info | Jim log_daily_log not deployed | Gap — future work | — |
| Info | _factory/ghost_agent_template | In-progress, leave alone | — |
