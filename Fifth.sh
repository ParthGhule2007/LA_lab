#!/bin/bash
set -e

lab start edit-review

cd ~
lab_file="editing_final_lab.txt"

ls -la ~ > "$lab_file"

vim -es -c '1,3d' \
        -c '%s/^\(....\)[^ ]*\( \+[0-9]\+ \+[^ ]\+\) \+[^ ]\+/\1\2/' \
        -c '%s/ \+[0-9]\{1,2\}:[0-9]\{2\}//' \
        -c '%s/ \+[0-9]\{4\}//' \
        -c 'g/Desktop/d' \
        -c 'g/Public/d' \
        -c 'wq' "$lab_file"

cp "$lab_file" "${lab_file}_$(date +%s)"

echo "------------" >> "$lab_file"

ls Documents | tee -a "$lab_file"

lab grade edit-review
lab finish edit-review
