#!/bin/bash

CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"
MEDIA="/home/calamar/mi-jardin-digital/public/media"
VAULT="/home/calamar/Documentos/Jardin/jardin"

echo "Procesando imágenes por nota..."

declare -A imagen_asignada

find "$CONTENT" -name "*.md" | while IFS= read -r archivo; do
  nombre_nota=$(basename "$archivo" .md | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
  carpeta_media="$MEDIA/$nombre_nota"

python3 << PYEOF
import re, os, shutil

archivo = '$archivo'
vault = '$VAULT'
media = '$MEDIA'
nombre_nota = '$nombre_nota'
carpeta_destino = '$carpeta_media'
extensiones = r'\.(jpg|jpeg|png|gif|webp|svg|mp3|mp4|wav|ogg)'

with open(archivo, 'r') as f:
    contenido = f.read()

patron = re.compile(
    r'!\[\[([^\]|]+' + extensiones + r')(?:\|\d+)?\]\]',
    re.IGNORECASE
)

def buscar_imagen(nombre):
    nombre_norm = nombre.replace(' ', '_')
    for root, dirs, files in os.walk(vault):
        for f in files:
            if f.replace(' ', '_') == nombre_norm:
                return os.path.join(root, f)
    return None

def procesar(m):
    nombre_original = m.group(1)
    nombre_limpio = nombre_original.replace(' ', '_').lower()

    fuente = buscar_imagen(nombre_original)
    if not fuente:
        return m.group(0)

    archivo_asignado = os.path.join(media, '_asignaciones', nombre_limpio)
    os.makedirs(os.path.join(media, '_asignaciones'), exist_ok=True)

    if os.path.exists(archivo_asignado):
        with open(archivo_asignado, 'r') as f:
            carpeta_existente = f.read().strip()
        return '![' + nombre_limpio + '](/media/' + carpeta_existente + '/' + nombre_limpio + ')'

    os.makedirs(carpeta_destino, exist_ok=True)
    shutil.copy2(fuente, os.path.join(carpeta_destino, nombre_limpio))

    with open(archivo_asignado, 'w') as f:
        f.write(nombre_nota)

    return '![' + nombre_limpio + '](/media/' + nombre_nota + '/' + nombre_limpio + ')'

contenido = patron.sub(procesar, contenido)

patron_texto = re.compile(
    r'^([A-Za-z0-9_\- ]+' + extensiones + r')$',
    re.IGNORECASE | re.MULTILINE
)

def procesar_texto(m):
    nombre_original = m.group(0)
    nombre_limpio = nombre_original.replace(' ', '_').lower()

    archivo_asignado = os.path.join(media, '_asignaciones', nombre_limpio)

    if os.path.exists(archivo_asignado):
        with open(archivo_asignado, 'r') as f:
            carpeta_existente = f.read().strip()
        return '![' + nombre_limpio + '](/media/' + carpeta_existente + '/' + nombre_limpio + ')'

    fuente = buscar_imagen(nombre_original)
    if fuente:
        os.makedirs(carpeta_destino, exist_ok=True)
        shutil.copy2(fuente, os.path.join(carpeta_destino, nombre_limpio))
        with open(archivo_asignado, 'w') as f:
            f.write(nombre_nota)
        return '![' + nombre_limpio + '](/media/' + nombre_nota + '/' + nombre_limpio + ')'

    return '![' + nombre_limpio + '](/media/' + nombre_limpio + ')'

contenido = patron_texto.sub(procesar_texto, contenido)

with open(archivo, 'w') as f:
    f.write(contenido)

print(f'Procesada: {archivo}')
PYEOF
done

echo "Imágenes convertidas y organizadas por nota."
