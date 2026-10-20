const { validatePerformance } = require('../validators/performanceValidator');

describe('validatePerformance', () => {
  const validPerformance = {
    assessmentId: 'assessment123',
    speed: 80,
    agility: 75,
    accuracy: 90,
    consistency: 85,
  };

  test('accepts valid performance scores', () => {
    expect(validatePerformance(validPerformance).valid).toBe(true);
  });

  test('rejects missing required fields', () => {
    const data = { ...validPerformance };
    delete data.speed;

    const result = validatePerformance(data);

    expect(result.valid).toBe(false);
    expect(result.errors.length).toBeGreaterThan(0);
  });

  test('rejects scores greater than 100', () => {
    const data = { ...validPerformance, speed: 110 };

    expect(validatePerformance(data).valid).toBe(false);
  });

  test('rejects negative scores', () => {
    const data = { ...validPerformance, agility: -5 };

    expect(validatePerformance(data).valid).toBe(false);
  });

  test('rejects scores that are not numbers', () => {
    const data = { ...validPerformance, accuracy: '90' };

    expect(validatePerformance(data).valid).toBe(false);
  });
});