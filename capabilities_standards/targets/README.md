# Targets versioning process

- Versioned target files (for example `nutrition_targets_YYYY-MM.json`) are immutable once published.
- When new targets are published, create a new versioned file and update `nutrition_targets.active.json` (`active_version`, `effective_from`, and optional notes).
- Keep all historical versioned files for auditability and replay.
- Recommended future DB approach: at write-time, store a snapshot of resolved target values and/or link each write to the target version used.
