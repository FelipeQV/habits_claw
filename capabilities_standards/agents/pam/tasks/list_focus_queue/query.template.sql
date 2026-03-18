WITH todos AS (
  SELECT
    todo_id,
    title,
    status,
    priority_label,
    priority_rank,
    due_date,
    updated_at,
    CASE
      WHEN due_date IS NOT NULL AND due_date <= current_date THEN 1
      ELSE 0
    END AS due_soon
  FROM pam_todos
  WHERE status = 'active' OR (COALESCE({{include_deferred}}, false) = true AND status = 'deferred')
),
reading_backlog AS (
  SELECT COUNT(*) AS unread_count
  FROM pam_reading_items
  WHERE status = 'unread'
)
SELECT
  t.todo_id,
  t.title,
  t.status,
  t.priority_label,
  t.priority_rank,
  t.due_date,
  t.updated_at,
  t.due_soon,
  rb.unread_count
FROM todos t
CROSS JOIN reading_backlog rb
ORDER BY
  COALESCE(t.priority_rank, 999) ASC,
  t.due_soon DESC,
  t.updated_at DESC
LIMIT COALESCE({{limit}}, 20);
