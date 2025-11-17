#!/bin/bash
set -e

echo "Iniciando backup do MySQL/MariaDB..."

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
FILENAME="backup-$TIMESTAMP.sql"
FILEPATH="/tmp/$FILENAME"

echo "Conectando em:"
echo "Host: $MYSQL_HOST"
echo "Porta: $MYSQL_PORT"
echo "User: $MYSQL_USER"
echo "Banco: $MYSQL_DATABASE"

# Dump
mariadb-dump \
  -h "$MYSQL_HOST" \
  -P "$MYSQL_PORT" \
  -u "$MYSQL_USER" \
  --password="$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" > "$FILEPATH"

echo "Backup gerado: $FILEPATH"

# ---- ENVIO PARA O GITHUB ----

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
