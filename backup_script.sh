#!/bin/bash

# This script takes one positional argument:
# $1: The directory to backup

backup_dir=$1
dest_dir=$2

# Create a backup directory if it doesn't exist
if [ ! -d "$backup_dir" ]; then
  mkdir $backup_dir
fi

# Loop through all the files in the directory
for file in $backup_dir/*; do

  # Get the filename
  filename=$(basename $file)

  # Create a backup of the file
  cp $file $dest_dir/$filename.bak
 
done
