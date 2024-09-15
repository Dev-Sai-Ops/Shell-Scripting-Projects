#!/bin/bash
#$Revision:001$
#Sun Sep 15 06:18:47 UTC 2024$

# Variables
BASE=/home/ec2-user
DAYS=10
DEPTH=1
RUN=0

# Check if the directory is present or not
if [ ! -d $BASE ]; then
    echo "Directory does not exist: $BASE"
    exit 1
fi

# Create 'archive' folder if not present
if [ ! -d $BASE/archive ]; then
    mkdir $BASE/archive
fi

# Find the list of files larger than any size you want mention in next line
for i in `find $BASE -maxdepth $DEPTH -type f -size +2M`; do
    if [ $RUN -eq 0 ]; then  # Corrected if condition
        echo "[$(date "+%Y-%m-%d %H:%M:%S")] Archiving $i ==> $BASE/archive"
        gzip $i || exit 1
        mv $i.gz $BASE/archive || exit 1  # Corrected typo in 'archive'
    fi
done
