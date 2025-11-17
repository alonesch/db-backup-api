#!/bin/bash
set -e

echo "Iniciando backup do MySQL/MariaDB..."

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
FILENAME="backup-$TIMESTAMP.sql"
FILEPATH="/data/$FILENAME"

echo "Conectando em:"
echo "Host: $MYSQL_HOST"
echo "Porta: $MYSQL_PORT"
echo "User: $MYSQL_USER"
echo "Banco: $MYSQL_DATABASE"

mariadb-dump \
  -h "$MYSQL_HOST" \
  -P "$MYSQL_PORT" \
  -u "$MYSQL_USER" \
  --password="$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" > "$FILEPATH"

echo "Backup gerado: $FILEPATH"
