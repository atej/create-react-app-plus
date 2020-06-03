# Packages
## ESLint & Prettier
### Main packages
- [eslint](https://eslint.org/) - Find and fix problems in your JavaScript code.
- [prettier](https://prettier.io/) - Prettier is an opinionated code formatter.

> Note: The latest version of eslint supported by `create-react-app` is installed (currently, `^6.6.0`)

### Airbnb configuration
- [eslint-config-airbnb](https://www.npmjs.com/package/eslint-config-airbnb) - This package provides Airbnb's .eslintrc as an extensible shared config.
- [eslint-plugin-jsx-a11y](https://github.com/evcohen/eslint-plugin-jsx-a11y) (Peer Dependency) - Static AST checker for accessibility rules on JSX elements.
- [eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react) (Peer Dependency) - React specific linting rules for ESLint
- [eslint-plugin-import](https://www.npmjs.com/package/eslint-plugin-import) (Peer Dependency) - Support linting of ES2015+ (ES6+) import/export syntax, and prevent issues with misspelling of file paths and import names.
- [babel-eslint](https://github.com/babel/babel-eslint) - A wrapper for Babel's parser used for ESLint. Included to support experimental but popular JS features like [class fields](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Public_class_fields). Also, [Airbnb Style Guide uses Babel](https://github.com/airbnb/javascript#airbnb-javascript-style-guide-).

### ESLint, Prettier Integration
- [eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier) - Runs Prettier as an ESLint rule and reports differences as individual ESLint issues.
- [eslint-config-prettier](https://github.com/prettier/eslint-config-prettier) - Turns off all rules that are unnecessary or might conflict with Prettier.
   
### ESLint extension for VS Code (necessary for auto-fix errors on save)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) - This extension integrates ESLint into VS Code. It must be installed and enabled manually. The script does not handle the installation.

## React stuff
### Type checking
- [prop-types](https://github.com/facebook/prop-types) - Runtime type checking for React props and similar objects

### React extensions for VS Code (recommended)
- [ES7 React/Redux/GraphQL/React-Native snippets](https://marketplace.visualstudio.com/items?itemName=dsznajder.es7-react-js-snippets) - This extension provides you JavaScript and React/Redux snippets in ES7 with Babel plugin features. It should be installed and enabled manually. The script does not handle the installation.

## Mocks
### Fake data
- [faker](https://github.com/Marak/Faker.js) - Generate massive amounts of realistic fake data in Node.js and the browser
### Mock API server
- [express](https://github.com/expressjs/express) - Fast, unopinionated, minimalist web framework for node. 
- [connect-api-mocker](https://github.com/muratcorlu/connect-api-mocker) - Connect middleware that creates mocks for REST APIs

## Data fetching
- [axios](https://github.com/axios/axios) - Promise based HTTP client for the browser and node.js

## Tailwind CSS
Tailwind CSS is a PostCSS plugin. The following packages are needed to make it work optimally.
### PostCSS
#### CLI
- [postcss-cli](https://github.com/postcss/postcss-cli) - CLI for postcss
#### PostCSS plugins
- [tailwindcss](https://github.com/tailwindcss/tailwindcss) - A utility-first CSS framework for rapid UI development.
- [postcss-preset-env](https://github.com/csstools/postcss-preset-env) - Convert modern CSS into something browsers understand (includes CSS variables, nesting, and autoprefixer out-of-the-box).
- [postcss-import](https://github.com/postcss/postcss-import) - PostCSS plugin to inline @import rules content
- [@fullhuman/postcss-purgecss](https://github.com/FullHuman/purgecss) - Remove unused CSS

### Tailwind CSS extensions for VS Code (recommended)
- [Tailwind CSS Intellisense](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss) - this extension adds Tailwind CSS class name completion for VS Code. It should be installed and enabled manually. The script does not handle the installation.

- [Headwind](https://marketplace.visualstudio.com/items?itemName=heybourn.headwind) - this extension is an opinionated Tailwind CSS class sorter for Visual Studio Code. It enforces consistent ordering of classes by parsing your code and reprinting class tags to follow a given order. It must be installed and enabled manually. The script does not handle the installation.


## NPM stuff
### Script runners
- [npm-run-all](https://github.com/mysticatea/npm-run-all) - A CLI tool to run multiple npm-scripts in parallel or sequential.