#!/bin/bash

# Base directory for Repo A
repo_a_dir=~/Dev/redcap/redcap_rsvc/

# Find all `.feature` files in Repo A
find "$repo_a_dir" -type f -name "*.feature" | while read -r file; do
  # Extract the directory and filename
  dir=$(dirname "$file")
  base=$(basename "$file")

  # Match and extract the numeric part using Bash pattern matching
  if [[ "$base" =~ ([A-C]\.[0-9]+\.[0-9]+\.)[0-9]+(.*) ]]; then
    prefix="${BASH_REMATCH[1]}"    # Prefix, e.g., "A.2.2."
    number="${BASH_REMATCH[0]##*.}" # Extract the numeric part, e.g., "100"
    suffix="${BASH_REMATCH[2]}"    # Suffix, e.g., " - Account Lockout.feature"

    # Pad the number to four digits
    padded_number=$(printf "%04d" "$number")

    # Create the new filename
    new_base="${prefix}${padded_number}.${suffix}"

    # Perform the rename
    mv "$file" "$dir/$new_base"
  fi
done