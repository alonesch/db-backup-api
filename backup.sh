#!/bin/bash
set -e


# Exibe início do processo
echo "Iniciando backup do MySQL..."

# Puxa variáveis de ambiente
HOST=$MYSQL_HOST
PORT=$MYSQL_PORT
USER=$MYSQL_USER
PASS=$MYSQL_PASSWORD
DB=$MYSQL_DATABASE

# Nome do arquivo com data
DATA=$(date +"%Y-%m-%d_%H-%M")
ARQUIVO="backup-$DATA.sql"

# Gera o backup
mysqldump --single-transaction --set-gtid-purged=OFF \
  -h $HOST -P $PORT -u $USER -p$PASS $DB > "/data/$ARQUIVO"

echo "Backup gerado: /data/$ARQUIVO"
echo "Concluído com sucesso."
