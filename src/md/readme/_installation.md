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