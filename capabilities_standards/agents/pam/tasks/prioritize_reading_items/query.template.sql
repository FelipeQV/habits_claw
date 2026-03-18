UPDATE pam_reading_items
SET priority_label = COALESCE({{priority_label}}, priority_label),
    priority_rank = COALESCE({{priority_rank}}, priority_rank),
    updated_at = now()
WHERE reading_id = {{reading_id}}
RETURNING reading_id, priority_label, priority_rank, updated_at;
