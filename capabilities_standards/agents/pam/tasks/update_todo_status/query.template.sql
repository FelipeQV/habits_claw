WITH previous AS (
  SELECT todo_id, status AS previous_status
  FROM pam_todos
  WHERE todo_id = {{todo_id}}
)
UPDATE pam_todos
SET status = {{status}},
    updated_at = now()
WHERE todo_id = {{todo_id}}
RETURNING todo_id, (SELECT previous_status FROM previous), status, updated_at;
