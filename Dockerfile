FROM mysql:8.0-debian

# Instala bash e cron
RUN apt-get update && apt-get install -y bash

# Copia o script
COPY backup.sh /backup.sh

# Dá permissão
RUN chmod +x /backup.sh

# Comando padrão
CMD ["bash", "/backup.sh"]
