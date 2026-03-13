# log_cardio

- **Purpose:** Capture cardio sessions with minutes and type, flagged for inference when needed.  
- **Schema set:** `input.schema.json`, `output.schema.json`.  
- **Data path:** inserts into `workouts` table with `cardio_minutes`, `cardio_type`, `record_id`, `corrected=0`.  
- **Correction flow:** Use `update_cardio` to append a new record after marking the previous row `corrected=1`.  
- **Smoke fixture:** executes `tools/kevin_smoke_fixture.sql` before running `log_cardio` tests.  
