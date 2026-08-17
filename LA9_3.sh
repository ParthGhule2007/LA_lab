#!/usr/bin/env bash
set -e

cd ~
echo "[+] Starting lab: edit-review..."
lab start edit-review

lab_file="editing_final_lab.txt"

# 1. Generate the initial file list
ls -la ~ > "$lab_file"

# 2. Process file edits matching the Vim exercise requirements
python3 - << 'EOF'
import os

file_name = os.path.expanduser("~/editing_final_lab.txt")

with open(file_name, "r") as f:
    lines = f.readlines()

# Remove the first 3 lines (total, ., ..)
lines = lines[3:]

# Remove rows containing 'Desktop' and 'Public'
lines = [l for l in lines if not re_match(l)]

processed = []
for line in lines:
    parts = line.split()
    if len(parts) >= 9:
        # Keep first 4 characters of permissions
        perm = parts[0][:4]
        links = parts[1]
        owner = parts[2]
        # parts[3] (group) is removed
        size = parts[4]
        month = parts[5]
        day = parts[6]
        # parts[7] (time/year) is removed
        name = " ".join(parts[8:])
        processed.append(f"{perm}  {links} {owner} {size} {month} {day} {name}\n")

def re_match(line):
    return "Desktop" in line or "Public" in line

with open(file_name, "w") as f:
    for line in lines:
        if "Desktop" in line or "Public" in line:
            continue
        parts = line.split()
        if len(parts) >= 9:
            perm = parts[0][:4]
            links = parts[1]
            owner = parts[2]
            size = parts[4]
            month = parts[5]
            day = parts[6]
            name = " ".join(parts[8:])
            f.write(f"{perm}  {links} {owner}  {size} {month} {day} {name}\n")
EOF

# 3. Create backup file with timestamp in seconds
cp "$lab_file" "${lab_file}_$(date +%s)"

# 4. Append 12 dash characters
echo "------------" >> "$lab_file"

# 5. List Documents directory and append using tee
ls ~/Documents | tee -a "$lab_file"

# 6. Grade and finish
echo "[+] Grading lab..."
lab grade edit-review

echo "[+] Finishing lab..."
lab finish edit-review

echo "[+] Lab edit-review completed successfully!"
