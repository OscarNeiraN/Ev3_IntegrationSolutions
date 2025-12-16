FROM python:3.11-slim  #imagen oficial de python 

#variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1 #evita que python cree archivos .pyc
ENV PYTHONUNBUFFERED=1 #python envia logs inmediatamente, evita que se almacenen dentro del contenedor provocando retrasos

WORKDIR /app #establece el directorio de trabajo dentro del contenedor

RUN apt-get update && apt-get install -y build-essential gcc gettext libpq-dev \
    && rm -rf /var/lib/apt/lists/* #instala dependencias del sistema necesarias para algunas librerias de python

COPY requirements.txt /app/requirements.txt #copia el archivo de requerimientos al contenedor
RUN pip install --upgrade pip && pip install -r requirements.txt #actualiza pip e instala las dependencias de python

COPY . /app/ #copia el codigo de la aplicacion al contenedor

WORKDIR /app/backend #cambia el directorio de trabajo al backend

EXPOSE 8000 #expone el puerto 8000 para acceder a la aplicacion

CMD ["gunicorn", "AutoParts.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
# (gunicorn)Es el servidor web de producción (Gunicorn: Green Unicorn) que tomará las 
#peticiones HTTP externas y las pasará eficientemente a tu código Python.

# (AutoParts.wsgi:application) Indica a Gunicorn dónde encontrar el punto de entrada de la aplicación

# (--bind) Especifica la dirección y el puerto donde el servidor Gunicorn debe escuchar las peticiones.

# (0.0.0.0:8000) Significa escuchar en todas las interfaces de red disponibles

#