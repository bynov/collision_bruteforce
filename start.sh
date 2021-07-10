#!/bin/bash

path=$1
target_commit_short=$2

if [ "$#" -ne 2 ]; then
  echo "./start.sh <full_path_to_target_repo> <target_commit_short>"

  exit 1
fi

if [ "${#target_commit_short}" -ne 7 ]; then
  echo "<target_commit_short> must be len 7"

  exit 1
fi

function try_commit() {
  new_commit=$(
    cd "${path}" &&
    git commit --amend --no-gpg-sign --no-edit > /dev/null 2>&1 &&
    git rev-parse --short HEAD
  )

  echo "Trying commit ${new_commit} ..."

  if [[ ${new_commit} == "${target_commit_short}" ]]; then
    echo "[DONE] New commit: ${new_commit}"

    exit 0
  fi
}

while true
do
	try_commit
	sleep 1
done

