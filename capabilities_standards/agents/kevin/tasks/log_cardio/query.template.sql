INSERT INTO kevin_workouts (date, cardio_minutes, cardio_type, routine_completed, corrected, record_id)
VALUES (
    {{date}},
    {{minutes}},
    {{cardio_type}},
    0,
    0,
    COALESCE({{record_id}}, uuid())
);
