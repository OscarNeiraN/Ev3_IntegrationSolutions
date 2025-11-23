FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential gcc gettext libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias Python
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r /app/requirements.txt

# Copiar todo el proyecto
COPY . /app

EXPOSE 8000

CMD ["gunicorn", "backend.AutoParts.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
