FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Crear directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    gettext \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivo de dependencias
COPY requirements.txt /app/

# Instalar dependencias Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copiar TODO el proyecto
COPY . /app/

# Moverse al backend donde está manage.py
WORKDIR /app/backend

# Exponer el puerto de Gunicorn
EXPOSE 8000

# Comando para ejecutar Django con Gunicorn
CMD ["gunicorn", "AutoParts.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
