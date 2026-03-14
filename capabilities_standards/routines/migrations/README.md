# Agent Migration Playbooks

## Contents
- `agent_migration_playbook.md`
- `agent_migration_gap_report_template.md`
- `agent_migration_plan_template.md`
- `agent_migration_review_checklist_template.md`
- `minimum_viable_migration_example.md`
- `PLACEHOLDERS.md`

## Execution sequence (start here)

```bash
# 1) Copy templates for a new agent migration
cd /home/ubuntu/codex_projects
cp /home/ubuntu/.openclaw/workspace/capabilities_standards/routines/migrations/agent_migration_gap_report_template.md {{AGENT_ID}}_migration_gap_report.md
cp /home/ubuntu/.openclaw/workspace/capabilities_standards/routines/migrations/agent_migration_plan_template.md {{AGENT_ID}}_migration_plan.md
cp /home/ubuntu/.openclaw/workspace/capabilities_standards/routines/migrations/agent_migration_review_checklist_template.md {{AGENT_ID}}_migration_review_checklist.md

# 2) Fill placeholders and contracts
# (edit files and replace {{...}} tokens)

# 3) Run DB schema reality check (read-only)
/home/ubuntu/.duckdb/cli/latest/duckdb /home/ubuntu/health_system.duckdb -c "PRAGMA table_info('{{PRIMARY_TABLE}}');"

# 4) Run migration smoke checklist
# (execute checks from {{AGENT_ID}}_migration_review_checklist.md)
```

## Naming convention
- `{{AGENT_ID}}_migration_gap_report.md`
- `{{AGENT_ID}}_migration_plan.md`
- `{{AGENT_ID}}_migration_review_checklist.md`
