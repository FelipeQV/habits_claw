WITH previous AS (
  SELECT reading_id, status AS previous_status
  FROM pam_reading_items
  WHERE reading_id = {{reading_id}}
)
UPDATE pam_reading_items
SET status = {{status}},
    updated_at = now()
WHERE reading_id = {{reading_id}}
RETURNING reading_id, (SELECT previous_status FROM previous), status, updated_at;
