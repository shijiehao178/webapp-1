#!/bin/sh
set -e
PORT=${PORT:-3000}
BIN=""
if command -v sing-box >/dev/null 2>&1; then BIN=$(command -v sing-box); fi
if [ -z "$BIN" ]; then
  if [ ! -x /tmp/sing-box ]; then
    ARCH=$(uname -m)
    case "$ARCH" in
      x86_64) ARCH=amd64 ;;
      aarch64|arm64) ARCH=arm64 ;;
    esac
    TAG=$(curl -fsSL https://api.github.com/repos/SagerNet/sing-box/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p' | head -n1)
    curl -fsSL -o /tmp/sing-box.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v${TAG}/sing-box-${TAG}-linux-${ARCH}.tar.gz"
    tar -xzf /tmp/sing-box.tar.gz -C /tmp
    cp "/tmp/sing-box-${TAG}-linux-${ARCH}/sing-box" /tmp/sing-box
    chmod +x /tmp/sing-box
  fi
  BIN=/tmp/sing-box
fi
sed "s/__PORT__/$PORT/" /app/config.template.json > /tmp/config.json
exec "$BIN" run -c /tmp/config.json
