# SportsAI - AI/ML Module

This module contains the AI/ML foundation for the SportsAI project.

## Week 1 Scope

The first week establishes the basic performance scoring structure.

Current performance metrics:

- Speed
- Agility
- Accuracy
- Consistency

Each metric currently contributes 25% to the overall performance score.

## Current Status

The Week 1 implementation is a placeholder scoring foundation.

Actual video analysis, pose detection, feature extraction, and machine learning-based performance assessment will be implemented in later development stages.

## Planned AI/ML Pipeline

1. Performance video upload
2. Video preprocessing
3. Pose detection
4. Feature extraction
5. Performance analysis
6. ML-based scoring
7. Feedback generation

## Week 2 AI/ML Development

During Week 2, the AI/ML module was extended from the initial
performance scoring foundation.

### Added in Week 2

- Performance level classification
- Rule-based performance feedback
- Integration of performance score, level and feedback
- Modular scoring structure

### Performance Levels

| Score | Level |
|---|---|
| 85–100 | Excellent |
| 70–84.99 | Good |
| 50–69.99 | Average |
| Below 50 | Needs Improvement |

### Current AI/ML Scope

The current module uses predefined performance metrics:

- Speed
- Agility
- Accuracy
- Consistency

These metrics are combined to calculate an overall performance score.

Performance level and basic feedback are generated from the calculated
score and individual metrics.

Actual video-based pose detection, feature extraction and trained
machine learning models will be implemented during later development
stages.
## Week 3 AI/ML Development

### Improvements
- Added validation for performance metrics between 0 and 100.
- Created a reusable assessment function.
- Standardized assessment output for backend integration.
- Added automated unit tests for scoring and validation.

### Assessment Output
The assessment function returns:
- Individual performance metrics
- Overall performance score
- Performance level
- Rule-based feedback

### Current Limitations
The current system uses rule-based scoring and feedback.
It does not yet perform video analysis, pose estimation, or
prediction using a trained machine learning model.
## Week 4 AI/ML Development

### Improvements
- Strengthened validation for performance scores.
- Added tests for score boundaries and invalid numeric values.
- Improved rule-based feedback for tied strongest and weakest metrics.
- Standardized the expected assessment output.

### Run the assessment
Run from the `ai_ml` directory:

```bash
python main.py
```

### Run automated tests

```bash
python -m unittest -v test_assessment.py
```

### Current limitations
The current implementation uses equally weighted performance metrics and rule-based feedback. It does not yet perform video-based pose estimation, feature extraction, or predictions from a trained model.
