#!/bin/bash

# Environment Variables
URL="http://example.com/data.csv"  # Replace with the actual URL

# Directory Paths
RAW_DIR="./raw"
TRANSFORMED_DIR="./Transformed"
GOLD_DIR="./Gold"

# Create Directories if they don't exist
mkdir -p "$RAW_DIR" "$TRANSFORMED_DIR" "$GOLD_DIR"

# Extract: Download the CSV file
echo "Downloading the CSV file from $URL..."
curl -o "$RAW_DIR/data.csv" $URL

# Confirm the file has been saved into the raw folder
if [ -f "$RAW_DIR/data.csv" ]; then
    echo "File successfully downloaded and saved to $RAW_DIR."
else
    echo "File download failed!"
    exit 1
fi

# Transform: Rename the column and select specific columns
echo "Transforming the data..."
awk -F, 'BEGIN {OFS=","} NR==1 {for (i=1;i<=NF;i++) if ($i=="Variable_code") $i="variable_code"} {print $1,$2,$3,$4}' "$RAW_DIR/data.csv" > "$TRANSFORMED_DIR/2023_year_finance.csv"

# Confirm the file has been saved into the Transformed folder
if [ -f "$TRANSFORMED_DIR/2023_year_finance.csv" ]; then
    echo "Transformation successful, file saved to $TRANSFORMED_DIR."
else
    echo "Transformation failed!"
    exit 1
fi

# Load: Move the transformed file to the Gold directory
echo "Loading the transformed data to the Gold directory..."
mv "$TRANSFORMED_DIR/2023_year_finance.csv" "$GOLD_DIR/"

# Confirm the file has been saved into the Gold folder
if [ -f "$GOLD_DIR/2023_year_finance.csv" ]; then
    echo "File successfully loaded into the Gold directory."
else
    echo "Loading failed!"
    exit 1
fi
