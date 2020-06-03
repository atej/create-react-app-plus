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