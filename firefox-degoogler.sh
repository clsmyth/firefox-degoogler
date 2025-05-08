#!/usr/bin/env bash

# check if we're running on a mac
if [[ "$OSTYPE" =~ "darwin" ]]; then
    echo "Running on a Mac"
else
    echo "Not running on a Mac"
    exit 0
fi

# check if we have the model profile to use
model_js="./model_user.js"
if [ -f "${model_js}" ]; then
    echo "Model profile '${model_js}' found"
else
    echo "Model profile '${model_js}' not found"
    exit 1
fi

# check for profile directory
profile_dir=~/"Library/Application Support/Firefox/Profiles"

if [ -d "${profile_dir}" ]; then
    echo "Profile dir '${profile_dir}' found"
else
    echo "Profile dir '${profile_dir}' not found"
    exit 1
fi

# timestamp
ts="$(date +%s)"

# loop thru individual profiles and replace them with the model profile
find "${profile_dir}" -type f -name user.js -print |
    while read user_js; do
        user_js_bak="${user_js}.${ts}.bak"
        echo "backing up '${user_js}' to '${user_js_bak}'"
        cp -af "${user_js}" "${user_js_bak}"
        echo "overwriting '${user_js}' with model profile"
        if cat "${model_js}" 1>"${user_js}" ; then
            echo "done"
        else
            echo "FAIL"
        fi
    done
