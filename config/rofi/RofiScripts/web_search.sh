#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
  ["baidu"]="https://www.baidu.com/search?q="
  ["google"]="https://www.google.com/search?q="
  ["zhihu"]="https://www.zhihu.com/search?type=content&q="
  ["duckduckgo"]="https://www.duckduckgo.com/?q="
  ["github"]="https://github.com/search?q="
  ["stackoverflow"]="http://stackoverflow.com/search?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -only-match -location 0 -p "Search > " )

  query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )
  if [[ -n "$query" ]]; then
    url=${URLS[$platform]}$query
    xdg-open "$url"
  else
    rofi -show -e "No query provided."
  fi
}

main

exit 0