# Placeholder Catalog

## How to fill placeholders
- Decide the agent’s real-world purpose first (who it helps and what it does), then fill identity fields.
- Keep IDs stable and machine-friendly (`snake_case`); keep display names human-friendly.
- Reuse values consistently across files (especially agent ID, task ID, table names, and protocol version).
- For sample/example placeholders, use realistic fake values that match your domain.
- Validate every `{{...}}` token has been replaced (or intentionally kept as template syntax) before publishing.

## Migration safety gates (required before publish)
1. **Runtime path verification**
   - Confirm the live runtime paths for this agent (prompt, architecture, registry pointers).
   - Ensure generated files are the same files runtime will read.
2. **Deprecated flow ban list**
   - Define deprecated commands/flows/files for this migration.
   - Verify none of them appear in prompt, architecture, tasks, examples, or docs.
3. **Schema reality check**
   - Compare task schemas/SQL against real DB schema using read-only inspection.
   - Fix any contract fields that reference legacy or non-existent columns.
4. **Out-of-repo dependency check**
   - List external assets this agent depends on (JSON/PDF/state files outside git repo).
   - Record whether each was changed and how reviewers should validate it.

## Inference column definitions
- `Inferred`: how much the value may be inferred rather than directly provided. Allowed values: `NO`, `LOW`, `MID`, `HIGH`, `YES`.
- `Inferred_source`: datapoint(s) used for inference, or `N/A` when not inferred.

## Resolution_mode definitions
- `ASK_OPEN`: ask the user an open-ended question to define the value.
- `ASK_CLOSED`: ask a constrained question (choices/yes-no) to resolve the value.
- `INFER_PASS1`: infer in initial derivation pass from high-confidence context.
- `INFER_PASS2`: infer in a later pass after dependent fields/context are available.
- `INTERNAL_CONFIG`: set from internal/system configuration, not user questioning.

## ASK_CLOSED option catalog

### `{{CAPABILITY_TASK_NAME}}`
- `log_event` (d)
- `update_event`
- `report_event`
- `analyze_event`
- `prescribe`
- `prescribe_delegation`
- `other`

### `{{CORRECTION_STRATEGY}}`
- `no_auto_correction_confirm_first` (d)
- `adjust_next_event_by_delta`
- `spread_delta_over_next_3_events`
- `tighten_target_temporarily`
- `manual_override_required`
- `other`

### `{{DOMAIN}}`
- `nutrition` (d)
- `fitness`
- `sleep`
- `habits`
- `productivity`
- `finance`
- `other`

### `{{INFERENCE_POLICY}}`
- `strict_no_inference` (d)
- `infer_from_recent_history`
- `infer_from_schema_defaults`
- `infer_with_user_confirmation_if_low_confidence`
- `hybrid_history_then_defaults`
- `other`

### `{{LANGUAGE_CODE}}`
- `en` (d)
- `es`
- `bilingual`
- `other`

### `{{SUBTYPE_NAME}}`
- `daily_summary` (d)
- `weekly_summary`
- `single_event`
- `target_update`
- `adherence_check`
- `trend_analysis`
- `other`

### `{{VOICE_STYLE}}`
- `clear_calm_practical` (d)
- `concise_direct`
- `friendly_supportive`
- `formal_professional`
- `coach_like`
- `other`

## Ownership legend
- `user`: provided by human requirement input
- `dunder`: filled/decided by orchestration/system defaults
- `agent`: filled by generated agent at runtime
- `unsure`: needs design decision

| Placeholder | What it means (plain language) | Expected format/type | Typical source (who/where supplies it) | Required? (Yes/No/Depends) | Example value | Where used (file pattern/section) | Inferred | Inferred_source  | Ownership | Resolution_mode |
|---|---|---|---|---|---|---|---|---|---|---|
| `{{AGENT_DESCRIPTION}}` | Short summary of what the agent is for. | 1–2 sentence plain text | Agent designer in spec/governance template | Yes | `Tracks nutrition targets and progress.` | `agent_spec.yaml`, `governance/agent_spec_template.yaml` | NO | N/A | user | ASK_OPEN |
| `{{AGENT_ID}}` | Permanent machine ID used in contracts and routing. | `snake_case` identifier | Agent implementer | Yes | `nutrition_agent` | Protocol README, templates, contracts, prompts | NO | N/A | user | INTERNAL_CONFIG |
| `{{AGENT_NAME}}` | Human-facing name shown in docs/prompts. | Short title text | Product/agent owner | Yes | `Nutrition Coach` | Agent specs, contracts, prompts | NO | N/A | user | ASK_OPEN |
| `{{CAPABILITY_TASK_NAME}}` | Concrete operation name inside a capability. | `snake_case` task label | Capability/task designer | Depends | `log_event` | Protocol README examples | NO | N/A | user | ASK_CLOSED |
| `{{CORRECTION_STRATEGY}}` | Rule for how to recover when values drift from target. | Closed list (+ other) policy text | Domain logic owner | Depends | `adjust next meal by remaining delta` | Agent spec + governance template | LOW | prior state + domain policy | user | ASK_CLOSED |
| `{{DB_PATH}}` | Location or DSN of the database used by the agent. | File path or connection string | Deploy/runtime configuration | Yes | `/data/agent.duckdb` | Protocol README, contracts, architecture prompt | NO | N/A | user | INTERNAL_CONFIG |
| `{{DOMAIN}}` | Business/topic area where the agent operates. | Closed list (+ other) lowercase domain label | Product/solution designer | Yes | `nutrition` | Specs, governance templates, core prompt | NO | N/A | user | ASK_CLOSED |
| `{{ENTITY_TABLE}}` | Main table a task queries for entity rows. | SQL table name | Data model/schema designer | Depends | `events` | Agent spec + SQL template + governance template | NO | N/A | user | INTERNAL_CONFIG |
| `{{INFERENCE_POLICY}}` | Rule for when/how estimates are allowed. | Policy sentence or keyword | Domain policy owner | Depends | `estimate missing macros from known defaults` | Agent spec + governance template | MID | missing values + policy constraints | user | ASK_CLOSED |
| `{{LANGUAGE_CODE}}` | Language to use for generated text. | ISO language code | User preference or runtime request | Depends | `en` | Core prompt + protocol examples | LOW | user locale/profile | user | ASK_CLOSED |
| `{{DATA_MODEL_FIELDS_LIST}}` | Full list/block of field definitions for the agent data model. | YAML list/block string (field objects with name/type/set_by/etc.) | Schema designer | Yes | `- name: consumed_kcal\n  type: number\n  set_by: user\n  values: []\n  notes: Daily intake metric` | `agent_spec.yaml`, `governance/agent_spec_template.yaml` under `data_model.fields` | NO | N/A | user | INTERNAL_CONFIG |
| `{{TARGET_METRIC_FIELDS_LIST}}` | List of metric field keys used for targets comparisons. | YAML/JSON-style list of `snake_case` field keys | Schema/domain designer | Depends | `["target_kcal", "actual_kcal"]` | `_agent_template/agent_spec.yaml` `targets.fields` | NO | N/A | user | INFER_PASS2 |
| `{{ORCHESTRATION_AGENT_ID}}` | ID of coordinator agent handling delegation/routing. | `snake_case` identifier | Multi-agent architecture owner | Depends | `coach_orchestrator` | Agent spec, governance templates | NO | N/A | dunder | INTERNAL_CONFIG |
| `{{PRIMARY_KEY_FIELD}}` | Unique row identifier column name. | Field key (`snake_case`) | Database/schema designer | Yes | `id` | Agent spec + governance template | NO | N/A | user | INTERNAL_CONFIG |
| `{{PRIMARY_TABLE}}` | Default base table for agent records. | SQL table name | Data model/schema designer | Yes | `daily_logs` | Agent spec, governance template, architecture prompt | NO | N/A | user | INTERNAL_CONFIG |
| `{{PROTOCOL_VERSION}}` | Version of protocol/contract format being used. | Semver string | Platform standard/governance | Yes | `1.0.0` | Protocol docs/errors + task examples | NO | N/A | dunder | INFER_PASS1 |
| `{{TASK_QUERY_PARAMS}}` | SQL select-list snippet for task-specific fields and aliases (one or multiple expressions). | SQL select-list fragment | Query template author | Depends | `user_id AS metric_1, start_date AS metric_2, end_date AS metric_n` | `tasks/_task_template/query.template.sql` | NO | N/A | user | INFER_PASS2 |
| `{{RENDER_TEMPLATE_HINT}}` | Output formatting hint for renderer/model. | Short instruction text | Task/prompt designer | Depends | `Return concise bullet summary with totals first.` | Agent spec, output format, examples, governance template | NO | N/A | user | INFER_PASS2 |
| `{{RUNTIME_SCOPE}}` | Scope where runtime behavior/policies apply. | Scope label/text | Runtime/governance designer | Depends | `task_only` | Agent spec sections | NO | N/A | dunder | INTERNAL_CONFIG |
| `{{SUBTYPE_NAME}}` | Subcategory within a broader capability. | `snake_case` token | Capability model designer | Depends | `daily_summary` | Agent spec + governance template | NO | N/A | user | ASK_CLOSED |
| `{{TARGETS_TABLE}}` | Table that stores goals/targets to compare against. | SQL table name | Data model/schema designer | Depends | `agent_targets` | Action patterns, agent spec, architecture prompt | NO | N/A | user | INTERNAL_CONFIG |
| `{{TARGET_SELECTION_RULE}}` | Logic for choosing which target applies. | Rule sentence/keyword | Domain policy designer | Depends | `most recent active target by date` | Agent spec sections | MID | timestamp + active flag + owner scope | user | INFER_PASS2 |
| `{{TARGET_SOURCE}}` | Source artifact where target values come from. | Table/path/source label | Data pipeline or schema owner | Depends | `agent_targets` | Agent spec + governance template | HIGH | `{{TARGETS_TABLE}}` source metadata fields | dunder | INFER_PASS1 |
| `{{TASK_ID}}` | Stable machine ID for a specific task contract. | `snake_case` identifier | Task author | Yes | `summarize_daily_intake` | Agent spec, task schemas/examples/sql, contracts | YES | task folder name or form task label slug | dunder | INFER_PASS1 |
| `{{TASK_NAME}}` | Human-readable label for a task. | Short title text | Task author/product owner | Yes | `Summarize Daily Intake` | Task output format docs | YES | `{{TASK_ID}}` (slug -> title case) | dunder | INFER_PASS1 |
| `{{TASK_PATH}}` | Relative folder path where task artifacts live. | Relative filesystem path | Template/scaffold implementer | Yes | `tasks/summarize_daily_intake` | Architecture prompt + protocol docs | NO | N/A | dunder | INFER_PASS1 |
| `{{TASK_SQL_TEMPLATE}}` | Full SQL body fragment appended after `FROM` in task query template. | block: SQL clause body | Task/query author | Depends | `WHERE date >= ? AND date <= ? ORDER BY date DESC` | `tasks/_task_template/query.template.sql` | NO | N/A | user | INFER_PASS2 |
| `{{TIMESTAMP_ISO}}` | Full date-time stamp used in logs/events. | ISO-8601 timestamp | Runtime clock or example author | Depends | `2026-03-11T20:24:00Z` | Protocol README + task examples | YES | system clock | agent | INFER_PASS1 |
| `{{VOICE_STYLE}}` | Tone/style instruction for generated wording. | Short style phrase | Prompt designer or product voice guide | Depends | `clear, calm, and practical` | Core prompt + placeholder docs | LOW | brand style guide + audience | user | ASK_CLOSED |

## Pre-publish signoff checklist
- [ ] Runtime path verification completed (live prompt/architecture/registry paths confirmed).
- [ ] Deprecated flow ban list defined and verified absent across all agent artifacts.
- [ ] Schema reality check completed against real DB schema (read-only inspection).
- [ ] Out-of-repo dependencies documented with reviewer validation notes.
- [ ] Placeholder replacement audit completed (`{{...}}` tokens resolved or intentionally retained).
