#!/bin/bash

TIMESTAMP=$(date +"%F_%H-%M")

BACKUP_DIR="/home/devops/flask_backups/backups"
mkdir -p "$BACKUP_DIR"

CONTAINER="flaskapp_test-app_1"

if ! docker ps --format '{{.Names}}' | grep -q "^$CONTAINER$"; then
  echo "Container $CONTAINER not run"
  exit 1
fi

docker exec "$CONTAINER" tar czf /tmp/backup-"$TIMESTAMP".tar.gz -C /app/flaskBlog/app db
docker cp "$CONTAINER":/tmp/backup-"$TIMESTAMP".tar.gz "$BACKUP_DIR/"
docker exec "$CONTAINER" rm /tmp/backup-"$TIMESTAMP".tar.gz

echo "Backup success: $BACKUP_DIR/backup-$TIMESTAMP.tar.gz"
