-- {{TASK_ID}} query template
-- Replace placeholders with concrete values at execution time.

SELECT
  {{TASK_QUERY_PARAMS}}
FROM {{ENTITY_TABLE}}
{{TASK_SQL_TEMPLATE}};
