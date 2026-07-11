#!/bin/bash

CONTENT="/home/calamar/mi-jardin-digital/src/content/garden"
MEDIA="/home/calamar/mi-jardin-digital/public/media"
VAULT="/home/calamar/Documentos/Jardin/jardin"

echo "Procesando imágenes por nota..."

find "$CONTENT" -name "*.md" | while IFS= read -r archivo; do

python3 << PYEOF
import re, os, shutil

archivo = '$archivo'
content_base = '$CONTENT'
vault = '$VAULT'
media_base = '$MEDIA'
extensiones = r'\.(jpg|jpeg|png|gif|webp|svg|mp3|mp4|wav|ogg)'

ruta_relativa = os.path.relpath(archivo, content_base)
partes = os.path.splitext(ruta_relativa)[0]
carpeta_nota = partes.replace(' ', '_').lower()
carpeta_destino = os.path.join(media_base, carpeta_nota)

asignaciones_dir = os.path.join(media_base, '_asignaciones')
os.makedirs(asignaciones_dir, exist_ok=True)

with open(archivo, 'r') as f:
    contenido = f.read()

patron = re.compile(
    r'!\[\[([^\]|]+' + extensiones + r')(?:\|(\d+))?\]\]',
    re.IGNORECASE
)

def buscar_imagen(nombre):
    nombre_norm = nombre.replace(' ', '_').lower()
    for root, dirs, files in os.walk(vault):
        for f in files:
            if f.replace(' ', '_').lower() == nombre_norm:
                return os.path.join(root, f)
    return None

def procesar(m):
    nombre_original = m.group(1)
    ancho = m.group(3)
    nombre_limpio = nombre_original.replace(' ', '_').lower()

    asignacion = os.path.join(asignaciones_dir, nombre_limpio)

    if os.path.exists(asignacion):
        with open(asignacion, 'r') as f:
            ruta_existente = f.read().strip()
        ruta = '/media/' + ruta_existente + '/' + nombre_limpio
    else:
        fuente = buscar_imagen(nombre_original)
        if not fuente:
            return m.group(0)
        os.makedirs(carpeta_destino, exist_ok=True)
        shutil.copy2(fuente, os.path.join(carpeta_destino, nombre_limpio))
        with open(asignacion, 'w') as f:
            f.write(carpeta_nota)
        ruta = '/media/' + carpeta_nota + '/' + nombre_limpio

    if ancho:
        return '<img src="' + ruta + '" alt="' + nombre_limpio + '" width="' + ancho + '" loading="lazy">'
    else:
        return '<img src="' + ruta + '" alt="' + nombre_limpio + '" loading="lazy">'

contenido = patron.sub(procesar, contenido)

with open(archivo, 'w') as f:
    f.write(contenido)

print('Procesada: ' + archivo)
PYEOF
done

echo "Imágenes convertidas con tamaño y lazy loading."
