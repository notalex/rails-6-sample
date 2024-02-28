#!/bin/bash

branch=master

if [[ $(git diff origin/$branch HEAD *.env.staging) ]]; then
  changed_stg_files=$(git diff --name-only origin/$branch HEAD *.env.staging)
  failed=

  for stg_filename in $changed_stg_files; do
    prd_filename=$(echo $stg_filename | sed 's/staging/production/')

    stg_keys=$(cat $stg_filename | sed -E 's/^([^=]+).+/\1/' | sort)
    prd_keys=$(cat $prd_filename | sed -E 's/^([^=]+).+/\1/' | sort)

    ! [[ "${prd_keys[@]}" =~ "${stg_keys[@]}" ]] && echo "$prd_filename keys dont match with $stg_filename" && failed=1
  done

  [ $failed ] && echo 'ENV check Failed' && exit 1
  exit 0
fi
