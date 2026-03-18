SELECT
  reading_id,
  url,
  description,
  status,
  categories,
  source,
  created_at,
  updated_at
FROM pam_reading_items
WHERE ({{query}} IS NULL OR lower(description) LIKE '%' || lower({{query}}) || '%' OR lower(url) LIKE '%' || lower({{query}}) || '%')
  AND ({{status}} IS NULL OR status = {{status}})
  AND ({{category}} IS NULL OR list_contains(categories, {{category}}))
  AND ({{source}} IS NULL OR source = {{source}})
  AND ({{from}} IS NULL OR CAST(created_at AS DATE) >= {{from}})
  AND ({{to}} IS NULL OR CAST(created_at AS DATE) <= {{to}})
ORDER BY updated_at DESC
LIMIT COALESCE({{limit}}, 50);
