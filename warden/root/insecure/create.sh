#!/bin/bash

set -o nounset
set -o errexit
cd $(dirname $(readlink -f ${0}))

if [ -z "${1}" ]; then
  echo "Usage: ${0} <name>"
  exit 1
fi

target="instances/${1}"
mkdir -p instances

if [ -d ${target} ]; then
  echo "\"${target}\" already exists, aborting..."
  exit 1
fi

cp -r skeleton "${target}"
echo ${target}
