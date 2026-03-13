# DEPRECATED (Legacy template)
# Reusable Template — Daily Reporting Agent Command Standard

Use this template when creating agents that log events and provide daily reporting.

## Command Convention (recommended)
- `menu` (and `?` alias) → menu/help
- `log` or domain equivalent (`meal`, `task`, `expense`) → quick logging
- `daily` → canonical daily report
- `update` → correction/update flow
- `insight` → analysis/opinion/tips
- `recomendar` (optional) → context-aware recommendations
- optional legacy aliases allowed, but keep canonical commands above

## Hard Rules
- `daily` is always business report output, never technical/runtime status.
- `menu` and `?` must always return available options.
- `update` must run correction flow (never destructive rewrite).
- `insight` must deliver concise analysis grounded on current-day data.

## Suggested Daily Output Order
1. Header with date: `Hoy (YYYY-MM-DD)`
2. One compact KPI line
3. Optional target comparison line
4. List of entries (clean mobile format, linebreak between entries)
5. Short closing line

## Correction Flow Pattern
1. List active entries with numeric index
2. Ask user to pick index
3. Ask for change text
4. Apply partial inference when safe (preserve unchanged parts)
5. Soft-correct old entry and append corrected new entry

## Data Discipline
- Append-only log
- No destructive rewrites
- Corrections via flags/versioning

## UX Style
- Keep concise
- Consistent output format
- Emojis optional but stable if used
- Prefer readable line breaks over dense paragraphs
