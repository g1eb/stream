#!/bin/bash

# Path to the directory where Motion saves recordings
TARGET_DIR="/var/lib/motion/"

# File age threshold in minutes
MAX_AGE_MINUTES=15

# Delete files older than the specified age
find "$TARGET_DIR" -type f -name '*.mkv' -mmin +$MAX_AGE_MINUTES -exec rm -f {} \;

# TODO: Setup a cronjob to run this cleanup script
# */30 * * * * /etc/motion/cleanup.sh
