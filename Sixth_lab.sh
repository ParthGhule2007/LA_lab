#!/bin/bash
set -e

echo "=== 1. Starting the lab on workstation ==="
lab start users-review

echo "=== 2. Configuring serverb via SSH ==="
ssh student@serverb 'echo "student" | sudo -S bash -c "
set -e

# Default password policy to 30 days
sed -i \"s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   30/\" /etc/login.defs

# Create group
groupadd -g 35000 consultants

# Configure sudoers drop-in
echo \"%consultants ALL=(ALL) ALL\" > /etc/sudoers.d/consultants
chmod 0440 /etc/sudoers.d/consultants

# Create users, set passwords, expiry, and first-login change
EXPIRE_DATE=\$(date -d \"+90 days\" +%Y-%m-%d)
for u in consultant1 consultant2 consultant3; do
    useradd -G consultants -e \"\$EXPIRE_DATE\" \"\$u\"
    echo \"redhat\" | passwd --stdin \"\$u\"
    chage -d 0 \"\$u\"
done

# Consultant2 password aging
chage -M 15 consultant2
"'

echo "=== 3. Grading the lab ==="
lab grade users-review

echo "=== 4. Finishing the lab ==="
lab finish users-review

echo "=== Lab completed successfully! ==="
