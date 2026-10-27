import unittest

from assessment import assess_performance
from scoring.performance_score import calculate_performance_score
from scoring.performance_level import get_performance_level
from scoring.feedback import generate_feedback


class TestSportsAIAssessment(unittest.TestCase):

    def test_performance_score(self):
        self.assertEqual(
            calculate_performance_score(80, 75, 90, 85),
            82.5,
        )

    def test_score_boundaries(self):
        self.assertEqual(calculate_performance_score(0, 0, 0, 0), 0)
        self.assertEqual(calculate_performance_score(100, 100, 100, 100), 100)

    def test_invalid_metrics(self):
        invalid_values = [-1, 101, float("nan"), float("inf"), True, "80"]

        for value in invalid_values:
            with self.subTest(value=value):
                with self.assertRaises(ValueError):
                    calculate_performance_score(value, 75, 90, 85)

    def test_performance_level_boundaries(self):
        cases = [
            (0, "Needs Improvement"),
            (49.99, "Needs Improvement"),
            (50, "Average"),
            (69.99, "Average"),
            (70, "Good"),
            (84.99, "Good"),
            (85, "Excellent"),
            (100, "Excellent"),
        ]

        for score, expected in cases:
            with self.subTest(score=score):
                self.assertEqual(get_performance_level(score), expected)

    def test_invalid_performance_scores(self):
        for score in [-1, 101, float("nan"), float("inf"), True, "80"]:
            with self.subTest(score=score):
                with self.assertRaises(ValueError):
                    get_performance_level(score)

    def test_complete_assessment(self):
        result = assess_performance(80, 75, 90, 85)

        self.assertEqual(
            result,
            {
                "metrics": {
                    "speed": 80,
                    "agility": 75,
                    "accuracy": 90,
                    "consistency": 85,
                },
                "overallScore": 82.5,
                "performanceLevel": "Good",
                "feedback": (
                    "Strongest area: Accuracy (90/100). "
                    "Focus on improving Agility (75/100)."
                ),
            },
        )

    def test_feedback_handles_ties(self):
        feedback = generate_feedback(90, 90, 50, 50)

        self.assertIn("Speed, Agility", feedback)
        self.assertIn("Accuracy, Consistency", feedback)


    def test_custom_performance_weights(self):
        score = calculate_performance_score(
            100, 80, 60, 40,
            weights={
                "speed": 4,
                "agility": 3,
                "accuracy": 2,
                "consistency": 1,
            },
        )
        self.assertEqual(score, 80)

    def test_default_weights_remain_equal(self):
        self.assertEqual(
            calculate_performance_score(80, 75, 90, 85),
            82.5,
        )

    def test_invalid_weights(self):
        valid_weights = {
            "speed": 1,
            "agility": 1,
            "accuracy": 1,
            "consistency": 1,
        }

        invalid_weights = [
            [],
            {"speed": 1},
            {**valid_weights, "speed": -1},
            {**valid_weights, "speed": float("nan")},
            {**valid_weights, "speed": True},
            {name: 0 for name in valid_weights},
        ]

        for weights in invalid_weights:
            with self.subTest(weights=weights):
                
                with self.assertRaises(ValueError):
                    calculate_performance_score(
                        80, 75, 90, 85, weights=weights
                    )

    def test_custom_weights_reject_non_dictionary(self):
        with self.assertRaises(ValueError):
            calculate_performance_score(
                80, 75, 90, 85, weights=[]
            )

if __name__ == "__main__":
    unittest.main()
