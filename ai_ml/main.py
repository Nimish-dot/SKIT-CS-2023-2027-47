from scoring.performance_score import calculate_performance_score
from scoring.performance_level import get_performance_level
from scoring.feedback import generate_feedback


def main():
    speed = 80
    agility = 75
    accuracy = 90
    consistency = 85

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

    print("SportsAI Performance Assessment")
    print("--------------------------------")
    print(f"Speed: {speed}")
    print(f"Agility: {agility}")
    print(f"Accuracy: {accuracy}")
    print(f"Consistency: {consistency}")
    print(f"Overall Performance Score: {score}")
    print(f"Performance Level: {level}")
    print(f"Feedback: {feedback}")


if __name__ == "__main__":
    main()