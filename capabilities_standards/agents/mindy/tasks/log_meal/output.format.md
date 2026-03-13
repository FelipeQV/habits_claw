# Log Meal — Output Format

## Output Template

| 🔥 Kcal | 💪 P | 🍞 C | 🥑 F | 🌾 Fibra |
|---|---:|---:|---:|---:|
| ~{calories} | ~{protein}g | ~{carbs}g | ~{fat}g | ~{fiber}g* |

vs target (hoy acumulado): 🔥 {kcal_diff} | 💪 {protein_diff}g | 🍞 {carbs_diff}g | 🥑 {fat_diff}g

## Rules
- Inicia la respuesta visible al usuario con solo el emoji canónico de la capability; no muestres nombres técnicos de capability o task.
- Negative = faltante.
- Positive = excedente.
- Fiber stays informative only (no target).