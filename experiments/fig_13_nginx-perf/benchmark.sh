#!/bin/bash

# makes sure to run host setup
../common/setup-host.sh

mkdir -p rawdata results

# run benchmarks
./impl/unikraft-qemu-nginx.sh
