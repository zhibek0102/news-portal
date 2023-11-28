# Используем базовый образ Python с установленными зависимостями
FROM python:3.9-slim

# Устанавливаем переменную окружения для отключения вывода предупреждений Python
ENV PYTHONDONTWRITEBYTECODE 1
# Устанавливаем переменную окружения для вывода логов в реальном времени
ENV PYTHONUNBUFFERED 1

# Создаем и устанавливаем рабочую директорию в /app
WORKDIR /app

# Копируем файл requirements.txt в контейнер
COPY requirements.txt /app/

# Устанавливаем зависимости
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Копируем все файлы из текущей директории в контейнер
COPY . /app/

# Определяем команду для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

