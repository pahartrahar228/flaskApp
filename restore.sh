#!/bin/bash

# Проверка аргументов
if [ -z "$1" ]; then
  echo "Specify the path to the archive to restore (example: /home/devops/flask_backups/backups/backup-2025-07-06_15-50.tar.gz)"
  exit 1
fi

BACKUP_ARCHIVE="$1"
TMP_DIR="/home/devops/flask_backups/backups/tmp_restore"
CONTAINER="flaskapp_test-app_1"
TARGET_PATH="/app/flaskBlog/app"

if [ ! -f "$BACKUP_ARCHIVE" ]; then
  echo " File name '$BACKUP_ARCHIVE' not found"
  exit 1
fi

mkdir -p "$TMP_DIR"
rm -rf "$TMP_DIR"/*
tar -xzf "$BACKUP_ARCHIVE" -C "$TMP_DIR"

if [ ! -d "$TMP_DIR/db" ]; then
  echo "Not found folder 'db' from archive"
  exit 1
fi

docker cp "$TMP_DIR/db" "$CONTAINER":"$TARGET_PATH"

echo "Backup success"

