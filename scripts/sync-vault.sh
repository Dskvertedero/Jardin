#!/bin/bash
/usr/bin/rsync -av --delete --exclude='.obsidian' /home/calamar/Documentos/Jardin/jardin/ /home/calamar/mi-jardin-digital/src/content/garden/
echo "Bóveda sincronizada."
