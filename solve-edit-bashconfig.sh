#!/usr/bin/env bash
set -e

echo "[+] Starting lab: edit-bashconfig..."
lab start edit-bashconfig

echo "[+] Configuring servera..."
ssh student@servera 'bash -s' << 'EOF'
set -e

# 1. Append PS1 configuration to ~/.bashrc if not already present
if ! grep -q "PS1=" ~/.bashrc; then
  echo "PS1='[\u@\h \t \w]\$ '" >> ~/.bashrc
fi

# Source bashrc to update the current session
source ~/.bashrc

# 2. Local variable assignment, listing, and deletion
file=tmp.zdkei083
echo "Value of \$file: $file"

if [ -f "$file" ]; then
  ls -l "$file"
  rm "$file"
  echo "File $file successfully deleted."
fi

# 3. Export the EDITOR environment variable
export EDITOR=vim
echo "EDITOR environment variable set to: $EDITOR"
EOF

echo "[+] Finishing lab: edit-bashconfig..."
lab finish edit-bashconfig

echo "[+] Lab completed successfully!"
