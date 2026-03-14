# report_workout

- Summarizes cardio minutes/routine days for a single day or range and derives `workout_done` plus `cardio_total_min` for Jim’s contract.  
- Input supports either `date` OR `from`/`to` selectors; optional `exercise_name` returns previous logged weight context from `kevin_exercise_history`.  
- SQL template aggregates `kevin_workouts` filtering `corrected = 0` and enriches response with the latest non-corrected weight record for the requested exercise.  
- Use this output in Jim’s ingestion to keep `workout_done` and `cardio_total_min` up to date.  
