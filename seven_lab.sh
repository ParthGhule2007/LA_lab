#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "1. Creating the /home/techdocs directory..."
mkdir -p /home/techdocs

echo "2. Changing group ownership to techdocs..."
chown :techdocs /home/techdocs

echo "3. Setting permissions (setgid, rwx for user/group, none for others)..."
chmod 2770 /home/techdocs

echo "4. Updating the default umask in /etc/login.defs to 007..."
if grep -q "^UMASK" /etc/login.defs; then
    sed -i 's/^UMASK.*/UMASK 007/' /etc/login.defs
else
    echo "UMASK 007" >> /etc/login.defs
fi

echo "Lab configuration completed successfully!"
