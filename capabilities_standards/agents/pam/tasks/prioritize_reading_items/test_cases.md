# test_cases — prioritize_reading_items

## Case 1: Set priority_label and priority_rank
Input: `{ "reading_id": "abc123", "priority_label": "high", "priority_rank": 1 }`
Expected: ok=true, data contains updated priority fields.

## Case 2: Set only priority_label
Input: `{ "reading_id": "abc123", "priority_label": "low" }`
Expected: ok=true, priority_rank unchanged (COALESCE).

## Case 3: Set only priority_rank
Input: `{ "reading_id": "abc123", "priority_rank": 5 }`
Expected: ok=true, priority_label unchanged (COALESCE).

## Case 4: Missing reading_id
Input: `{ "priority_label": "high" }`
Expected: ok=false, VALIDATION_ERROR.

## Case 5: Neither priority_label nor priority_rank provided
Input: `{ "reading_id": "abc123" }`
Expected: ok=false, VALIDATION_ERROR (anyOf not satisfied).

## Case 6: reading_id not found
Input: `{ "reading_id": "does-not-exist", "priority_rank": 1 }`
Expected: ok=false, NOT_FOUND.
