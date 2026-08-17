#!/usr/bin/env bash
set -e

cd ~
echo "[+] Starting lab: help-review..."
lab start help-review

# Generate PostScript-formatted output of the passwd man page in the home directory
man -t passwd > ~/passwd.ps

# Verify file creation and format
file ~/passwd.ps

echo "[+] Grading lab..."
lab grade help-review

echo "[+] Finishing lab..."
lab finish help-review

echo "[+] Lab help-review completed successfully!"
