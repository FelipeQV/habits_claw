# Report Meal — Output Format

## Output Template

## Reporte de comidas ({scope_label})

### Tabla 1 — Desglose por comida
| Comida | 🔥 K | 💪 P | 🍞 C | 🥑 F | 🌾 Fibra |
|---|---:|---:|---:|---:|---:|
| ... | ... | ... | ... | ... | ... |

### Tabla 2 — Totales
| Métrica | Total |
|---|---:|
| 🔥 Kcal | ~{kcal_total} |
| 💪 Proteína | ~{protein_total}g |
| 🍞 Carbs | ~{carbs_total}g |
| 🥑 Grasa | ~{fat_total}g |
| 🌾 Fibra | ~{fiber_total}g* |
| Comidas | {meal_count} |
| % estimado | {estimation_rate}% |

## Rules
- Inicia la respuesta visible al usuario con solo el emoji canónico de la capability; no muestres nombres técnicos de capability o task.
- Fiber total shown if available; if partial, mark estimada/parcial.
- If selector is single-day date, include daily delta-to-target snapshot.
- If selector is range/ambiguous historical context, skip target delta.