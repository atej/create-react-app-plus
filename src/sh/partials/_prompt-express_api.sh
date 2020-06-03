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