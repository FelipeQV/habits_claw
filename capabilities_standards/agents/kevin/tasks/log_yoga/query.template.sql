INSERT INTO kevin_workouts (date, yoga_done, yoga_type, routine_completed, corrected, record_id)
VALUES (
    {{date}},
    1,
    {{yoga_type}},
    0,
    0,
    COALESCE({{record_id}}, uuid())
);
