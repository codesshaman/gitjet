#!/bin/bash
set -e

# === User settings ===
GITHUB_USER="your_user"
GITHUB_EMAIL="your_email@example.com"
KEY_NAME="github_${GITHUB_USER}"   # key name
KEY_PATH="$HOME/.ssh/${KEY_NAME}"  # key path

# === Generate SSH key ===
echo "👉 Generating SSH key for $GITHUB_USER"
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$KEY_PATH" -N ""

# === Start ssh-agent and add key ===
echo "👉 Adding key to ssh-agent"
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# === Update ~/.ssh/config ===
CONFIG_FILE="$HOME/.ssh/config"

echo "👉 Updating $CONFIG_FILE"

# Create config file if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  touch "$CONFIG_FILE"
  chmod 600 "$CONFIG_FILE"
fi

# Check if entry for github.com already exists
if grep -q "Host github.com" "$CONFIG_FILE"; then
  echo "⚠️  Entry for github.com already exists in $CONFIG_FILE, skipping"
else
  cat >> "$CONFIG_FILE" <<EOF

Host github.com
    User git
    HostName github.com
    IdentityFile $KEY_PATH
    IdentitiesOnly yes
EOF
  echo "✅ Entry for github.com has been added to $CONFIG_FILE"
fi

# === Show public key for GitHub ===
echo "👉 Here is your public key (add it to GitHub → Settings → SSH and GPG keys):"
echo "------------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "------------------------------------------------------------"
echo "Done! Now you can test the connection with:"
echo "ssh -T git@github.com"
