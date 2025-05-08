#!/bin/bash
# check if we're running on a mac
if [[ "$OSTYPE" =~ "darwin" ]]; then
    echo "Running on a Mac"
    # set profile directory
    profile_dir=~/Library/Application\ Support/Firefox/Profiles/
    # find individual profiles and loop through them
    find "${profile_dir}" -maxdepth 1 -mindepth 1 -type d| while read found_profile; do \
      echo "copying user.js to ${found_profile}"; \
      # this WILL indiscriminately overwrite any existing user.js so we will take a backup.
      cp -R "${found_profile}"/user.js{,.$(date +%s).bak}; \
      # copy the user.js file to the profile directory
      cp -R ./user.js "${found_profile}"; \
      echo "done"; \
    done
else
    echo "Not running on a Mac"
fi


