#!/bin/bash
set -ux
set -o pipefail

export PACKER_FOLDER=${WERCKER_PACKER_FOLDER:-'packer'}
export TEMPLATES_STRING=${WERCKER_PACKER_TEMPLATES:-'ubuntu-14.04_amd64-amis.json'}
export PACKER_VERSION=${WERCKER_PACKER_VERSION:-0.8.1}

LAST_MERGE=git log --pretty=%H --merges -n 3 | awk 'NR == 1 { print $1 }'
PREVIEWS_MERGE=git log --pretty=%H --merges -n 3 | awk 'NR == 2 { print $1 }'

if git diff "${LAST_MERGE}".."${PREVIEWS_MERGE}" --name-only | grep "${PACKER_FOLDER}/"; then

  # Install Packer.
  wget "https://dl.bintray.com/mitchellh/packer/packer_${PACKER_VERSION}_linux_amd64.zip"
  unzip packer_0.7.5_linux_amd64.zip
  export PATH=$PATH:`pwd`
  packer version

  #looping packer templates.
  IFS=','
  TEMPLATES_ARRAY=( "${TEMPLATES_STRING}" )
  pushd "${PACKER_FOLDER}"
  for ((i=0; i<${#TEMPLATES_ARRAY[*]}; i++));
  do
    packer push "${TEMPLATES_ARRAY[i]}"
  done
  popd
fi

