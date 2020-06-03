# Tailwind Prompt
echo "Do you want to setup Tailwind CSS?"
select tailwind_choice in "Yes" "No" "Cancel"; do
  case $tailwind_choice in
    Yes ) skip_tailwind_setup="false"; break;;
    No ) skip_tailwind_setup="true"; break;;
    Cancel ) exit;;
  esac
done
echo