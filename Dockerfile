FROM eclipse-temurin:25-jre

WORKDIR /mc-server

COPY . $WORKDIR

RUN chmod +x minecraft-server-entrypoint.sh

EXPOSE 8888

ENTRYPOINT ["./minecraft-server-entrypoint.sh"]