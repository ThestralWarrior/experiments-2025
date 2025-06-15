#!/bin/bash

set -x

# If no arguments provided, print usage and exit
if [ $# -eq 0 ]; then
  echo "Usage: $0 <function_numbers>"
  echo "  1: unikraft_eurosys21_build"
  echo "  2: unikraft_eurosys21_build_2"
  echo "  3: unikraft_new_build"
  exit 1
fi

BUILDDIR=..
IMAGES=$(pwd)/images
BASEIP=172.190.0
GUESTSTART=$(pwd)/data/guest_start.sh

source ../common/build.sh
source ../common/set-cpus.sh

rm -rf $IMAGES
mkdir -p $IMAGES

# ========================================================================
# Generate Unikraft VM images
# ========================================================================

for arg in "$@"; do
  case "$arg" in
    1)
      unikraft_eurosys21_build nginx mimalloc $IMAGES
      ;;
    2)
      unikraft_eurosys21_build_2 nginx mimalloc $IMAGES
      ;;
    3)
      unikraft_new_build nginx mimalloc $IMAGES
      ;;
    *)
      echo "Invalid argument: $arg. Use 1, 2, or 3."
      exit 1
      ;;
  esac
done

# ========================================================================
