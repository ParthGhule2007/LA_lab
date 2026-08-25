#!/bin/bash
set -e

lab start users-review

ssh student@serverb 'echo "student" | sudo -S bash -c "
sed -i \"s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   30/\" /etc/login.defs
groupadd -g 35000 consultants
echo \"%consultants ALL=(ALL) ALL\" > /etc/sudoers.d/consultants
chmod 0440 /etc/sudoers.d/consultants
EXPIRE_DATE=\$(date -d \"+90 days\" +%Y-%m-%d)
for u in consultant1 consultant2 consultant3; do
    useradd -G consultants -e \"\$EXPIRE_DATE\" \"\$u\"
    echo \"redhat\" | passwd --stdin \"\$u\"
    chage -d 0 \"\$u\"
done
chage -M 15 consultant2
"'

lab grade users-review
lab finish users-review
cd ..
