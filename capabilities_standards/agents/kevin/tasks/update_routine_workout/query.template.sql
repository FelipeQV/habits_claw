UPDATE kevin_workouts
SET routine_completed = {{completed}},
    corrected = 1
WHERE record_id = {{record_id}};

INSERT INTO kevin_workouts (date, routine_completed, corrected, record_id)
VALUES (CURRENT_DATE, {{completed}}, 0, {{record_id}} || '-correction');
