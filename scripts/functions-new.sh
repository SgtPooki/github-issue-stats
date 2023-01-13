#!/usr/bin/env bash
set -euf -o pipefail

api=https://api.github.com

page=1
function saveIssuePage {
  echo -e "\$saveIssuePage called: \n"
  # json="${1}"
  while read -r data; do
    printf "%s" "$page"
  done

  # echo "${json}" > "${path}/page-$(printf "%03d" "${page}").json"
  # echo "${json}" > "${path}/issues.json"
  page=$((page+1))
}

# Fetches a resource, paginating until the response is empty.
# When all resources have been fetched, combine them all into one file.
#
function fetch { # path query
  ownerAndRepo=$1
  path="repos/$1"
  query=$2
  baseUrl="${api}/${path}?${query}"
  ghApi="/repos/$ownerAndRepo/issues"

  mkdir -p $(dirname "${path}")

  # gh api -X GET /repos/ipfs/ipfs-companion/issues -f state='all' --paginate | ./saveIssuePage.sh

  # page=1
  # while :
  # do
    # url="${baseUrl}&page=${page}"
    # echo "${url}"
    # json=$(gh issue list -L 100 -R "${ownerAndRepo}" --json "assignees,author,body,closed,closedAt,comments,createdAt,id,labels,milestone,number,projectCards,reactionGroups,state,title,updatedAt,url" | jq . -c --raw-output)

    # json=$(gh api "${ghApi}" | jq . -c --raw-output)
  json=$(gh api -X GET /repos/ipfs/ipfs-companion/issues -f state='all' --paginate)
    # if [ "${json}" == "[]" ]; then
    #   break
    # fi
  #   echo "${json}" > "${path}/page-$(printf "%03d" "${page}").json"
  echo "${json}" > "${path}/issues.json"
  #   page=$((page+1))
  # done

  # Combine them all into one file for easier processing
  # find "${path}" -type f | xargs jq -s add > "${path}/issues.json"
}
