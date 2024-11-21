#!/bin/bash

# Base directory for
repo_a_dir=$(pwd)

# Find all `.feature` files in Repo A
find "$repo_a_dir" -type f -name "*.feature" | while read -r file; do
    # Extract the directory and filename
    dir=$(dirname "$file")
    base=$(basename "$file")

  # Match and extract the parts of the filename
  if [[ "$base" =~ ([A-C]\.[0-9]+\.[0-9]+\.)[0-9]+ ]]; then
    prefix="${BASH_REMATCH[1]}"                # Prefix up to the third period, e.g., "A.2.2."
    number="${base:${#prefix}:$((${#base} - ${#prefix}))}" # Extract everything after the prefix
    number="${number%%[^0-9]*}"                # Extract only the numeric portion after the third period
    suffix="${base#* - }"                      # Everything after " - "

    # Pad the number to four digits
    padded_number=$(printf "%04d" "$number")

    # Construct the new filename
    new_base="${prefix}${padded_number}. - ${suffix}"

    echo "Processing file: $file"
    echo "Prefix: $prefix"
    echo "Number: $number"
    echo "Suffix: $suffix"
    echo "New Base: $new_base"

    # Rename the file
    mv "$file" "$dir/$new_base"
  fi
done