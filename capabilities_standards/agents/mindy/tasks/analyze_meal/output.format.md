# Analyze Meal — Output Format

## Output Template

## Insight ({scope_label})

### Tabla 1 — Desglose por comida
| Comida | 🔥 K | 💪 P | 🍞 C | 🥑 F | 🌾 Fibra |
|---|---:|---:|---:|---:|---:|
| ... | ... | ... | ... | ... | ... |

### Tabla 2 — Totales vs Target
| | Hoy | Target | Dif |
|---|---:|---:|---:|
| 🔥 Kcal | ~{kcal_total} | {kcal_target} | {kcal_diff} |
| 💪 Proteína | ~{protein_total}g | {protein_target_g}g | {protein_diff}g |
| 🍞 Carbs | ~{carbs_total}g | {carbs_target_g}g | {carbs_diff}g |
| 🥑 Grasa | ~{fat_total}g | {fat_target_g}g | {fat_diff}g |
| 🌾 Fibra | ~{fiber_total}g* | — | {fiber_note} |

### Tácticas de hoy (accionables)
- {tactic_1}
- {tactic_2}
- {tactic_3}

Confianza: {low|mid|high} ({short_basis})

## Rules
- Inicia la respuesta visible al usuario con solo el emoji canónico de la capability; no muestres nombres técnicos de capability o task.
- Fiber: no target comparison, but still useful as observed metric.