#!/bin/bash

CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"
MEDIA="/home/calamar/mi-jardin-digital/public/media"

echo "Renombrando archivos con espacios en media..."
find "$MEDIA" -name "* *" | while IFS= read -r f; do
  nuevo="${f// /_}"
  [ "$f" != "$nuevo" ] && mv "$f" "$nuevo" 2>/dev/null || true
done

echo "Convirtiendo sintaxis de imágenes en notas..."
find "$CONTENT" -name "*.md" | while IFS= read -r archivo; do
python3 << PYEOF
import re

with open('$archivo', 'r') as f:
    contenido = f.read()

extensiones = r'\.(jpg|jpeg|png|gif|webp|svg)'

# Caso 1: ![[nombre.png|tamaño]] o ![[nombre.png]]
def conv_wikilink(m):
    nombre = m.group(1).replace(' ', '_')
    return '![' + nombre + '](/media/' + nombre + ')'

contenido = re.sub(
    r'!\[\[([^\]|]+' + extensiones + r')(?:\|\d+)?\]\]',
    conv_wikilink,
    contenido,
    flags=re.IGNORECASE
)

# Caso 2: texto plano tipo "Pasted_image_20260708214234.png" en su propia línea
def conv_texto_plano(m):
    nombre = m.group(0).replace(' ', '_')
    return '![' + nombre + '](/media/' + nombre + ')'

contenido = re.sub(
    r'^[A-Za-z0-9_\- ]+' + extensiones + r'$',
    conv_texto_plano,
    contenido,
    flags=re.IGNORECASE | re.MULTILINE
)

with open('$archivo', 'w') as f:
    f.write(contenido)
PYEOF
done

echo "Imágenes convertidas."
