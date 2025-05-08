#!/bin/bash
if [[ "$OSTYPE" =~ "darwin" ]]; then
    echo "Running on a Mac"
    profile_dir=~/Library/Application\ Support/Firefox/Profiles/
    find "${profile_dir}" -maxdepth 1 -mindepth 1 -type d| while read found_profile; do \
      #found_profile=$(basename "${found_profile}"); \
      echo "copying user.js to ${found_profile}"; \
      # this WILL indiscriminately overwrite any existing user.js so we will take a backup.
      cp -R "${found_profile}"/user.js{,.$(date +%s).bak}; \
      cp -R ./user.js "${found_profile}"; \
      echo "done"; \
    done
#    open -a Firefox
else
    echo "Not running on a Mac"
fi


