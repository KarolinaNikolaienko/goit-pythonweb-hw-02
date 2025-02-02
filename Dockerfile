# Docker-команда FROM вказує базовий образ контейнера
# Наш базовий образ - це Linux з попередньо встановленим python-3.10
FROM python:3.12-slim

# Встановимо змінну середовища
ENV APP_HOME /app

# Встановимо робочу директорію всередині контейнера
WORKDIR $APP_HOME

# Скопіюємо файли залежностей poetry
COPY pyproject.toml poetry.lock $APP_HOME/

#Встановимо poetry
RUN pip install poetry

# Встановимо залежності всередині контейнера
RUN poetry config virtualenvs.create false
RUN poetry install --only=main --no-root

# Скопіюємо інші файли в робочу директорію контейнера
COPY . $APP_HOME

# Позначимо порт, де працює застосунок всередині контейнера
EXPOSE 8000

# Запустимо наш застосунок всередині контейнера
ENTRYPOINT ["python", "app/main.py"]

# FROM python:3.12-slim
# ENV APP_HOME /app
# WORKDIR $APP_HOME
# COPY . .
# RUN pip install -r requirements.txt
# EXPOSE 8000
# CMD [ "python", "main.py" ]