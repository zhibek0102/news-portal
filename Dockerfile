FROM python:3.10-alpine

# Установка зависимостей для сборки numpy
RUN apk add --no-cache \
    build-base \
    python3-dev \
    openblas-dev \
    freetype-dev \
    libpng-dev \
    musl-dev \
    lapack-dev

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt .

RUN pip install --no-cache --upgrade pip \
 && pip install --no-cache -r requirements.txt \
 && pip install --no-cache gunicorn

COPY . .

RUN python manage.py makemigrations

EXPOSE 8000

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
