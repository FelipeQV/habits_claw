-- Block 1: day totals vs active target (fast summary input)
WITH t AS (
    SELECT
        nutrition_target_id,
        kcal_target,
        protein_target_g,
        carbs_target_g,
        fat_target_g
    FROM nutrition_targets
    WHERE effective_to IS NULL
    ORDER BY effective_from DESC
    LIMIT 1
),
d AS (
    SELECT
        COALESCE(SUM(calories), 0) AS calories_actual,
        COALESCE(SUM(protein), 0) AS protein_actual,
        COALESCE(SUM(carbs), 0) AS carbs_actual,
        COALESCE(SUM(fat), 0) AS fat_actual
    FROM meals
    WHERE corrected = 0
      AND date = {{report_date}}
)
SELECT
    {{report_date}} AS report_date,
    d.calories_actual,
    d.protein_actual,
    d.carbs_actual,
    d.fat_actual,
    t.nutrition_target_id,
    t.kcal_target,
    t.protein_target_g,
    t.carbs_target_g,
    t.fat_target_g,
    d.calories_actual - t.kcal_target AS kcal_diff,
    d.protein_actual - t.protein_target_g AS protein_diff,
    d.carbs_actual - t.carbs_target_g AS carbs_diff,
    d.fat_actual - t.fat_target_g AS fat_diff
FROM d
CROSS JOIN t;

-- Block 2: meal list for the same date (detail rows)
SELECT
    date,
    time,
    meal_type,
    food_description,
    calories,
    protein,
    carbs,
    fat,
    macro_estimated,
    corrected,
    comments
FROM meals
WHERE corrected = 0
  AND date = {{report_date}}
ORDER BY time;