#!/bin/bash
set -e

# 1. Start the lab environment
lab start rhcsa-rh124-review1

# 2. Run the tasks on serverb via SSH
ssh student@serverb 'bash -s' << 'EOF'
set -e

# Create directory and empty files
mkdir -p /home/student/grading
touch /home/student/grading/grade{1,2,3}

# Capture first 5 lines and append last 3 lines
head -n 5 /home/student/bin/manage > /home/student/grading/review.txt
tail -n 3 /home/student/bin/manage >> /home/student/grading/review.txt

# Copy to review-copy.txt
cp /home/student/grading/review.txt /home/student/grading/review-copy.txt

# Perform required text edits on review-copy.txt:
# - Duplicate "Test JJ"
# - Remove "Test HH"
# - Insert "Level 1 Training" between "Test BB" and "Test CC"
sed -i \
  -e '/Test JJ/p' \
  -e '/Test HH/d' \
  -e '/Test BB/a Level 1 Training' \
  /home/student/grading/review-copy.txt

# Create hard link and symbolic link
ln /home/student/grading/grade1 /home/student/hardcopy
ln -s /home/student/grading/grade2 /home/student/softcopy

# Save long listing of /boot (excluding hidden files)
ls -l /boot > /home/student/grading/longlisting.txt
EOF

# 3. Grade and finish the lab
lab grade rhcsa-rh124-review1
cd ..
