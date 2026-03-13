# Ghost Agent Template (Agnostic Scaffold)

This scaffold provides a domain-agnostic, placeholder-first foundation for capability-driven agents.

## Goals
- Keep governance, protocol, agent, and prompt artifacts separated (MECE).
- Make all environment/domain specifics configurable through placeholders.
- Mirror `capabilities_standards` patterns while remaining reusable.

## Structure
- `PLACEHOLDERS.md` — master placeholder inventory.
- `capabilities_standards/governance/` — capability standards and agent spec template.
- `capabilities_standards/protocol/` — protocol envelope + shared contract skeleton + errors.
- `capabilities_standards/agents/_agent_template/` — agent-specific extension template.
- `prompts/` — conversational prompt and architecture template (split by concern).

## Usage
1. Copy this scaffold for a concrete agent.
2. Replace placeholders (`{{...}}` style with UPPER_SNAKE_CASE names) with project values.
3. Define capabilities/subtypes and bind tasks.
4. Implement each task under `tasks/` with schema + format + examples + SQL template.
5. Validate JSON/YAML parsing and run runtime smoke tests.

## Placeholder Rule
All fixed identifiers (agent/domain/backend/path/table/capability/task IDs) must be expressed as placeholders until implementation time.
