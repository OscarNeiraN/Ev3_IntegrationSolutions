#!/bin/sh

set -e

# Cambiar al directorio donde está manage.py
cd /app/backend

echo "Aplicando migraciones..."
python manage.py migrate --noinput

echo "Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

echo "Iniciando servidor (ejecutando el CMD de la imagen)..."

# Ejecutar el comando pasado a la imagen (por ejemplo gunicorn)
exec "$@"
