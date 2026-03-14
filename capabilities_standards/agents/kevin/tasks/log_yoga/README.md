# log_yoga

- **Purpose:** Capture yoga sessions by recording whether yoga was done and which yoga type was performed.  
- **Schema set:** `input.schema.json`, `output.schema.json`.  
- **Data path:** inserts into `kevin_workouts` with `yoga_done`, `yoga_type`, `record_id`, `corrected=0`.  
- **Correction flow:** Use `update_yoga` to append a corrected record after marking the previous row `corrected=1`.  
- **Smoke fixture:** executes `tools/kevin_smoke_fixture.sql` before running `log_yoga` tests.  
