FROM ghcr.io/sagernet/sing-box:latest
COPY config.template.json /app/config.template.json
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
