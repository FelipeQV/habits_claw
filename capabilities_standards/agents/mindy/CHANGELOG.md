# Mindy Changelog

## 2026-03-10
- Activated `report_meal` capability artifacts for Mindy.
- Added task schemas:
  - `tasks/report_meal/input.schema.json`
  - `tasks/report_meal/output.schema.json`
- Added `tasks/report_meal/examples.json` with success, validation-error, and DB-query-error responses.
- Updated protocol docs (`capabilities_standards/protocol/README.md`, `capabilities_standards/protocol/agent-contracts.md`) to include `report_meal` as active and nutrition-only factual reporting behavior.
- Updated `agent_spec.yaml` report.meal extension notes while preserving `binding.id: report_meal` and `active: true`.

## 2026-03-10
- Activated `analyze_meal` capability artifacts for Mindy.
- Added task schemas:
  - `tasks/analyze_meal/input.schema.json`
  - `tasks/analyze_meal/output.schema.json`
- Added `tasks/analyze_meal/examples.json` with success, validation-error, and DB-query-error responses.
- Updated protocol docs (`capabilities_standards/protocol/README.md`, `capabilities_standards/protocol/agent-contracts.md`) to include `analyze_meal` as active with nutrition-only, non-definitive analysis and cross-domain redirect behavior.
- Confirmed `agent_spec.yaml` analyze.meal binding remains `id: analyze_meal` and `active: true`.

## 2026-03-10
- Expanded `report_meal` and `analyze_meal` input selectors to support `last_n_meals` (integer >= 1) in addition to `date` or `from`+`to`, enforcing exactly one selector mode.
- Updated `report_meal` and `analyze_meal` examples to include successful `last_n_meals` selector usage.
- Updated protocol contract docs to reflect selector options: `date` OR `from`+`to` OR `last_n_meals`.
- Added explicit language behavior rule in `agent_spec.yaml`: if the user speaks Spanish, Mindy responds in Spanish.

## 2026-03-10
- Added top-level `nl_hints` to `agent_spec.yaml`, including normalized intent clues and interpretation guidance for `log_meal`, `update_meal`, `report_meal`, and `analyze_meal`.
- Added `guardrails` examples under `nl_hints` to separate safe auto-log cases from reflection/ambiguous messages that require clarification first.
- Included Spanish-first language behavior guidance (`default_user_language_match: true` + explicit Spanish rule).
- Added phrasing support guidance for report selectors, including `"últimas N comidas"` mapping to `last_n_meals` mode.

## 2026-03-10
- Relocated Mindy NL hints from top-level `nl_hints` into per-subtype `nl_hints` blocks for `log.meal`, `update.meal`, `report.meal`, and `analyze.meal`.
- Kept only language behavior (`Spanish` response matching) at top-level `nl_hints.language_behavior`.
- Moved NL guardrail examples into `capabilities.log.subtypes[name=meal].nl_hints.guardrails` for clear task-scoped intent routing.


## 2026-03-10
- Updated `agent_spec.yaml` `log.meal` NL output hints to preserve the macro table (kcal, protein, carbs, fat, and fiber when available) and add a compact `vs target (hoy acumulado)` line after the table for kcal/protein/carbs/fat deltas; fiber remains informative only (no target comparison).
- Updated `agent_spec.yaml` `update.meal` NL output hints to include delta-to-target snapshots only in one-day contexts, while keeping non-day/range/ambiguous corrections factual (before/after + correction flow) without target deltas.
