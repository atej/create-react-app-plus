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