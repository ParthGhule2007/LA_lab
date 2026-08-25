#!/bin/bash
set -e

lab start edit-review

cd ~
lab_file="editing_final_lab.txt"

ls -la ~ > "$lab_file"

# 1. Delete lines 1-3, and lines containing Desktop / Public
# 2. Preserve first 4 chars of column 1 (delete characters 5 through 10)
# 3. Remove column 4 (group name)
# 4. Remove the time/year (HH:MM or YYYY) column
sed -i \
  -e '1,3d' \
  -e '/Desktop/d' \
  -e '/Public/d' \
  -e 's/^\(....\).\{6\}/\1/' \
  -e 's/^\(\([^ ]\+ \+\)\{3\}\)[^ ]\+ \+/\1/' \
  -e 's/ \+\([0-9]\{1,2\}:[0-9]\{2\}\|[0-9]\{4\}\) / /' \
  "$lab_file"

cp "$lab_file" "${lab_file}_$(date +%s)"

echo "------------" >> "$lab_file"

ls Documents | tee -a "$lab_file"

lab grade edit-review
lab finish edit-review
