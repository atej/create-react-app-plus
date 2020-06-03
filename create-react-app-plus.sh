#!/bin/bash

# ---------------
# Color Variables
# ---------------
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# --------------------------------------------
# ESLint version supported by create-react-app
# --------------------------------------------
ESLINT_VERSION='^6.6.0'

# -------------------------------------
# Prompts for configuration preferences
# -------------------------------------

# Package Manager Prompt
echo
echo "Which package manager are you using?"
select package_command_choices in "Yarn" "npm" "Cancel"; do
  case $package_command_choices in
    Yarn ) pkg_cmd='yarn add'; pkg_man='yarn'; break;;
    npm ) pkg_cmd='npm install'; pkg_man='npm'; break;;
    Cancel ) exit;;
  esac
done
echo

# File Format Prompt
echo "Which ESLint and Prettier configuration format do you prefer?"
select config_extension in ".js" ".json" "Cancel"; do
  case $config_extension in
    .js ) config_opening='module.exports = {'; break;;
    .json ) config_opening='{'; break;;
    Cancel ) exit;;
  esac
done
echo

# Checks for existing eslintrc files
if [ -f ".eslintrc.js" -o -f ".eslintrc.yaml" -o -f ".eslintrc.yml" -o -f ".eslintrc.json" -o -f ".eslintrc" ]; then
  echo -e "${RED}Existing ESLint config file(s) found:${NC}"
  ls -a .eslint* | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
  echo
  read -p  "Write .eslintrc${config_extension} (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping ESLint config${NC}"
    skip_eslint_setup="true"
  fi
fi
finished=false

# Max Line Length Prompt
while ! $finished; do
  read -p "What max line length do you want to set for ESLint and Prettier? (Recommendation: 80)"
  if [[ $REPLY =~ ^[0-9]{2,3}$ ]]; then
    max_len_val=$REPLY
    finished=true
    echo
  else
    echo -e "${YELLOW}Please choose a max length of two or three digits, e.g. 80 or 100 or 120${NC}"
  fi
done

# Checks for existing prettierrc files
if [ -f ".prettierrc.js" -o -f "prettier.config.js" -o -f ".prettierrc.yaml" -o -f ".prettierrc.yml" -o -f ".prettierrc.json" -o -f ".prettierrc.toml" -o -f ".prettierrc" ]; then
  echo -e "${RED}Existing Prettier config file(s) found${NC}"
  ls -a | grep "prettier*" | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} The configuration file will be resolved starting from the location of the file being formatted, and searching up the file tree until a config file is (or isn't) found. https://prettier.io/docs/en/configuration.html"
  echo
  read -p  "Write .prettierrc${config_extension} (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping Prettier config${NC}"
    skip_prettier_setup="true"
  fi
  echo
fi

# Express API Prompt
echo "Do you want to setup a mock api express server?"
select mockapi_choice in "Yes" "No" "Cancel"; do
  case $mockapi_choice in
    Yes ) skip_expressapi_setup="false"; break;;
    No ) skip_expressapi_setup="true"; break;;
    Cancel ) exit;;
  esac
done
echo

# Tailwind Prompt
echo "Do you want to setup Tailwind CSS?"
select tailwind_choice in "Yes" "No" "Cancel"; do
  case $tailwind_choice in
    Yes ) skip_tailwind_setup="false"; break;;
    No ) skip_tailwind_setup="true"; break;;
    Cancel ) exit;;
  esac
done
echo

# PropTypes Prompt
echo "Do you want to install prop-types?"
select proptypes_choice in "Yes" "No" "Cancel"; do
  case $proptypes_choice in
    Yes ) skip_proptypes_installation="false"; break;;
    No ) skip_proptypes_installation="true"; break;;
    Cancel ) exit;;
  esac
done
echo

# Faker Prompt
echo "Do you want to install faker?"
select faker_choice in "Yes" "No" "Cancel"; do
  case $faker_choice in
    Yes ) skip_faker_installation="false"; break;;
    No ) skip_faker_installation="true"; break;;
    Cancel ) exit;;
  esac
done
echo

# Axios Prompt
echo "Do you want to install axios?"
select axios_choice in "Yes" "No" "Cancel"; do
  case $axios_choice in
    Yes ) skip_axios_installation="false"; break;;
    No ) skip_axios_installation="true"; break;;
    Cancel ) exit;;
  esac
done
echo

# ---------------------
# Perform Configuration
# ---------------------

echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

# Configure ESLint and VS Code integration
echo
echo -e "${LCYAN}Installing eslint & prettier... ${NC}"
echo
$pkg_cmd -D eslint@$ESLINT_VERSION prettier

echo
echo -e "${YELLOW}Conforming to Airbnb's JavaScript Style Guide... ${NC}"
echo
$pkg_cmd -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

echo
echo -e "${YELLOW}Making ESlint and Prettier play nice with each other... ${NC}"
echo "See https://github.com/prettier/eslint-config-prettier for more details."
echo
$pkg_cmd -D eslint-config-prettier eslint-plugin-prettier


if [ "$skip_eslint_setup" == "true" ]
then
  echo
  echo -e "${LCYAN}Skipping eslint setup... ${NC}"
  echo
else
  echo
  echo -e "${YELLOW}Building your .eslintrc${config_extension} file...${NC}"
  > ".eslintrc${config_extension}" # truncates existing file (or creates empty)

  proptypes_rule=''
  if [ "$skip_proptypes_installation" == "true" ]
  then
    proptypes_rule='"react/prop-types": 0,'
  fi

  echo ${config_opening}'
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
    '$proptypes_rule'
    "max-len": [
      "warn",
      {
        "code": '${max_len_val}',
        "tabWidth": 2,
        "comments": '${max_len_val}',
        "ignoreComments": false,
        "ignoreTrailingComments": true,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true
      }
    ]
  }
}' >> .eslintrc${config_extension}

  mkdir .vscode

  echo -e "${YELLOW}Building your settings.json file...${NC}"
  > ".vscode/settings.json" # truncates existing file (or creates empty)
  echo '{
  "eslint.packageManager": "'${pkg_man}'",
  "eslint.format.enable": true,
  "editor.defaultFormatter": "dbaeumer.vscode-eslint",
  "editor.formatOnPaste": true,
  "editor.formatOnSave": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  }
}' >> .vscode/settings.json
fi

# Configure prettier
if [ "$skip_prettier_setup" == "true" ]
then
  echo
  echo -e "${LCYAN}Skipping prettier setup... ${NC}"
  echo
else
  echo -e "${YELLOW}Building your .prettierrc${config_extension} file... ${NC}"
  > .prettierrc${config_extension} # truncates existing file (or creates empty)

  echo ${config_opening}'
  "printWidth": '${max_len_val}',
  "singleQuote": true
}' >> .prettierrc${config_extension}
fi

# Adding eslint rule to index.js
sed -i.bak '1i\
/* eslint-disable react/jsx-filename-extension */
' src/index.js
rm src/index.js.bak

if [ "$skip_expressapi_setup" == "true" ]; then
  echo
  echo -e "${LCYAN}Skipping express mock api setup... ${NC}"
  echo
else
  echo
  echo -e "${LCYAN}Setting up a mock api express server... ${NC}"
  echo

  echo -e "Mock API 1/3 ${YELLOW}Installing dependencies... ${NC}"
  $pkg_cmd -D express connect-api-mocker npm-run-all

  echo -e "Mock API 2/3 ${YELLOW}Configuring build scripts... ${NC}"
  # Add proxy config
  sed -i.bak '2a\
\ \ "proxy": "http://localhost:9000/api",
' package.json
  # Add `start:react` script
  sed -i.bak '/"scripts"/a\
\ \ \ \ "start:react": "react-scripts start",
' package.json
  # Add script `mock-api` to serve the mock api
    sed -i.bak '/"eject": "react-scripts eject"/i\
\ \ \ \ "mock-api": "node ./mock-api/app.js",
' package.json
  # Replace original `start` script
  sed -i.bak 's/"start": "react-scripts start"/"start": "run-p start:react mock-api"/' package.json
  # Remove package.json.bak file
  rm package.json.bak

  # Create the mock-api directory
  mkdir mock-api

  echo -e "Mock API 3/3 ${YELLOW}Building the entry-point of your mock API Express server...${NC}"
  > "mock-api/app.js" # truncates existing file (or creates empty)
  echo "/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const express = require('express');
const apiMocker = require('connect-api-mocker');

const port = 9000;
const app = express();

app.use('/api', apiMocker('mock-api'));

console.log(\`Mock API Server is up and running at: http://localhost:\${port}\`);
app.listen(port);" >> mock-api/app.js
fi

if [ "$skip_tailwind_setup" == "true" ]; then
  echo
  echo -e "${LCYAN}Skipping tailwind setup... ${NC}"
  echo
else
  echo
  echo -e "${LCYAN}Setting up tailwind css... ${NC}"
  echo

  echo -e "Tailwind 1/8 ${YELLOW}Installing dependencies... ${NC}"
  $pkg_cmd tailwindcss postcss-cli postcss-import postcss-preset-env
  $pkg_cmd -D @fullhuman/postcss-purgecss npm-run-all

  echo -e "Tailwind 2/8 ${YELLOW}Setting up build scripts... ${NC}"
  # Add `prebuild`, `build:tailwind`, `watch:tailwind` scripts
  sed -i.bak '/"eject": "react-scripts eject"/i\
\ \ \ \ "build:tailwind": "REACT_APP_ENV=production postcss src/tailwind.css -o src/tailwind.generated.css",\
\ \ \ \ "watch:tailwind": "REACT_APP_ENV=development postcss -w src/tailwind.css -o src/tailwind.generated.css",\
\ \ \ \ "prebuild": "npm run build:tailwind",
' package.json
  # Modify the `start` script
  if [ "$skip_expressapi_setup" == "false" ]
  then
    # Replace previous mock-api `start` script
    sed -i.bak 's/"start": "run-p start:react mock-api"/"start": "run-p watch:tailwind start:react mock-api"/' package.json
  else
    # Add `start:react` script
    sed -i.bak '/"scripts"/a\
\ \ \ \ "start:react": "react-scripts start",
' package.json
    # Replace original `start` script
    sed -i.bak 's/"start": "react-scripts start"/"start": "run-p watch:tailwind start:react"/' package.json
  fi
  rm package.json.bak

  echo -e "Tailwind 3/8 ${YELLOW}Creating the postcss config file...${NC}"
  > "postcss.config.js" # truncates existing file (or creates empty)
  echo "/* eslint-disable global-require */
/* eslint-disable import/no-extraneous-dependencies */
const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    './public/**/*.html',
    './src/**/*.html',
    './src/**/*.js',
    './src/**/*.jsx',
  ],

  defaultExtractor: (content) => {
    const broadMatches = content.match(/[^<>\"'\`\\s]*[^<>\"'\`\\s:]/g) || [];
    const innerMatches = content.match(/[^<>\"'\`\\s.()]*[^<>\"'\`\\s.():]/g) || [];

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
};" >> postcss.config.js

  echo -e "Tailwind 4/8 ${YELLOW}Initializing an empty tailwind config file ...${NC}"
  > "tailwind.config.js" # truncates existing file (or creates empty)
  echo "module.exports = {
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};" >> tailwind.config.js

  echo -e "Tailwind 5/8 ${YELLOW}Creating the tailwind source css file...${NC}"
  > "src/tailwind.css" # truncates existing file (or creates empty)
  echo '/* purgecss start ignore */
@import "tailwindcss/base";
@import "./custom-base-styles.css";

@import "tailwindcss/components";
@import "./custom-components.css";
/* purgecss end ignore */

@import "tailwindcss/utilities";

/* purgecss start ignore */
@import "./custom-utilities.css";
/* purgecss end ignore */' >> src/tailwind.css

  echo -e "Tailwind 6/8 ${YELLOW}Creating custom css files...${NC}"
  touch src/custom-base-styles.css src/custom-components.css src/custom-utilities.css

  echo -e "Tailwind 7/8 ${YELLOW}Adding the tailwind generated css file to gitignore...${NC}"
  sed -i.bak '$a\
\
# tailwind generated css\
src/tailwind.generated.css
' .gitignore
  rm .gitignore.bak

  echo -e "Tailwind 8/8 ${YELLOW}Importing tailwind css in index.js...${NC}"
  sed -i.bak "/import App/a\\
import './tailwind.generated.css';
" src/index.js
  rm src/index.js.bak
fi

if [ "$skip_proptypes_installation" == "true" ]; then
  echo
  echo -e "${LCYAN}Skipping prop-types installation... ${NC}"
  echo
else
  echo
  echo -e "${LCYAN}Installing prop-types... ${NC}"
  echo
  $pkg_cmd prop-types
fi

if [ "$skip_faker_installation" == "true" ]; then
  echo
  echo -e "${LCYAN}Skipping faker installation... ${NC}"
  echo
else
  echo
  echo -e "${LCYAN}Installing faker... ${NC}"
  echo
  $pkg_cmd faker
fi

if [ "$skip_axios_installation" == "true" ]; then
  echo
  echo -e "${LCYAN}Skipping axios installation... ${NC}"
  echo
else
  echo
  echo -e "${LCYAN}Installing axios... ${NC}"
  echo
  $pkg_cmd axios
fi

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo -e "Start things up with ${LCYAN}${pkg_man} run start${NC}"
echo
