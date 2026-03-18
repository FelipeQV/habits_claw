UPDATE pam_reading_items
SET categories = {{categories}},
    updated_at = now()
WHERE reading_id = {{reading_id}}
RETURNING reading_id, categories, updated_at;
