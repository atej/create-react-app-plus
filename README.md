# Features
#### 🎨 Automatic linting and formatting with ESlint and Prettier in VS Code 
#### 🚦PropTypes for run-time type checking [optional]
#### 🎭️ Faker.js for fake data [optional]
#### 🌐 A local mock API server [optional]
#### 🐕️ Axios to make HTTP requests [optional]
#### 🌊 Tailwind for utility-first CSS [optional]

# Installation
1. Create a new react app
    ```bash
    npx create-react-app my-app
    ```

2. Navigate to your app directory where you want to include this style configuration.
    ```bash
    cd my-app
    ```

3. Run this command inside your app's root directory. Note: this command executes the `create-react-app-plus.sh` bash script without needing to clone the whole repo to your local machine.

    ```bash
    exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/atej/create-react-app-plus/master/create-react-app-plus.sh 2> /dev/null)
    ```

4. Follow the prompts and make selections for your preference of package manager (npm or yarn), file format (.js or .json), max-line size, an `express` server to mock an API, Tailwind CSS setup, `prop-types` installation, `faker` installation, and `axios` installation.

5. Look in your project's root directory and notice the newly added/updated config files/folders:
    - `.eslintrc.js` (or `.eslintrc.json`) - eslint config file
    - `.prettierrc.js` (or `.prettierrc.json`) - prettier config file
    -  `.vscode/settings.json` - editor settings for the current workspace
    - The following will be seen if the option to setup a mock API express server was selected
      - `mock-api/app.js` - The entry point for your mock API server
    - The following will be seen if the option to setup tailwind css was selected
      - `tailwind.config.js` - An empty tailwind config 
      - `postcss.config.js` - PostCSS config
      - `src/tailwind.css` - The entry point for PostCSS
      - `src/custom-base-styles.css`, `src/custom-components.css`, `src/custom-utilities.css` - files for your custom css
6. Start the react app server
    ```bash
    npm run start
    ```

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

# Created Configuration Files

Configuration files are created when you first run the script. You may subsequently edit them to your liking.

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

## Formatting with Prettier
### `prettierrc(.js/.json)`
What the script initiates:
```js
{
  "printWidth": (SET BY USER),
  "singleQuote": true
}
```
Two other options that I was used to specifying earlier, but have since Prettier v2, become defaults. 
```js
"arrowParens" : "always",
"trailingComma" : "es5"
```
- To know what each option does and for more options, refer the [Prettier docs](https://prettier.io/docs/en/options.html)

## Auto-fix in Visual Studio Code
### `.vscode/settings.json`
- eslint extension settings
- emmet support in jsx
```json
{
  "eslint.packageManager": (SET BY USER),
  "eslint.format.enable": true,
  "editor.defaultFormatter": "dbaeumer.vscode-eslint",
  "editor.formatOnPaste": true,
  "editor.formatOnSave": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  }
}
```
- **IMPORTANT**: This [ESLint extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) mast be installed and enabled in your workspace. 
- **Disable** the VS Code **Prettier** plugin in your workspace, if you have it enabled. Code will be both auto-formatted and auto-linted on save by the ESLint extension.

## Mocking a REST API with Express & Connect API Mocker
### `mock-api/app.js`
```js
const express = require('express');
const apiMocker = require('connect-api-mocker');

const port = 9000;
const app = express();

app.use('/api', apiMocker('mock-api'));

console.log(`Mock API Server is up and running at: http://localhost:${port}`);
app.listen(port);
```
- Refer [this post](https://blog.harveydelaney.com/setting-up-a-mock-api-for-your-front-end-react-project/) for a detailed breakdown of the what and how of this set up
- For more information, refer `connect-api-mocker` [docs](https://github.com/muratcorlu/connect-api-mocker)

## Functional CSS with Tailwind
### `postcss.config.js`
```js
const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    './public/**/*.html',
    './src/**/*.html',
    './src/**/*.js',
    './src/**/*.jsx',
  ],

  defaultExtractor: (content) => {
    const broadMatches = content.match(/[^<>"'`\s]*[^<>"'`\s:]/g) || [];
    const innerMatches = content.match(/[^<>"'`\s.()]*[^<>"'`\s.():]/g) || [];

    return broadMatches.concat(innerMatches);
  },
});

module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),
    require('postcss-preset-env')({ stage: 1 }),
    ...(process.env.REACT_APP_ENV === 'production' ? [purgecss] : []),
  ],
};
```
### `tailwind.config.js`
```js
module.exports = {
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};
```

### `src/tailwind.css`
```css
/* purgecss start ignore */
@import "tailwindcss/base";
@import "./custom-base-styles.css";

@import "tailwindcss/components";
@import "./custom-components.css";
/* purgecss end ignore */

@import "tailwindcss/utilities";

/* purgecss start ignore */
@import "./custom-utilities.css";
/* purgecss end ignore */
```

### Files for your custom CSS: `src/custom-base-styles.css`, `src/custom-components.css`, `src/custom-utilities.css`

> Note: A file named `tailwind.generated.css` will be auto-generated in the `src` directory when you `start` or `build` the app. This is the main tailwind CSS file which is imported in `index.js`. Do not manipulate this file directly. Also since, it is auto-generated from your source CSS, it should not be committed to source control (a corresponding entry in `.gitignore` is made by the script).

- Refer [this post](https://daveceddia.com/tailwind-create-react-app/), for a detailed breakdown of the what and how of this setup.
- From the Tailwind docs - [using with preprocessors](https://tailwindcss.com/docs/using-with-preprocessors) and [controlling file size](https://tailwindcss.com/docs/controlling-file-size) are valuable to further understand what's going on.
- To learn more about tailwind concepts, refer the [docs.](https://tailwindcss.com/docs/utility-first)
- These extensions make working with Tailwind in VS Code even better - [Tailwind CSS Intellisense](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss), [Headwind](https://marketplace.visualstudio.com/items?itemName=heybourn.headwind)

---

## Origin Story
This script started out as a fork of another script I stumbled upon -  [eslint-prettier-airbnb-react](https://github.com/paulolramos/eslint-prettier-airbnb-react), while learning React with a desire for an enhanced DX - automatic fixing of lint errors, formatting with prettier - the works.

So I began to tinker with the aforementioned script, to make it play well with `create-react-app` in Visual Studio Code (the editor I've settled on).

As the amount of stuff the script did eventually grew, and its coupling with `create-react-app` and Visual Studio Code became tighter, it felt like this should be its own thing.

## Prior Art
Without these shoulders to stand on, this project would not have seen the light of day.

[1]: Paulo Ramos's [eslint-prettier-airbnb-react](https://github.com/paulolramos/eslint-prettier-airbnb-react) script

[2]: Jeffrey Zhen's [tutorial](https://blog.echobind.com/integrating-prettier-eslint-airbnb-style-guide-in-vscode-47f07b5d7d6a) which inspired [1]

[3]: Harvey Delaney's [post](https://blog.harveydelaney.com/setting-up-a-mock-api-for-your-front-end-react-project/) and companion [repo](https://github.com/HarveyD/mock-api-react) on setting up a local mock API

[4]: Dave Ceddia's [post](https://daveceddia.com/tailwind-create-react-app/) on using Tailwind CSS with `create-react-app`
