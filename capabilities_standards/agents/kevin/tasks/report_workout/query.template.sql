WITH summary AS (
    SELECT
        SUM(cardio_minutes) AS cardio_total,
        SUM(CASE WHEN routine_completed = 1 THEN 1 ELSE 0 END) AS routine_days
  FROM kevin_workouts
    WHERE corrected = 0
      AND date BETWEEN {{report_from}} AND {{report_to}}
)
SELECT
    COALESCE(cardio_total, 0) AS cardio_minutes,
    COALESCE(routine_days, 0) AS routine_days,
    (COALESCE(cardio_total, 0) > 0) OR (COALESCE(routine_days, 0) > 0) AS workout_done
FROM summary;
