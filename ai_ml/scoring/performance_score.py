def calculate_performance_score(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
) -> float:
    """
    Calculate an overall performance score.

    Each performance metric is currently given equal weight.
    Values should be between 0 and 100.
    """

    score = (
        (speed * 0.25)
        + (agility * 0.25)
        + (accuracy * 0.25)
        + (consistency * 0.25)
    )

    return round(score, 2)