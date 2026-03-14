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

UPDATE kevin_workouts
SET routine_completed = {{completed}},
    corrected = 1
WHERE record_id = {{record_id}};

INSERT INTO kevin_workouts (date, routine_completed, corrected, record_id)
VALUES (CURRENT_DATE, {{completed}}, 0, {{record_id}} || '-correction');

UPDATE kevin_exercise_history
SET corrected = 1
WHERE record_id = {{record_id}}
  AND corrected = 0;

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
    COALESCE({{date}}, CURRENT_DATE),
    {{routine_day}},
    {{exercise_name}},
    {{current_weight}},
    {{sets_completed}},
    {{reps_target}},
    0,
    {{record_id}} || '-correction'
WHERE {{exercise_name}} IS NOT NULL
  AND {{current_weight}} IS NOT NULL;
