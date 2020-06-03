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