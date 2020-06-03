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