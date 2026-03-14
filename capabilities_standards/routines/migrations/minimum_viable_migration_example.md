# Minimum Viable Migration Example (One Task)

This is a smallest useful migration slice for `{{AGENT_ID}}` with one `log` task.

## Scope
- Agent spec exists.
- One task implemented: `log_{{ENTITY_NAME}}`.
- Prompt/architecture split exists.
- One smoke test passes.

## Required files
- `capabilities_standards/agents/{{AGENT_ID}}/agent_spec.yaml`
- `capabilities_standards/agents/{{AGENT_ID}}/tasks/log_{{ENTITY_NAME}}/input.schema.json`
- `capabilities_standards/agents/{{AGENT_ID}}/tasks/log_{{ENTITY_NAME}}/output.schema.json`
- `capabilities_standards/agents/{{AGENT_ID}}/tasks/log_{{ENTITY_NAME}}/output.format.md`
- `capabilities_standards/agents/{{AGENT_ID}}/tasks/log_{{ENTITY_NAME}}/examples.json`
- `capabilities_standards/agents/{{AGENT_ID}}/tasks/log_{{ENTITY_NAME}}/query.template.sql`
- runtime prompt + runtime architecture files

## Smoke test
1. Insert one valid log payload.
2. Confirm row appears in `{{PRIMARY_TABLE}}`.
3. Confirm user-facing response starts with canonical `log` marker (`✏️`).
