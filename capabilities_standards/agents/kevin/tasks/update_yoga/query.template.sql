UPDATE kevin_workouts
SET yoga_done = 1,
    yoga_type = {{yoga_type}},
    corrected = 1
WHERE record_id = {{record_id}};

INSERT INTO kevin_workouts (date, yoga_done, yoga_type, routine_completed, corrected, record_id)
VALUES (CURRENT_DATE, 1, {{yoga_type}}, 0, 0, {{record_id}} || '-correction');
