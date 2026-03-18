# prioritize_reading_items

Sets or updates the priority label and rank on a reading item.

**Capability:** update (📝)
**Access mode:** write_correction
**Table:** pam_reading_items

## Inputs
- `reading_id` (required): ID of the reading item to prioritize.
- `priority_label` (optional): Human label — e.g. `high`, `medium`, `low`.
- `priority_rank` (optional): Integer rank for deterministic sort (lower = higher priority).

At least one of `priority_label` or `priority_rank` must be provided.

## Behavior
- COALESCE pattern: only overwrites fields that are explicitly passed.
- Returns updated reading_id, priority_label, priority_rank, updated_at.
