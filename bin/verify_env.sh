#!/bin/bash

branch=master

if [[ $(git diff origin/$branch HEAD *env.staging*) ]]; then
  changed_stg_files=$(git diff --name-only origin/$branch HEAD *env.staging*)
  FAILED=

  for stg_filename in $changed_stg_files; do
    prd_filename=$(echo $stg_filename | sed 's/staging/production/')

    stg_keys=$(cat $stg_filename | grep '=' | sed -E 's/^([^=]+).+/\1/' | sort)
    prd_keys=$(cat $prd_filename | grep '=' | sed -E 's/^([^=]+).+/\1/' | sort)

    for element in $stg_keys; do
      if ! [[ "${prd_keys[@]}" =~ $element ]]; then
        echo "$element not found in $prd_filename"
        FAILED=1
      fi
    done
  done

  [ $FAILED ] && echo 'ENV check Failed' && exit 1
  exit 0
fi
