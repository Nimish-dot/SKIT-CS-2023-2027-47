def get_performance_level(score: float) -> str:
    if score >= 85:
        return "Excellent"
    if score >= 70:
        return "Good"
    if score >= 50:
        return "Average"
    return "Needs Improvement"