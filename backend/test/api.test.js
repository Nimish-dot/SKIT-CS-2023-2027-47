const test = require('node:test');
const assert = require('node:assert/strict');
const app = require('../src/app');

let server;
let baseUrl;

test.before(async () => {
  server = app.listen(0);
  await new Promise((resolve) => server.once('listening', resolve));
  baseUrl = 'http://127.0.0.1:' + server.address().port;
});

test.after(async () => {
  if (server) {
    await new Promise((resolve, reject) => {
      server.close((error) => (error ? reject(error) : resolve()));
    });
  }
});

test('GET / returns the welcome message', async () => {
  const response = await fetch(baseUrl + '/');
  const body = await response.json();

  assert.equal(response.status, 200);
  assert.equal(body.message, 'Welcome to SportsAI Backend API');
});

test('GET /api/health returns a successful health check', async () => {
  const response = await fetch(baseUrl + '/api/health');
  const body = await response.json();

  assert.equal(response.status, 200);
  assert.equal(body.success, true);
  assert.equal(body.message, 'SportsAI backend is running');
});

test('POST /api/athletes/register rejects missing required fields', async () => {
  const response = await fetch(baseUrl + '/api/athletes/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name: 'Test Athlete' }),
  });
  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
});

test('POST /api/assessments rejects missing required fields', async () => {
  const response = await fetch(baseUrl + '/api/assessments', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({}),
  });
  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
});

test('POST /api/performance rejects missing required fields', async () => {
  const response = await fetch(baseUrl + '/api/performance', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({}),
  });
  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
});
test('Invalid JSON returns a consistent 400 response', async () => {
  const response = await fetch(baseUrl + '/api/athletes/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: '{"name":',
  });

  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
  assert.equal(body.message, 'Invalid JSON request body');
});

test('Unknown route returns a 404 response', async () => {
  const response = await fetch(baseUrl + '/api/unknown-route');
  const body = await response.json();

  assert.equal(response.status, 404);
  assert.equal(body.success, false);
});


test('POST /api/assessments rejects an invalid athlete ID', async () => {
  const response = await fetch(baseUrl + '/api/assessments', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      athleteId: 'invalid-id',
      sport: 'Football',
    }),
  });

  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
  assert.equal(body.message, 'Invalid athlete ID');
});

test('POST /api/performance rejects an invalid assessment ID', async () => {
  const response = await fetch(baseUrl + '/api/performance', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      assessmentId: 'invalid-id',
      speed: 80,
      agility: 80,
      accuracy: 80,
      consistency: 80,
    }),
  });

  const body = await response.json();

  assert.equal(response.status, 400);
  assert.equal(body.success, false);
  assert.equal(body.message, 'Invalid assessment ID');
});
