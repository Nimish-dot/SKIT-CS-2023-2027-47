def generate_feedback(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
) -> str:
    metrics = {
        "speed": speed,
        "agility": agility,
        "accuracy": accuracy,
        "consistency": consistency,
    }

    strongest = max(metrics, key=metrics.get)
    weakest = min(metrics, key=metrics.get)

    return (
        f"Strongest area: {strongest.capitalize()}. "
        f"Focus on improving {weakest} for better overall performance."
    )