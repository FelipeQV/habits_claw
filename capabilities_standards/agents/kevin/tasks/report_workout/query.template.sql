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

WITH summary AS (
    SELECT
        SUM(cardio_minutes) AS cardio_total,
        SUM(CASE WHEN routine_completed = 1 THEN 1 ELSE 0 END) AS routine_days
    FROM kevin_workouts
    WHERE corrected = 0
      AND date BETWEEN {{report_from}} AND {{report_to}}
),
previous_exercise AS (
    SELECT
      exercise_name,
      weight_used,
      sets_completed,
      reps_target,
      routine_day,
      date
    FROM kevin_exercise_history
    WHERE corrected = 0
      AND {{exercise_name}} IS NOT NULL
      AND lower(exercise_name) = lower({{exercise_name}})
    ORDER BY date DESC
    LIMIT 1
)
SELECT
    COALESCE(cardio_total, 0) AS cardio_minutes,
    COALESCE(routine_days, 0) AS routine_days,
    (COALESCE(cardio_total, 0) > 0) OR (COALESCE(routine_days, 0) > 0) AS workout_done,
    (
      SELECT struct_pack(
        exercise_name := exercise_name,
        previous_weight := weight_used,
        sets_completed := sets_completed,
        reps_target := reps_target,
        routine_day := routine_day,
        logged_on := date
      )
      FROM previous_exercise
    ) AS previous_exercise
FROM summary;
