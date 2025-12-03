FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo


RUN apt-get update && apt-get install -y \
    postgresql-client \
    git \
    bash \
    tzdata

RUN mkdir -p /data

COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

CMD ["/backup.sh"]
