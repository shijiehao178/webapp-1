#!/bin/sh
PORT=${PORT:-8080}
sed "s/__PORT__/$PORT/" /app/config.template.json > /app/config.json
exec sing-box run -c /app/config.json
