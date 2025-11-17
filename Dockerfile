FROM mysql:8.0-debian

# Criar diretório para backups
RUN mkdir -p /data

# Copiar script
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

# Comando padrão
CMD ["/backup.sh"]
