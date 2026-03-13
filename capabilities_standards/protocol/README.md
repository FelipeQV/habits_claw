Status: Final
Version: 1.0.0

Purpose:
Define a single, capability-agnostic task protocol so any compliant agent can execute predictably.

Scope:
- Protocol and envelope semantics (agent/domain neutral)
- Capability-level contracts (e.g., `log`, `update`, `report`, `analyze`, `prescribe`)
- Data backend compatibility (DuckDB supported)
- Channel-agnostic payload behavior (rendering may vary by surface)

## Design Principles

1. Contract-first: schema defines behavior.
2. Agent-agnostic: protocol does not encode agent identity or domain tables.
3. Deterministic outputs: same task class => same envelope/shape contract.
4. Strict errors: stable error codes and structure.
5. Separation of concerns:
   - Task payload (machine)
   - Rendered message (human)

## Canonical Response Envelope

All task classes MUST return:

```json
{
  "protocol_version": "1.0.0",
  "task": "<capability_task_name>",
  "ok": true,
  "data": {},
  "error": null,
  "meta": {
    "source": "duckdb",
    "db_path": "<path-or-identifier>",
    "timestamp": "2026-03-09T22:30:00Z",
    "trace_id": "uuid-or-short-id",
    "agent_id": "string"
  }
}
```

## File Locations

- Shared protocol errors: `capabilities_standards/protocol/errors.json`
- Shared capability contract guidance: `capabilities_standards/protocol/agent-contracts.md`
- Agent/domain-specific contract ownership: `capabilities_standards/agents/<agent>/agent-contracts.md`
