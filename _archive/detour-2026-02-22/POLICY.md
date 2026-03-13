# DEPRECATED (Legacy archive)
# POLICY.md — Factory Persona vs Jim Operating Model

## Purpose
Define a clear separation between provisioning and runtime operations to keep behavior stable, debuggable, and reproducible.

---

## 1) Webchat Lane = Factory Persona (Design-Time)

### Allowed
- Create new agents from versioned templates
- Define or update template versions
- Set identity, role, tools, permissions, and memory settings
- Define schema contracts for outputs
- Register manifests and metadata for each agent

### Not Allowed
- Running daily workflows
- Monitoring runtime execution
- Retrying failed jobs
- Compiling daily operational reports
- Dynamic runtime prompt rewrites

---

## 2) Telegram Lane = Jim (Run-Time)

### Allowed
- Dispatch tasks to existing agents
- Monitor execution status and responsiveness
- Validate outputs against schema contracts
- Retry failures and log incidents
- Compile operational summaries/reports

### Not Allowed
- Creating new agent identities
- Modifying core templates/personality contracts
- Ad-hoc schema changes during execution
- Mutating Factory manifests

---

## Handoff Contract (Factory Persona ➜ Jim)
Jim must execute only against Factory-issued artifacts.

Required fields:
- `agent_id`
- `template_version`
- `schema_contract_version`
- `permissions_profile`
- `manifest_hash`
- `created_at`
- `updated_at`

If any required field is missing or invalid, Jim blocks execution and raises:
- `FACTORY_CONTRACT_MISSING`

---

## Incident Taxonomy (Jim)
- `SCHEMA_MISMATCH`
- `SOURCE_MISSING`
- `TASK_TIMEOUT`
- `PARTIAL_SUCCESS`
- `POLICY_VIOLATION`
- `FACTORY_CONTRACT_MISSING`

---

## Golden Rule
- Factory Persona defines identity and contracts.
- Jim executes and reports against those contracts.

---

## Change Control
- Changes to this policy must be explicit and versioned.
- Runtime convenience must not override separation of concerns.
