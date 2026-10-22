def generate_feedback(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
) -> str:
    """Generate rule-based feedback from four performance metrics."""

    metrics = {
        "Speed": speed,
        "Agility": agility,
        "Accuracy": accuracy,
        "Consistency": consistency,
    }

    strongest_score = max(metrics.values())
    weakest_score = min(metrics.values())

    strongest = [
        name for name, value in metrics.items()
        if value == strongest_score
    ]
    weakest = [
        name for name, value in metrics.items()
        if value == weakest_score
    ]

    strong_text = ", ".join(strongest)
    weak_text = ", ".join(weakest)

    return (
        f"Strongest area: {strong_text} ({strongest_score}/100). "
        f"Focus on improving {weak_text} ({weakest_score}/100)."
    )
