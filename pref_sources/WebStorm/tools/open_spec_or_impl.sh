#!/bin/bash

if [ -z "$2" ]; then
  echo "This script must be called with file path and project root" >&2
  exit 1
fi

if [[ "$1" =~ .*spec\.js ]]; then
  #in a spec file
  if [ -d "src" ]; then
    # source files are in src/, spec files are in spec/
    file_to_open_part1=${1/spec\//src\//}
  else
    # source files are in root/, spec files are in root/spec/
    file_to_open_part1=$2${1#$2"/spec"}
  fi
  file_to_open=${file_to_open_part1/_spec\.js/\.js}
else
  if [ -d "src" ]; then
    # source files are in src/, spec files are in spec/
    file_to_open_part1=${1/src\//spec\//}
  else
    # source files are in root, spec files are in root/spec
    file_to_open_part1=$2"/spec"${1#$2}
  fi
  file_to_open=${file_to_open_part1/\.js/_spec\.js}
fi

touch $file_to_open

wstorm $file_to_open
