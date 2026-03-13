# Protocol (Agnostic)

## Purpose
Defines a capability-agnostic response envelope and execution expectations for compliant agents.

## Canonical Envelope
```json
{
  "protocol_version": "{{PROTOCOL_VERSION}}",
  "task": "{{CAPABILITY_TASK_NAME}}",
  "ok": true,
  "data": {},
  "error": null,
  "meta": {
    "source": "duckdb",
    "db_path": "{{DB_PATH}}",
    "timestamp": "{{TIMESTAMP_ISO}}",
    "agent_id": "{{AGENT_ID}}"
  }
}
```

## Separation
- Prompt templates define behavior/voice/decision.
- Architecture/contracts define implementation/wiring/validation.
