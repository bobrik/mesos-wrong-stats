#!/bin/sh

set -e

dd if=/dev/urandom of=/some-data bs=1M count=256

while true; do
    sha1sum /some-data
    sleep 1
done
