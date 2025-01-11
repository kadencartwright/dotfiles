#! /bin/env bash
state=$(cat ~/.config/google-chrome/Local\ State)
profile=$(echo $state | jq  -r '.profile.info_cache[].name' | fuzzel -d)

profile_dir=$(echo $state | jq  -r --arg name "$profile" '.profile.info_cache | map_values(select (.name==$name))|keys[]')
echo $profile_dir
if [[ -n "${profile_dir}" ]]; then
    google-chrome-stable --profile-directory="$profile_dir" --remote-debugging-port=9222
fi
