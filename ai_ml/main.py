from assessment import assess_performance


def main():
    result = assess_performance(
        speed=80,
        agility=75,
        accuracy=90,
        consistency=85,
    )

    print("SportsAI Performance Assessment")
    print("--------------------------------")

    for metric, value in result["metrics"].items():
        print(f"{metric.capitalize()}: {value}")

    print(f"Overall Performance Score: {result['overallScore']}")
    print(f"Performance Level: {result['performanceLevel']}")
    print(f"Feedback: {result['feedback']}")


if __name__ == "__main__":
    main()