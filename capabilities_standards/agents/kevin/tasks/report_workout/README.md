# report_workout

- Summarizes cardio minutes/routine days for a single day or range and derives `workout_done` plus `cardio_total_min` for Jim’s contract.  
- Input supports either `date` OR `from`/`to` selectors; SQL template aggregates `workouts` filtering `corrected = 0`.  
- Use this output in Jim’s ingestion to keep `workout_done` and `cardio_total_min` up to date.  
