#!/bin/bash

VAULT="/home/calamar/Documentos/Jardin/jardin"
CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"

echo "Sincronizando notas..."
/usr/bin/rsync -av --delete \
  --exclude='.obsidian' \
  --exclude='multi' \
  --exclude='_attachments' \
  --exclude='*.jpg' --exclude='*.jpeg' --exclude='*.png' \
  --exclude='*.gif' --exclude='*.webp' --exclude='*.svg' \
  --exclude='*.mp3' --exclude='*.mp4' --exclude='*.wav' --exclude='*.ogg' \
  "$VAULT/" "$CONTENT/"

echo "Bóveda sincronizada."
