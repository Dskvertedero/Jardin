#!/bin/bash

CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"

echo "Convirtiendo sintaxis de imágenes..."

find "$CONTENT" -name "*.md" | while read archivo; do
  sed -i -E \
    -e 's/!\[\[([^]]+\.(jpg|jpeg|png|gif|webp|svg))\]\]/![\1](\/media\/\1)/gi' \
    "$archivo"
done

echo "Imágenes convertidas."
