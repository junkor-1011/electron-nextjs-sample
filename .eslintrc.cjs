// @ts-check
const { builtinModules } = require('node:module');
const { defineConfig } = require('eslint-define-config');

module.exports = defineConfig({
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'plugin:react/recommended',
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:@typescript-eslint/recommended-requiring-type-checking',
    'next',
    'plugin:@next/next/recommended',
    'next/core-web-vitals',
    // 'plugin:storybook/recommended',
    'standard-with-typescript',
    'prettier',
  ],
  overrides: [
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    project: [
      'electron-src/tsconfig.json',
      'renderer/tsconfig.json',
    ],
  },
  plugins: [
    'react'
  ],
  rules: {
  }
}
)
