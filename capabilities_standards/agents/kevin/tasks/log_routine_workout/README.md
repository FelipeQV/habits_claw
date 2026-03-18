# log_routine_workout

- **Purpose:** Record whether a routine day was completed; the `completed` boolean ties to the active versioned routine JSON days.  
- **Routine source resolution:** Resolve `/home/ubuntu/habit_tracker/reference/routine_workout.active.json` first, then load the file in `active_version`.  
- **Schema guidance:** Accepts `routine_day` and `completed` plus optional `exercise_name`, `current_weight`, `sets_completed`, `reps_target`, `notes`, and `record_id`.  
- **Data integration:** Writes `routine_completed`, `record_id`, `corrected=0` into `kevin_workouts`; when exercise weight fields are present it also appends to `kevin_exercise_history`.  
- **Correction channel:** `update_routine_workout` carries the append-only correction semantics.  
