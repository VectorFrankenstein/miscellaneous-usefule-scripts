#!/bin/bash

# the goal of this script is to clean up empty directories.

# the idea is to leverage the power of wc -l to see which directories are empty.

# use --loc to supply the location that you want cleaned up

while test $# -gt 0; do
  case "$1" in
    --loc)
        shift
        location_main=$1
        shift
        ;;
  esac
done

# TODO: add a way for the user to re-supply the location.

if [[ ! -d $location_main ]]; then
  echo "The location that you supplied either does not exist or is not accessible.\n Please make sure the relative path is proper or if the right path has been supplied."
  echo "Exiting"
  exit 0
  # Is it possible to ask the user to re-enter the path and re-check and continue from there if it exists?
fi

cd $location_main

if [[ ! -d empty_ones ]]; then
  mkdir empty_ones
fi

for dir in $(ls -d */)
do
  num=$(ls $dir | wc -l)
  if (($num==0)); then
    mv $dir empty_ones/
  fi
done