#!/usr/bin/env python3
from __future__ import annotations
import csv
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

TZ = ZoneInfo("America/Mexico_City")
BASE = Path("/home/ubuntu/personal/habit_tracker/data")
MEALS = BASE / "meals.csv"
WORKOUTS = BASE / "workouts.csv"


@dataclass
class Health:
    status: str
    issues: list[str]


def today_str() -> str:
    return datetime.now(TZ).strftime("%Y-%m-%d")


def read_csv(path: Path):
    if not path.exists():
        raise FileNotFoundError(str(path))
    with path.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def to_float(v: str) -> float:
    try:
        return float((v or "").strip())
    except Exception:
        return 0.0


def to_int(v: str) -> int:
    try:
        return int(float((v or "").strip()))
    except Exception:
        return 0


def semaforo(delta: float, metric: str) -> str:
    # Simple thresholds for readability
    d = abs(delta)
    if metric == "kcal":
        return "🟢" if d <= 100 else "🟡" if d <= 250 else "🔴"
    return "🟢" if d <= 10 else "🟡" if d <= 25 else "🔴"


def main():
    date = today_str()
    issues = []

    try:
        meals = read_csv(MEALS)
    except Exception as e:
        meals = []
        issues.append(f"meals source unavailable: {e}")

    try:
        workouts = read_csv(WORKOUTS)
    except Exception as e:
        workouts = []
        issues.append(f"workouts source unavailable: {e}")

    health = Health("ok" if not issues else ("partial" if len(issues) == 1 else "missing"), issues)

    day_meals = [
        r for r in meals
        if (r.get("date") == date and str(r.get("corrected", "0")).strip() in ("0", "", "false", "False"))
    ]

    kcal = sum(to_float(r.get("calories", "0")) for r in day_meals)
    prot = sum(to_float(r.get("protein", "0")) for r in day_meals)
    carb = sum(to_float(r.get("carbs", "0")) for r in day_meals)
    fat = sum(to_float(r.get("fat", "0")) for r in day_meals)

    day_workouts = [r for r in workouts if r.get("date") == date]
    cardio = sum(to_int(r.get("cardio_min", "0")) for r in day_workouts)
    feeling_vals = [to_int(r.get("feeling", "0")) for r in day_workouts if str(r.get("feeling", "")).strip()]
    last_feeling = feeling_vals[-1] if feeling_vals else None

    # targets from nutrition plan
    tkcal, tprot, tcarb, tfat = 1900, 160, 180, 60
    dk, dp, dc, df = kcal - tkcal, prot - tprot, carb - tcarb, fat - tfat

    print(f"daily manager report ({date})")
    print(f"health: {health.status}")
    if issues:
        for i in issues:
            print(f"- issue: {i}")

    print("\nnutrition")
    print(f"🔥 {int(kcal)} {semaforo(dk, 'kcal')} {dk:+.0f} | 💪 {int(prot)} {semaforo(dp, 'macro')} {dp:+.0f} | 🍞 {int(carb)} {semaforo(dc, 'macro')} {dc:+.0f} | 🥑 {int(fat)} {semaforo(df, 'macro')} {df:+.0f}")
    print(f"meals_count: {len(day_meals)}")

    print("\ntraining")
    print(f"workout_done: {1 if day_workouts else 0}")
    print(f"cardio_total_min: {cardio}")
    print(f"last_feeling: {last_feeling if last_feeling is not None else 'n/a'}")


if __name__ == "__main__":
    main()
