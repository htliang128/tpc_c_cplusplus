#!/bin/sh

. ./functions.sh

echo "iscsi-test-cu TestUnitReady test"

start_target
create_disk_lun 1 100M

exit 0