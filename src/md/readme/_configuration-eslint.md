## Linting with ESLint
### `eslintrc(.js/.json)`

What the script initiates:
```js
{
  "parser": "babel-eslint",
  "extends": [
    "airbnb",
    "plugin:prettier/recommended",
    "prettier/react"
  ],
  "env": {
    "browser": true,
    "commonjs": true,
    "es6": true,
    "jest": true,
    "node": true
  },
  "rules": {
    "react/state-in-constructor": ["error", "never"],
    "max-len": [
      "warn",
      {
        "code": (SET BY USER),
        "tabWidth": 2,
        "comments": (SET BY USER),
        "ignoreComments": false,
        "ignoreTrailingComments": true,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true
      }
    ]
  }
}
```
- If you're curious about the choice made for `react/state-in-constructor`, it's an opinion I conveniently borrowed from [here.](https://github.com/yannickcr/eslint-plugin-react/issues/1810#issuecomment-395235563)
- For more info, refer the [ESLint docs.](https://eslint.org/docs/user-guide/configuring)