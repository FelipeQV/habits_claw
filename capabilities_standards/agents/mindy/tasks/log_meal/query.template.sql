-- Block 1: log one meal (minimal write path)
INSERT INTO meals (
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
)
VALUES (
    {{date}},
    {{time}},
    {{meal_type}},
    {{food_description}},
    {{calories}},
    {{protein}},
    {{carbs}},
    {{fat}},
    {{macro_estimated}},
    {{corrected}},
    {{comments}}
);

-- Optional confirmation read (run right after insert when needed):
-- SELECT date, time, meal_type, food_description, calories, protein, carbs, fat, corrected
-- FROM meals
-- WHERE date = {{date}}
-- ORDER BY time DESC
-- LIMIT 1;