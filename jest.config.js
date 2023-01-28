const config = {
  testEnvironment: 'node',
  collectCoverage: true,
  collectCoverageFrom: ['source/**/*.js', 'source/*.js'],
  coverageThreshold: {
    global: {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
  clearMocks: true,
  resetMocks: true,
  resetModules: true,
};
module.exports = config;
