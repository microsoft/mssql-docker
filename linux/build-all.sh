#!/usr/bin/env bash

set -euo pipefail

# Find all the directories with dockerfiles
all_dirs="$(find . -name Dockerfile -print0 | xargs -0 -n1 dirname | sort --unique)"

errors=()

for d in $all_dirs; do
  echo "$d"
  pushd "$d"
  # This will allow a build to continue after a failure
  if docker build .; then
    # swallow the error
    echo "Built $d succesfully"
  else
    echo "Failed to build $d. Recording error."
    errors+=("$d")
  fi
  popd
done

if [ ${#errors[@]} -eq 0 ]; then
    echo 'All Dockerfiles succesfully built'
else
    echo 'Some Dockerfiles failed to build'
    echo "${errors[@]}"
    exit 1
fi
