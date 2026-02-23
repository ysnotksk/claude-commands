---
paths:
  - "**/*.js"
  - "**/*.jsx"
  - "**/*.ts"
  - "**/*.tsx"
---
# JavaScript / TypeScript Rules

- **Type Safety**: TypeScript preferred. Explicit types for params/returns. Strict mode ON.
- **Style**: ESLint/Prettier compliance. Standard guide (Airbnb/Google).
- **Modern**: ES6+ (arrow functions, destructuring). `const` by default. Template literals.
- **Modules**: ES6 `import/export`. Organized imports (External → Internal).
- **Error**: Explicit try-catch or `.catch()`. Meaningful messages. Custom types if needed.
- **Lib**: Prefer built-in APIs. Minimize npm packages.
