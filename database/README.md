# SportsAI Database

Database: MongoDB

## Collections

### athletes

Stores athlete profile information.

Main fields:

- name
- email
- sport
- location
- age

### assessments

Stores athlete assessment information.

Main fields:

- athleteId
- sport
- videoUrl
- status
- performanceScore
- feedback

## Week 2 Database Development

During Week 2, the database module was extended to support athlete
performance assessment and future AI/ML integration.

### Added in Week 2

- Performance database model
- Performance metric validation
- Sample assessment and performance data
- Overall performance score field
- AI feedback field preparation

### Performance Metrics

Each performance record can contain:

- Speed
- Agility
- Accuracy
- Consistency
- Overall performance score
- AI feedback

### Database Structure

```text
Athlete
   ↓
Assessment
   ↓
Performance
   ↓
Overall Performance Score
   ↓
AI Feedback
## Week 4: Performance Validation Testing

- Added Jest as a development dependency.
- Added automated tests for the performance validator.
- Tests cover valid scores, missing required fields, scores above 100, negative scores, and non-numeric scores.
- Run the tests from the `database` directory using `npm test`.

These tests validate the performance validation logic without requiring a live MongoDB connection.