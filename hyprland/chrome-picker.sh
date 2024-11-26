#! /bin/env bash
state=$(cat ~/.config/google-chrome/Local\ State)
profile=$(echo $state | jq  -r '.profile.info_cache[].name' | fuzzel -d)

echo $state | jq  --arg name "$profile" '.profile.info_cache | map_values(select (.name==$name))|keys[]' | xargs -r google-chrome-stable --profile-directory
