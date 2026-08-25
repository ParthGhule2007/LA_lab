#!/bin/bash
set -e

echo "=== 1. Starting the lab on workstation ==="
lab start perms-review

echo "=== 2. Configuring serverb via SSH ==="
ssh student@serverb 'echo "student" | sudo -S bash -c "
set -e

# 1. Create the /home/techdocs directory
mkdir -p /home/techdocs

# 2. Change group ownership to techdocs
chown :techdocs /home/techdocs

# 3. Set SGID (2), full access for user/group (77), none for others (0)
chmod 2770 /home/techdocs

# 4. Set default umask to 007 in /etc/login.defs
if grep -q \"^UMASK\" /etc/login.defs; then
    sed -i \"s/^UMASK.*/UMASK 007/\" /etc/login.defs
else
    echo \"UMASK 007\" >> /etc/login.defs
fi
"'

echo "=== 3. Grading the lab ==="
lab grade perms-review

echo "=== 4. Finishing the lab ==="
lab finish perms-review

echo "=== Lab completed successfully! ==="
