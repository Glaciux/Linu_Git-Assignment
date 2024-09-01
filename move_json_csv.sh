#!/bin/bash

# Directory Paths
SOURCE_DIR="./source_folder"
DEST_DIR="./json_and_CSV"

# Create Destination Directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Move CSV and JSON files
echo "Moving CSV and JSON files..."
mv "$SOURCE_DIR"/*.csv "$SOURCE_DIR"/*.json "$DEST_DIR/"

# Confirm files have been moved
if [ "$(ls -A $DEST_DIR)" ]; then
    echo "Files successfully moved to $DEST_DIR."
else
    echo "No files were moved!"
    exit 1
fi
