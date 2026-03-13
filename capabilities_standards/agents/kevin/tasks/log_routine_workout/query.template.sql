INSERT INTO kevin_workouts (date, routine_completed, corrected, record_id)
VALUES (
    {{date}},
    {{completed}},
    0,
    COALESCE({{record_id}}, uuid())
);
