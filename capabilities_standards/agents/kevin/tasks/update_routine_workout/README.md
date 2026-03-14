# update_routine_workout

- Mirrors `update_cardio` correction flow for routine completion.  
- Requires `record_id` to locate the prior entry, marks it corrected, and writes a new row with `completed` flag.  
- If `exercise_name` + `current_weight` are provided, also preserves correction lineage in `kevin_exercise_history` so the latest weight per exercise remains queryable.  
