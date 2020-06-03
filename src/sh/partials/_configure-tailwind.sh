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