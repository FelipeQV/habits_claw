# log_routine_workout prompt

Confirm routine day number + completion, resolve `routine_workout.active.json`, load the referenced versioned routine file for focus/exercises, capture exercise-level weight/sets when provided, run SQL inserts for both completion and exercise history, and describe completion summary including recorded weight context.
User-visible response must start with `✏️` as the first token.
