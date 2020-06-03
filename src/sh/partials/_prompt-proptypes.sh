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