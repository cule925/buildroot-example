#!/bin/bash

docker run --rm -it -v "$(pwd)":/workspace buildroot-builder bash -c "./make_buildroot.sh \"$@\"" -- "$@"
