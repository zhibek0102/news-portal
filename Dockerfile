FROM python:3.10-alpine

# Установка зависимостей для сборки numpy
RUN apk --no-cache add build-base \
    && apk --no-cache add python3-dev \
    && apk --no-cache add libffi-dev \
    && apk --no-cache add openssl-dev \
    && apk --no-cache add libc-dev \
    && apk --no-cache add py3-numpy@edgecommunity

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

