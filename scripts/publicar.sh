#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Sincronizando bóveda de Obsidian..."
./scripts/sync-vault.sh

echo "Revisando cambios..."
git add .

if git diff --cached --quiet; then
  echo "No hay cambios nuevos para publicar."
  exit 0
fi

MENSAJE="${1:-Actualización del jardín digital}"
git commit -m "$MENSAJE"

echo "Subiendo a GitHub..."
git push

echo "Listo. Vercel reconstruirá el sitio en 1-2 minutos."
