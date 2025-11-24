FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential gcc gettext libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia todo el repo dentro de /app
COPY . /app/

# Entramos al directorio donde está manage.py
WORKDIR /app/backend

EXPOSE 8000

CMD ["gunicorn", "AutoParts.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
