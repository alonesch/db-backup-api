FROM ubuntu:22.04

# Instala cliente MariaDB/MySQL + git + bash + timezone
RUN apt-get update && apt-get install -y \
    mariadb-client \
    git \
    bash \
    tzdata

# Cria pasta de backup
RUN mkdir -p /data

# Copia script
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

CMD ["/backup.sh"]
