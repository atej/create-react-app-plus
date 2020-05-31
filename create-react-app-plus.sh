#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# --------------------------------------
# Prompts for configuration preferences
# --------------------------------------

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

# Mock API Prompt
echo "Do you want to setup a mock api?"
select mockapi_choice in "Yes" "No" "Cancel"; do
  case $mockapi_choice in
    Yes ) skip_mockapi_installation="false"; break;;
    No ) skip_mockapi_installation="true"; break;;
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

# ----------------------
# Perform Configuration
# ----------------------
echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

echo
echo -e "1/11 ${LCYAN}ESLint & Prettier Installation... ${NC}"
echo
$pkg_cmd -D eslint@^6.6.0 prettier

echo
echo -e "2/11 ${YELLOW}Conforming to Airbnb's JavaScript Style Guide... ${NC}"
echo
$pkg_cmd -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

if [ "$skip_proptypes_installation" == "true" ]; then
  break
else
  echo
  echo -e "3/11 ${LCYAN}PropTypes installation... ${NC}"
  echo
  $pkg_cmd prop-types
fi

if [ "$skip_faker_installation" == "true" ]; then
  break
else
  echo
  echo -e "4/11 ${LCYAN}Faker installation... ${NC}"
  echo
  $pkg_cmd faker
fi

if [ "$skip_mockapi_installation" == "true" ]; then
  break
else
  echo
  echo -e "5/11 ${LCYAN}Setting up a mock api... ${NC}"
  echo

  # Install dev dependencies for mock api
  $pkg_cmd -D express connect-api-mocker npm-run-all

  # Add proxy config to package.json
  sed -i.bak '2a\
\ \ "proxy": "http://localhost:9000/api",
' package.json

  # Add script to serve the mock api and serve it in parallel with the react app 
  sed -i.bak '/"eject": "react-scripts eject"/i\
\ \ \ \ "mock-api": "node ./mock-api/app.js",\
\ \ \ \ "dev": "run-p start mock-api",
' package.json

  rm package.json.bak

  # Create the mock-api directory
  mkdir mock-api

  # Create the entry point for express server
  echo -e "6/11 ${YELLOW}Building the entry-point of your mock API Express server...${NC}"
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

if [ "$skip_axios_installation" == "true" ]; then
  break
else
  echo
  echo -e "7/11 ${LCYAN}Axios installation... ${NC}"
  echo
  $pkg_cmd axios
fi

echo
echo -e "8/11 ${LCYAN}Making ESlint and Prettier play nice with each other... ${NC}"
echo "See https://github.com/prettier/eslint-config-prettier for more details."
echo
$pkg_cmd -D eslint-config-prettier eslint-plugin-prettier


if [ "$skip_eslint_setup" == "true" ]; then
  break
else
  echo
  echo -e "9/11 ${YELLOW}Building your .eslintrc${config_extension} file...${NC}"
  > ".eslintrc${config_extension}" # truncates existing file (or creates empty)
  if [ "$skip_proptypes_installation" == "true" ]; then
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
    "react/prop-types": 0,
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
  else
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
  fi

  mkdir .vscode

  echo -e "10/11 ${YELLOW}Building your settings.json file...${NC}"
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


if [ "$skip_prettier_setup" == "true" ]; then
  break
else
  echo -e "11/11 ${YELLOW}Building your .prettierrc${config_extension} file... ${NC}"
  > .prettierrc${config_extension} # truncates existing file (or creates empty)

  echo ${config_opening}'
  "printWidth": '${max_len_val}',
  "singleQuote": true
}' >> .prettierrc${config_extension}
fi

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo

if [ "$skip_mockapi_installation" == "false" ]; then
  echo
  echo -e "Start your react app and mock API server with ${LCYAN}${pkg_man} run dev${NC}"
  echo
fi