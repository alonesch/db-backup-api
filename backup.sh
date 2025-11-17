#!/bin/bash
set -e

echo "Iniciando backup do MySQL/MariaDB..."

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
FILENAME="backup-$TIMESTAMP.sql"
FILEPATH="$BACKUP_PATH/$FILENAME"

# MariaDB usa o comando mariadb-dump
mariadb-dump \
  -h "$DB_HOST" \
  -P "$DB_PORT" \
  -u "$DB_USER" \
  -p"$DB_PASS" \
  "$DB_NAME" > "$FILEPATH"

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
