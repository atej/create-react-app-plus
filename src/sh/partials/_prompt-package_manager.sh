# Package Manager Prompt
echo
echo "Which package manager are you using?"
select package_command_choices in "Yarn" "npm" "Cancel"; do
  case $package_command_choices in
    Yarn ) pkg_cmd='yarn add'; pkg_man='yarn'; break;;
    npm ) pkg_cmd='npm install'; pkg_man='npm'; break;;
    Cancel ) exit;;
  esac
done
echo