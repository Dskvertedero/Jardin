#!/bin/bash
set -e

cd /home/calamar/mi-jardin-digital

echo "Sincronizando bóveda de Obsidian..."
/bin/bash scripts/sync-vault.sh

echo "Convirtiendo sintaxis de imágenes..."
/bin/bash scripts/convertir-imagenes.sh

echo "Revisando cambios..."
/usr/bin/git add .

if /usr/bin/git diff --cached --quiet; then
  echo "No hay cambios nuevos para publicar."
  exit 0
fi

MENSAJE="${1:-Actualización del jardín digital}"
/usr/bin/git commit -m "$MENSAJE"

echo "Subiendo a GitHub..."
/usr/bin/git push

echo "Listo. Vercel reconstruirá el sitio en 1-2 minutos."
