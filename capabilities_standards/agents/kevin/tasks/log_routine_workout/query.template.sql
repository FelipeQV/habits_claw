CREATE TABLE IF NOT EXISTS kevin_exercise_history (
    date DATE,
    routine_day INTEGER,
    exercise_name VARCHAR,
    weight_used DOUBLE,
    sets_completed INTEGER,
    reps_target VARCHAR,
    corrected BOOLEAN,
    record_id VARCHAR
);

WITH params AS (
  SELECT
    COALESCE({{date}}, CURRENT_DATE) AS resolved_date,
    COALESCE(
      {{record_id}},
      md5(
        CAST(COALESCE({{date}}, CURRENT_DATE) AS VARCHAR) || ':routine:' ||
        CAST({{routine_day}} AS VARCHAR) || ':' || COALESCE({{exercise_name}}, 'routine')
      )
    ) AS resolved_record_id
)
INSERT INTO kevin_workouts (date, routine_completed, corrected, record_id)
SELECT
  resolved_date,
  {{completed}},
  0,
  resolved_record_id
FROM params;

INSERT INTO kevin_exercise_history (
    date,
    routine_day,
    exercise_name,
    weight_used,
    sets_completed,
    reps_target,
    corrected,
    record_id
)
SELECT
    resolved_date,
    {{routine_day}},
    {{exercise_name}},
    {{current_weight}},
    {{sets_completed}},
    {{reps_target}},
    0,
    resolved_record_id
FROM (
  SELECT
    COALESCE({{date}}, CURRENT_DATE) AS resolved_date,
    COALESCE(
      {{record_id}},
      md5(
        CAST(COALESCE({{date}}, CURRENT_DATE) AS VARCHAR) || ':routine:' ||
        CAST({{routine_day}} AS VARCHAR) || ':' || COALESCE({{exercise_name}}, 'routine')
      )
    ) AS resolved_record_id
)
WHERE {{exercise_name}} IS NOT NULL
  AND {{current_weight}} IS NOT NULL;
