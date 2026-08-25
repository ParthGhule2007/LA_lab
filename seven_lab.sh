#!/bin/bash
set -e

lab start perms-review

ssh student@serverb 'echo "student" | sudo -S bash -c "
mkdir -p /home/techdocs
chown :techdocs /home/techdocs
chmod 2770 /home/techdocs
sed -i \"s/^UMASK.*/UMASK 007/\" /etc/login.defs
"'

lab grade perms-review
lab finish perms-review
