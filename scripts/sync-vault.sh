#!/bin/bash
rsync -av --delete --exclude='.obsidian' /home/calamar/Documentos/Jardin/jardin/ src/content/garden/
echo "Bóveda sincronizada."
