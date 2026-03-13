# update_cardio

- Marks the prior cardio record as `corrected=1` and appends a new record carrying corrected minutes/type.  
- Input expects `record_id` for the row to adjust, plus updated `minutes` and optional `cardio_type`.  
- Output returns new `record_id` and effective cardio values for reporting validation.  
