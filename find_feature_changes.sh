#!/bin/bash

# Inputs on single line if desired
if [ $# -ge 3 ]; then
  TAG=$1
  START_DATE=$2
  END_DATE=$3

# If only one input is passed, put that input into the start date; end date implied as today
elif [ $# -eq 1 ]; then
   TAG=$1
# Ask for inputs if not provided
else
  read -p "START DATE (yyyy-mm-dd): " START_DATE
  read -p "END DATE (yyyy-mm-dd): " END_DATE
fi

#Offer chance to enter a  TAG
if [ -z $TAG ]; then
  read -p "TAG TO COMPARE: "  TAG
fi

#Set default  TAG to staging
if [ -z $TAG ]; then
   TAG=$(git tag --sort=-creatordate | sed -n 2p)
   git checkout $(git tag --sort=-v:refname | head -n 1)
fi

#Only if empty Start Date
if [ -z $START_DATE ]; then
  START_DATE=$(git show -s --format=%ad --date=short $(git merge-base $TAG HEAD)) # Day of first divergence from staging

  # GNU date (Linux)
  if date --version >/dev/null 2>&1; then
    START_DATE=$(date -I -d "$START_DATE - 1 day") # One day before

  # BSD date (macOS)
  else
    START_DATE=$(date -j -v-1d -f "%Y-%m-%d" "$START_DATE" "+%Y-%m-%d")
  fi
fi

#Only if empty End Date
if [ -z $END_DATE ]; then
  END_DATE=$(date +%Y-%m-%d)  # Default to today
fi

#Trim white space
START_DATE=$(echo "$START_DATE" | xargs)
END_DATE=$(echo "$END_DATE" | xargs)

# Get the line changes for .feature files between the dates
git log --since="$START_DATE" --until="$END_DATE" --pretty=tformat: --numstat --ignore-space-change \
| awk -F'\t' '
$3 ~ /\.feature$/ {
  added[$3] += $1;
  deleted[$3] += $2;
  files[$3] = 1;
}
END {
  total_added = 0;
  total_deleted = 0;
  printf "%10s %10s %10s   %s\n", "Added", "Deleted", "Total", "File";
  for (file in files) {
    file_added = added[file];
    file_deleted = deleted[file];
    file_total = file_added + file_deleted;
    total_added += file_added;
    total_deleted += file_deleted;
    printf "%10d %10d %10d   %s\n", file_added, file_deleted, file_total, file;
  }
  printf "%s\n", "---------------------------------------------------------------";
  printf "%10d %10d %10d   %s\n", total_added, total_deleted, total_added + total_deleted, "TOTAL";
}'

echo "\n\n START_DATE: $START_DATE \n END_DATE: $END_DATE\n CURRENT TAG: $(git describe --tags --exact-match) \n COMPARISON TAG: $TAG \n"