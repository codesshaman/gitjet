#!/bin/bash
set -e

# === Настройки пользователя ===
GITHUB_USER="your_user"
GITHUB_EMAIL="your_email@example.com"
KEY_NAME="github_${GITHUB_USER}"   # имя ключа
KEY_PATH="$HOME/.ssh/${KEY_NAME}"  # путь к ключу

# === Генерация ключа ===
echo "👉 Генерация SSH-ключа для $GITHUB_USER"
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$KEY_PATH" -N ""

# === Запуск ssh-agent ===
echo "👉 Добавляем ключ в ssh-agent"
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# === Добавление в ~/.ssh/config ===
CONFIG_FILE="$HOME/.ssh/config"

echo "👉 Обновляем $CONFIG_FILE"

# Создадим файл config, если его нет
if [ ! -f "$CONFIG_FILE" ]; then
  touch "$CONFIG_FILE"
  chmod 600 "$CONFIG_FILE"
fi

# Проверим, есть ли уже запись для github.com
if grep -q "Host github.com" "$CONFIG_FILE"; then
  echo "⚠️  Запись для github.com уже существует в $CONFIG_FILE, пропускаем"
else
  cat >> "$CONFIG_FILE" <<EOF

Host github.com
    User git
    HostName github.com
    IdentityFile $KEY_PATH
    IdentitiesOnly yes
EOF
  echo "✅ Запись для github.com добавлена в $CONFIG_FILE"
fi

# === Вывод публичного ключа для вставки в GitHub ===
echo "👉 Публичный ключ (вставь его в GitHub → Settings → SSH and GPG keys):"
echo "------------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "------------------------------------------------------------"
echo "Готово! Теперь можно проверить соединение командой:"
echo "ssh -T git@github.com"
