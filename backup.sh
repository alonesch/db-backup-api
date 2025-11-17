#!/bin/bash
set -e

echo "Iniciando backup do MySQL..."

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
FILENAME="backup-$TIMESTAMP.sql"
FILEPATH="$BACKUP_PATH/$FILENAME"

mysqldump --single-transaction \
  -h "$MYSQL_HOST" \
  -P "$MYSQL_PORT" \
  -u "$MYSQL_USER" \
  -p"$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" > "$FILEPATH"

echo "Backup gerado: $FILEPATH"

echo "Enviando backup para o GitHub..."

cd /tmp
git clone https://"$GITHUB_USERNAME":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPO".git repo
cd repo

mkdir -p backups
cp "$FILEPATH" backups/

git config user.email "backup@railway"
git config user.name "Railway Backup Bot"

git add backups/
git commit -m "Backup automático - $TIMESTAMP"
git push

echo "Backup enviado com sucesso!"
