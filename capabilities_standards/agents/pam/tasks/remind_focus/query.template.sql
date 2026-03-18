WITH top_todos AS (
  SELECT todo_id, title, priority_rank, due_date
  FROM pam_todos
  WHERE status = 'active'
  ORDER BY COALESCE(priority_rank, 999) ASC, updated_at DESC
  LIMIT COALESCE({{max_items}}, 3)
),
reading AS (
  SELECT reading_id, description, updated_at
  FROM pam_reading_items
  WHERE status = 'unread'
  ORDER BY updated_at DESC
  LIMIT COALESCE({{max_items}}, 3)
)
SELECT
  (SELECT COUNT(*) FROM pam_todos WHERE status = 'active') AS active_todo_count,
  (SELECT COUNT(*) FROM pam_reading_items WHERE status = 'unread') AS unread_count,
  (SELECT list(todo_id) FROM top_todos) AS todo_candidates,
  (SELECT list(reading_id) FROM reading) AS reading_candidates;
