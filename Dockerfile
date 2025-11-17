FROM alpine:latest

RUN apk update && apk add --no-cache bash mysql-client git

WORKDIR /app
COPY backup.sh /app/backup.sh
RUN chmod +x /app/backup.sh

CMD ["/app/backup.sh"]
