#!/bin/bash
set -e

lab start edit-review

cd ~
lab_file="editing_final_lab.txt"

ls -la ~ > "$lab_file"

python3 -c '
import re

with open("editing_final_lab.txt", "r") as f:
    lines = f.readlines()[3:]  # remove first 3 lines

cleaned = []
for line in lines:
    if "Desktop" in line or "Public" in line:
        continue
    # Line format: perms links user group size month day time/year name
    # Trim perms to 4 chars, remove group (col 4), remove time/year (col 8)
    parts = line.split(None, 8)
    if len(parts) >= 9:
        perms = parts[0][:4]
        links = parts[1]
        user = parts[2]
        size = parts[4]
        month = parts[5]
        day = parts[6]
        name = parts[8]
        cleaned.append(f"{perms} {links} {user} {size} {month} {day} {name}")

with open("editing_final_lab.txt", "w") as f:
    f.writelines(cleaned)
'

cp "$lab_file" "${lab_file}_$(date +%s)"

echo "------------" >> "$lab_file"

ls Documents | tee -a "$lab_file"

lab grade edit-review
lab finish edit-review
