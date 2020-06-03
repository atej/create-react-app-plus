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