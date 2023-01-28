module.exports = {
  env: {
    jest: true,
    commonjs: true,
    es6: true,
  },
  plugins: ['jest'],
  extends: ['eslint:recommended', 'prettier', 'plugin:jest/recommended'],
  overrides: [
    {
      files: ['*.test.js'],
    },
  ],
};
