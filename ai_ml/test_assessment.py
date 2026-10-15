import unittest

from assessment import assess_performance
from scoring.performance_score import calculate_performance_score


class TestSportsAIAssessment(unittest.TestCase):

    def test_performance_score(self):
        score = calculate_performance_score(80, 75, 90, 85)
        self.assertEqual(score, 82.5)

    def test_complete_assessment(self):
        result = assess_performance(80, 75, 90, 85)

        self.assertEqual(result["overallScore"], 82.5)
        self.assertEqual(result["performanceLevel"], "Good")
        self.assertIn("feedback", result)

    def test_invalid_metric(self):
        with self.assertRaises(ValueError):
            calculate_performance_score(110, 75, 90, 85)


if __name__ == "__main__":
    unittest.main()