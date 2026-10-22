import math


def get_performance_level(score: float) -> str:
    """Classify an overall performance score from 0 to 100."""

    if isinstance(score, bool) or not isinstance(score, (int, float)):
        raise ValueError("Score must be a number")

    if not math.isfinite(score) or not 0 <= score <= 100:
        raise ValueError("Score must be between 0 and 100")

    if score >= 85:
        return "Excellent"
    if score >= 70:
        return "Good"
    if score >= 50:
        return "Average"
    return "Needs Improvement"
