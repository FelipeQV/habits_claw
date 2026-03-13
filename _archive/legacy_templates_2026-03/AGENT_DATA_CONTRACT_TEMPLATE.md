# DEPRECATED (Legacy template)
# Reusable Template — Agent Data Contract (v1)

Use this for any multi-agent system where one manager consolidates operational logs.

## 1) Sources
- Agent A source file: `<path>`
- Agent B source file: `<path>`
- Consolidated sink: `<path>`

## 2) Time Key
- Canonical date key: `YYYY-MM-DD`
- Canonical timezone: `<IANA TZ>`

## 3) Required Schema per Source
### Source A required columns
`...`

Filter for daily consolidation:
- `date == target_date`
- other validity rules

Derived metrics:
- `...`

### Source B required columns
`...`

Filter for daily consolidation:
- `date == target_date`

Derived metrics:
- `...`

## 4) Consolidated Table Contract
Primary key:
- `date`

Consolidated columns:
`date,...,data_health,missing_sources,manager_note`

## 5) Upsert Semantics
For each target date:
1. Insert if missing.
2. Update only known consolidated columns if present.
3. Do not drop unknown/custom columns.

## 6) Fallback Rule (Hard)
- Ask only for truly missing information.
- Never infer critical totals when source data is missing.

## 7) Health Check
- Existence/readability
- Header validation
- Type validation
- Timezone/date alignment
- Health state: `ok | partial | missing`

## 8) Ownership Boundaries
- Agent A owns source A writes.
- Agent B owns source B writes.
- Manager owns consolidation only.

## 9) Safety Rules
- Source logs append-only unless explicitly allowed.
- Corrections should be traceable.
- Consolidation should be idempotent per date.
