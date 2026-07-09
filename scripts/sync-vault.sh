#!/bin/bash

VAULT="/home/calamar/Documentos/Jardin/jardin"
CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"
MEDIA="/home/calamar/mi-jardin-digital/public/media"

echo "Sincronizando notas..."
/usr/bin/rsync -av --delete \
  --exclude='.obsidian' \
  --exclude='multi' \
  --exclude='*.jpg' --exclude='*.jpeg' --exclude='*.png' \
  --exclude='*.gif' --exclude='*.webp' --exclude='*.svg' \
  --exclude='*.mp3' --exclude='*.mp4' --exclude='*.wav' --exclude='*.ogg' \
  "$VAULT/" "$CONTENT/"

echo "Sincronizando imágenes y media..."
/usr/bin/rsync -av \
  --exclude='.obsidian' \
  --include='*/' \
  --include='*.jpg' --include='*.jpeg' --include='*.png' \
  --include='*.gif' --include='*.webp' --include='*.svg' \
  --include='*.mp3' --include='*.mp4' --include='*.wav' --include='*.ogg' \
  --exclude='*' \
  "$VAULT/" "$MEDIA/"

echo "Bóveda sincronizada."
