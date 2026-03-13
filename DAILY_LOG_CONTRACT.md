# DAILY_LOG_CONTRACT.md

## Daily Log Data Contract (v1)

| column | format | source | notes |
|---|---|---|---|
| date | `YYYY-MM-DD` | system timezone (`America/Mexico_City`) | primary key |
| sleep_hours | `number` or empty | AM check-in (fallback PM only if AM missing) | examples: `5`, `7.5` |
| sleep_quality | `integer 1-5` or empty | AM check-in (fallback PM only if AM missing) |  |
| dream_note | `string` or empty | AM check-in (fallback PM only if AM missing) | optional |
| meditation_done | `yes|no` | PM check-in |  |
| workout_done | `yes|no` | Kevin (`kevin_workouts` table in `/home/ubuntu/health_system.duckdb`, derived) | `yes` if workout rows exist for date |
| cardio_total_min | `integer >= 0` or empty | Kevin (`kevin_workouts` table in `/home/ubuntu/health_system.duckdb`, derived) | sum of `cardio_minutes` |
| yoga_done | `yes|no` | PM check-in | independent from Kevin |
| steps | `integer >= 0` or empty | PM check-in | end-of-day capture |
| energy | `integer 1-5` | PM check-in |  |
| mood | `integer 1-5` | PM check-in |  |
| social_done | `yes|no` | PM check-in |  |
| social_note | `string` or empty | PM check-in | optional detail |
| day_note | `string` | PM check-in | open summary of day |
| meals_count | `integer >= 0` | Mindy (`meals.csv`, derived) | count by `date` |
| kcal_total | `number >= 0` | Mindy (`meals.csv`, derived) | sum of `calories` |
| kcal_target | `number >= 0` | nutrition plan/config | current target |
| protein_total | `number >= 0` | Mindy (`meals.csv`, derived) | sum of `protein` |
| protein_target | `number >= 0` | nutrition plan/config | current target |
| carbs_total | `number >= 0` | Mindy (`meals.csv`, derived) | sum of `carbs` |
| carbs_target | `number >= 0` | nutrition plan/config | current target |
| fat_total | `number >= 0` | Mindy (`meals.csv`, derived) | sum of `fat` |
| fat_target | `number >= 0` | nutrition plan/config | current target |
| data_health | `string` or empty | Jim (derived validation) | leave empty by default; fill only if issue |
| missing_sources | `string` or empty | Jim (derived validation) | leave empty by default; fill only if issue |
| manager_note | `string` or empty | Jim | optional operational note |

## Runtime Rules
- AM flow captures: `sleep_hours`, `sleep_quality`, optional `dream_note`.
- PM asks sleep fields only if AM was not answered.
- PM flow captures: `energy`, `mood`, `social_done`, `social_note` (optional), `meditation_done`, `yoga_done`, `steps`, `day_note`.
- Kevin contributes workout/cardio derived fields.
- Mindy contributes meals/macros derived fields and uses current nutrition targets.
- Keep `data_health` and `missing_sources` empty unless there is an actual data issue.
