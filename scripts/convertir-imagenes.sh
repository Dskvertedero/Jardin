#!/bin/bash

CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"
MEDIA="/home/calamar/mi-jardin-digital/public/media"

echo "Convirtiendo sintaxis de imágenes..."

find "$CONTENT" -name "*.md" | while read archivo; do
  sed -i -E \
    -e 's/!\[\[([^]]+\.(jpg|jpeg|png|gif|webp|svg))\]\]/![\1](\/media\/\1)/gi' \
    "$archivo"
  perl -i -pe 's|(\!\[[^\]]*\]\(/media/)([^)]+)(\))|$1 . ($x=$2) =~ s/ /_/gr . $3|ge' "$archivo"
done

echo "Imágenes convertidas."
