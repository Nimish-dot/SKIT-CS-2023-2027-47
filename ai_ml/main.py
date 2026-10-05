from scoring.performance_score import calculate_performance_score


def main():
    # Sample performance values for testing.
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

    print("SportsAI Performance Assessment")
    print("--------------------------------")
    print(f"Speed: {speed}")
    print(f"Agility: {agility}")
    print(f"Accuracy: {accuracy}")
    print(f"Consistency: {consistency}")
    print(f"Overall Performance Score: {score}")


if __name__ == "__main__":
    main()