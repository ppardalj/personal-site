#!/usr/bin/env bash
# Renderiza una plantilla HTML a PNG con Chrome headless. Uso: ./render.sh plantilla.html salida.png ANCHO ALTO
set -euo pipefail
cd "$(dirname "$0")"
google-chrome --headless=new --disable-gpu --hide-scrollbars --allow-file-access-from-files \
  --force-device-scale-factor=1 --window-size="$3,$4" --virtual-time-budget=3000 \
  --screenshot="$(realpath -m "$2")" "file://$PWD/$1" 2>/dev/null
echo "$2"
