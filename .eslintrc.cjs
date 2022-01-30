module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: "eslint:all",
  parserOptions: {
    sourceType: "module"
  },
  rules: {
    "array-element-newline": ["error", "consistent"],
    "capitalized-comments": "off",
    "function-call-argument-newline": ["error", "consistent"],
    "indent": ["error", 2],
    "no-magic-numbers": "off",
    "no-warning-comments": "off",
    "object-curly-spacing": ["error", "always"],
    "one-var": "off",
    "padded-blocks": ["error", { blocks: "never" }],
    "quote-props": ["error", "consistent-as-needed"],
    "semi": ["error", "never"]
  }
}
