UPDATE pam_todos
SET priority_label = COALESCE({{priority_label}}, priority_label),
    priority_rank = COALESCE({{priority_rank}}, priority_rank),
    updated_at = now()
WHERE todo_id = {{todo_id}}
RETURNING todo_id, priority_label, priority_rank, updated_at;
