-- Fixtures for Kevin cardio/routine flows
CREATE TABLE IF NOT EXISTS kevin_workouts (
    date DATE,
    cardio_minutes INTEGER,
    cardio_type VARCHAR,
    routine_completed BOOLEAN,
    corrected BOOLEAN,
    record_id VARCHAR
);
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
DELETE FROM kevin_workouts WHERE date >= date_trunc('week', current_date);
DELETE FROM kevin_exercise_history WHERE date >= date_trunc('week', current_date);

INSERT INTO kevin_workouts (date, cardio_minutes, cardio_type, routine_completed, corrected, record_id)
VALUES
  (current_date, 30, 'run', FALSE, 0, 'cardio-smoke-1'),
  (current_date - INTERVAL '1 day', 25, 'bike', FALSE, 0, 'cardio-smoke-2'),
  (current_date - INTERVAL '1 day', NULL, NULL, TRUE, FALSE, 'routine-smoke-1');

INSERT INTO kevin_exercise_history (date, routine_day, exercise_name, weight_used, sets_completed, reps_target, corrected, record_id)
VALUES
  (current_date - INTERVAL '3 day', 2, 'Press inclinado con mancuernas', 32.5, 3, '8-10', 0, 'routine-smoke-1'),
  (current_date - INTERVAL '1 day', 2, 'Press inclinado con mancuernas', 35.0, 3, '8-10', 0, 'routine-smoke-2');
