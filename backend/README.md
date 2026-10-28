# SportsAI Backend API

## Overview

SportsAI Backend provides REST API endpoints for athlete registration, sports assessments, performance records, and health checks. It uses Node.js, Express.js, and MongoDB through Mongoose.

## Requirements

- Node.js and npm
- MongoDB instance
- Git

## Installation

From the repository root, navigate to the backend directory:

```bash
cd backend
npm install
```

Create a `.env` file in the `backend` directory with your MongoDB connection string:

```env
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/sportsai
```

Use your team's configured database URI if it differs from this example. Do not commit credentials or secrets.

## Run the server

Development mode:

```bash
npm run dev
```

Production-style start:

```bash
npm start
```

The API normally runs at `http://localhost:5000`.

## API endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Welcome message |
| GET | `/api/health` | Health check |
| POST | `/api/athletes/register` | Register an athlete |
| GET | `/api/athletes` | Retrieve athletes |
| POST | `/api/assessments` | Create an assessment |
| GET | `/api/assessments` | Retrieve assessments |
| POST | `/api/performance` | Save performance metrics |
| GET | `/api/performance` | Retrieve performance records |

## Example requests

### Register an athlete

`POST /api/athletes/register`

```json
{
  "name": "Sample Athlete",
  "email": "athlete@example.com",
  "sport": "Football",
  "location": "Jaipur",
  "age": 20
}
```

The `name`, `email`, and `sport` fields are required.

### Create an assessment

`POST /api/assessments`

```json
{
  "athleteId": "REPLACE_WITH_VALID_MONGODB_OBJECT_ID",
  "sport": "Football",
  "videoUrl": "https://example.com/video.mp4"
}
```

Replace the placeholder with the ID of an existing athlete.

### Save performance

`POST /api/performance`

```json
{
  "assessmentId": "REPLACE_WITH_VALID_ASSESSMENT_OBJECT_ID",
  "speed": 85,
  "agility": 80,
  "accuracy": 90,
  "consistency": 88,
  "aiFeedback": "Good overall performance."
}
```

Replace the assessment ID with an existing assessment ID. Each performance metric must be a number between 0 and 100. The overall score is calculated by the backend as the arithmetic mean of the four metrics.

## Response format

Successful responses generally include `success: true` and the returned resource or data.

Example error response:

```json
{
  "success": false,
  "message": "Invalid request data"
}
```

Typical status codes:

- `200` — Successful retrieval
- `201` — Resource created
- `400` — Invalid request or missing required fields
- `404` — Route or requested resource not found
- `409` — Duplicate record
- `500` — Internal server error

## Testing

Run the automated API tests from the backend directory:

```bash
npm test
```

The tests use Node.js's built-in test runner and an ephemeral HTTP server. Tests that require a real MongoDB database should be configured separately.

## Error handling

The application includes centralized error-handling middleware for errors forwarded through Express, including malformed JSON requests, and a 404 handler for unknown routes. Controllers also handle expected validation and database errors.

## Notes

- Athlete registration requires a unique email.
- Assessments require an existing athlete.
- Performance records require an existing assessment.
- Keep `.env` and other credentials out of version control.
