def calculate_performance_score(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
) -> float:
    """Calculate an equally weighted performance score."""

    metrics = {
        "speed": speed,
        "agility": agility,
        "accuracy": accuracy,
        "consistency": consistency,
    }

    for name, value in metrics.items():
        if isinstance(value, bool) or not isinstance(value, (int, float)):
            raise ValueError(f"{name} must be a number")
        if not 0 <= value <= 100:
            raise ValueError(f"{name} must be between 0 and 100")

    score = sum(metrics.values()) / len(metrics)
    return round(score, 2)