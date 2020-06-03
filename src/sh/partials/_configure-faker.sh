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