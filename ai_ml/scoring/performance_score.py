
import math


def calculate_performance_score(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
    weights: dict | None = None,
) -> float:
    """Calculate a weighted performance score from 0 to 100.

    If weights are omitted, all four metrics receive equal weight.
    Custom weights are normalized by their total.
    """

    metrics = {
        "speed": speed,
        "agility": agility,
        "accuracy": accuracy,
        "consistency": consistency,
    }

    for name, value in metrics.items():
        if isinstance(value, bool) or not isinstance(value, (int, float)):
            raise ValueError(f"{name} must be a number")
        if not math.isfinite(value) or not 0 <= value <= 100:
            raise ValueError(f"{name} must be between 0 and 100")

    if weights is None:
        weights = {name: 1 for name in metrics}

    if not isinstance(weights, dict):
        raise ValueError("Weights must be a dictionary")

    if set(weights) != set(metrics):
        raise ValueError(
            "Weights must contain speed, agility, accuracy, and consistency"
        )

    for name, weight in weights.items():
        if isinstance(weight, bool) or not isinstance(weight, (int, float)):
            raise ValueError(f"Weight for {name} must be a number")
        if not math.isfinite(weight) or weight < 0:
            raise ValueError(f"Weight for {name} must be finite and non-negative")

    total_weight = sum(weights.values())

    if total_weight <= 0 or not math.isfinite(total_weight):
        raise ValueError("Total weight must be finite and greater than zero")

    score = sum(
        metrics[name] * weights[name] for name in metrics
    ) / total_weight

    return round(score, 2)
