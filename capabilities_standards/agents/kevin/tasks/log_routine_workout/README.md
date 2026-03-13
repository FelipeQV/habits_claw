# log_routine_workout

- **Purpose:** Record whether a routine day was completed; the `completed` boolean ties to `routine_workout.json` days.  
- **Schema guidance:** Accepts `routine_day` and `completed` along with optional `notes` and `record_id`.  
- **Data integration:** Writes `routine_completed`, `record_id`, `corrected=0` into `workouts`.  
- **Correction channel:** `update_routine_workout` carries the append-only correction semantics.  
