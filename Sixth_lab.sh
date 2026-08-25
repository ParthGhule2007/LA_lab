#!/bin/bash
set -e

echo "=== 1. Starting the lab on workstation ==="
lab start users-review

echo "=== 2. Configuring serverb via SSH ==="
ssh student@serverb 'sudo bash -s' << 'EOF'
set -e

echo "--> Setting default password aging to 30 days in /etc/login.defs..."
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   30/' /etc/login.defs

echo "--> Creating consultants group (GID 35000)..."
groupadd -g 35000 consultants

echo "--> Configuring sudo privileges in /etc/sudoers.d/consultants..."
echo "%consultants ALL=(ALL) ALL" > /etc/sudoers.d/consultants
chmod 0440 /etc/sudoers.d/consultants

echo "--> Creating users with supplementary group, 90-day expiry, and initial password..."
EXPIRE_DATE=$(date -d "+90 days" +%Y-%m-%d)

for user in consultant1 consultant2 consultant3; do
    useradd -G consultants -e "$EXPIRE_DATE" "$user"
    echo "redhat" | passwd --stdin "$user"
    chage -d 0 "$user"
done

echo "--> Setting consultant2 password max age to 15 days..."
chage -M 15 consultant2

echo "--> serverb configuration complete."
EOF

echo "=== 3. Grading the lab ==="
lab grade users-review

echo "=== 4. Finishing the lab ==="
lab finish users-review

echo "=== Lab completed successfully! ==="
