SELECT
  reading_id,
  url,
  description,
  categories,
  priority_label,
  priority_rank,
  source,
  created_at,
  updated_at
FROM pam_reading_items
WHERE status = 'unread'
  AND ({{category}} IS NULL OR list_contains(categories, {{category}}))
ORDER BY
  COALESCE(priority_rank, 999) ASC,
  CASE WHEN COALESCE({{sort_by}}, 'updated_at') = 'created_at' THEN created_at END DESC,
  CASE WHEN COALESCE({{sort_by}}, 'updated_at') = 'updated_at' THEN updated_at END DESC
LIMIT COALESCE({{limit}}, 50);
