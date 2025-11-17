FROM mysql:9.0-oracle

# Instala bash no container
RUN apt-get update && apt-get install -y bash

# Copia o script
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

# Ponto de entrada padrão (não roda sozinho)
CMD ["/bin/bash", "/backup.sh"]
