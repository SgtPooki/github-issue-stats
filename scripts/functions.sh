#!/usr/bin/env bash
set -euf -o pipefail

api=https://api.github.com

# Fetches a resource, paginating until the response is empty.
# When all resources have been fetched, combine them all into one file.
#
function fetch { # path query
  ownerAndRepo=$1
  path="repos/$1"
  ghApi="/$path/issues"

  echo "Ensuring $path exists"
  mkdir -p $path

  echo "Getting all issues using 'gh api ${ghApi} --paginate'"
  # gh api --paginate returns multiple arrays of length 100 until all issues are retrieved
  # with `jq -s add` we add all of them into a single array
  json=$(gh api -X GET ${ghApi} -f state='all' --paginate | jq -s add)

  echo "Saving issue JSON to ${path}/issues.json"
  echo "${json}" > "${path}/issues.json"
}
