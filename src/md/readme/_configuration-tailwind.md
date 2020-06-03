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