#!/usr/bin/env bash
set -e

cd ~
echo "[+] Starting lab: edit-review..."
lab start edit-review

lab_file="editing_final_lab.txt"

# 1. Output full ls -la listing to the lab file
ls -la ~ > "$lab_file"

# 2. Perform file edits:
# - Remove first 3 lines
# - Remove lines containing 'Desktop' or 'Public'
# - Trim permissions to 4 chars, remove column 4 (group), remove time/year column
tail -n +4 "$lab_file" | grep -v -E "Desktop|Public" | awk '{
    sub(/^[a-zA-Z-]{4}[a-zA-Z-]+/, substr($1, 1, 4), $1);
    name=""; for(i=9; i<=NF; i++) name=(name=="" ? $i : name" "$i);
    printf "%-4s  %2s %-7s %5s %3s %2s %s\n", substr($1, 1, 4), $2, $3, $5, $6, $7, name
}' > "${lab_file}.tmp" && mv "${lab_file}.tmp" "$lab_file"

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
