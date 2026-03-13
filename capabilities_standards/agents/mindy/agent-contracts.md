# Mindy Agent Contracts

Purpose:
Capture Mindy-owned, meal/nutrition-specific contract details that extend the shared protocol.

## Scope
- Active specialized tasks: `log_meal`, `update_meal`, `report_meal`, `analyze_meal`
- Data backend: DuckDB (`/home/ubuntu/health_system.duckdb`)
- Surface behavior: payload contract is stable across channels; rendering may vary.

## General Notes
- `log_meal` currently uses a lite runtime output contract (strict mode deferred).
- Canonical field names are schema-level source of truth; alias normalization belongs to parser/input handling.
- `update_meal` uses append-only correction semantics.
- `report_meal` is factual nutrition-only reporting.
- `analyze_meal` is nutrition-only, non-definitive pattern analysis with required confidence.

## Task Contracts

### log_meal
Required:
- `meal_type`
- `food_description`

Optional:
- `date`
- `time`
- `calories`
- `protein`
- `carbs`
- `fat`
- `macro_estimated`
- `comments`

Behavior:
- If `date`/`time` are omitted, default to agent-local log timestamp.
- Insert exactly one row into meals domain storage.

Returns (typical):
- success status
- persisted row identifier/timestamp
- normalized meal fields (when available)

### update_meal
Required:
- `meal_selector` (deterministic selector; commonly date/time-based)
- `updates` (at least one canonical mutable field)

Behavior:
- Match prior row(s) by selector.
- Mark matched prior row(s) `corrected=1`.
- Append corrected row with `corrected=0`.
- Strategy is append-only; no destructive overwrite of original row.

Returns (typical):
- match/update counts
- corrected/new row identifiers when available

### report_meal
Required selector (exactly one):
- `date` (YYYY-MM-DD)
- OR `from` + `to` (YYYY-MM-DD)
- OR `last_n_meals` (integer >= 1)

Optional:
- `meal_type`
- `include_entries` (default true)

Expected output fields:
- `timeframe`
- `totals` (`calories`, `protein`, `carbs`, `fat`)
- `meal_count`
- `estimation_rate`
- `entries` (optional)
- `data_quality` (optional)

Boundary:
- Factual nutrition-only reporting.
- No causal claims and no cross-domain conclusions.

### analyze_meal
Required selector (exactly one):
- `date` (YYYY-MM-DD)
- OR `from` + `to` (YYYY-MM-DD)
- OR `last_n_meals` (integer >= 1)

Optional:
- `meal_type`
- `include_evidence` (default true)

Expected output fields:
- `timeframe`
- `findings[]`
- `confidence` (`level`, `basis[]`)
- `evidence_summary` (optional)
- `cross_domain_note` (optional)

Boundary:
- Nutrition-only pattern analysis.
- Findings are non-definitive and MUST include confidence.
- Any cross-domain remainder is redirected to `orchestration_agent`.

## Canonical Task Artifact Locations
- `capabilities_standards/agents/mindy/tasks/log_meal/*`
- `capabilities_standards/agents/mindy/tasks/update_meal/*`
- `capabilities_standards/agents/mindy/tasks/report_meal/*`
- `capabilities_standards/agents/mindy/tasks/analyze_meal/*`
