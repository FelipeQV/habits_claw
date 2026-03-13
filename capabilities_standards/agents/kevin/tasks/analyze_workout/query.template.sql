WITH range AS (
  SELECT
    date,
    SUM(cardio_minutes) AS cardio_total,
    SUM(CASE WHEN routine_completed = 1 THEN 1 ELSE 0 END) AS routine_days
  FROM kevin_workouts
  WHERE corrected = 0
    AND date BETWEEN COALESCE({{range.from}}, {{date}}) AND COALESCE({{range.to}}, {{date}})
  GROUP BY date
)
SELECT
  AVG(cardio_total) AS avg_cardio,
  SUM(routine_days) AS total_routine_days
FROM range;
