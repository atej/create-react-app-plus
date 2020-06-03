#!/bin/bash

# ---------------
# Color Variables
# ---------------
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

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

# ---------------------
# Perform Configuration
# ---------------------

echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

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

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo -e "Start things up with ${LCYAN}${pkg_man} run start${NC}"
echo
