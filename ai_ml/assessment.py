from scoring.performance_score import calculate_performance_score
from scoring.performance_level import get_performance_level
from scoring.feedback import generate_feedback


def assess_performance(
    speed: float,
    agility: float,
    accuracy: float,
    consistency: float,
) -> dict:
    """Return a complete assessment for four performance metrics."""

    score = calculate_performance_score(
        speed=speed,
        agility=agility,
        accuracy=accuracy,
        consistency=consistency,
    )

    level = get_performance_level(score)

    feedback = generate_feedback(
        speed=speed,
        agility=agility,
        accuracy=accuracy,
        consistency=consistency,
    )

    return {
        "metrics": {
            "speed": speed,
            "agility": agility,
            "accuracy": accuracy,
            "consistency": consistency,
        },
        "overallScore": score,
        "performanceLevel": level,
        "feedback": feedback,
    }