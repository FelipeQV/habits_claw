UPDATE kevin_workouts
SET cardio_minutes = {{minutes}},
    cardio_type = {{cardio_type}},
    corrected = 1
WHERE record_id = {{record_id}};

INSERT INTO kevin_workouts (date, cardio_minutes, cardio_type, routine_completed, corrected, record_id)
VALUES (CURRENT_DATE, {{minutes}}, {{cardio_type}}, 0, 0, {{record_id}} || '-correction');
