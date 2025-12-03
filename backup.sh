#!/bin/bash
set -e

echo "Iniciando backup do PostgreSQL..."

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
FILENAME="backup-$TIMESTAMP.sql"
FILEPATH="/tmp/$FILENAME"

echo "Connection string:"
echo "$POSTGRES_CONNECTION"

# Dump do PostgreSQL
pg_dump "$POSTGRES_CONNECTION" > "$FILEPATH"

echo "Backup gerado: $FILEPATH"

# ---- ENVIO PARA O GITHUB ----

echo "Enviando backup para o GitHub..."

cd /tmp
git clone https://"$GITHUB_USERNAME":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPO".git repo
cd repo

mkdir -p backups
cp "$FILEPATH" backups/

git config user.email "backup@render"
git config user.name "Render Backup Bot"

git add backups/
git commit -m "Backup automático - $TIMESTAMP"
git push

echo "Backup enviado com sucesso!"
