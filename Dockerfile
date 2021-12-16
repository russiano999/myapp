FROM python:3.8-alpine
# Устанавливает переменную окружения, которая гарантирует, что вывод из python будет 
# отправлен прямо в терминал без предварительной буферизации
ENV PYTHONUNBUFFERED 1
# Устанавливает рабочий каталог контейнера — "app"
WORKDIR /app
# Копирует все файлы из нашего локального проекта в контейнер
ADD . /app
# Запускает команду pip install для всех библиотек, перечисленных в requirements.txt
RUN apk add --no-cache      gcc      libc-dev      linux-headers	python3-dev	python3-venv
# apk add python3-dev build-base linux-headers pcre-dev 
RUN pip install -r requirements.txt

ENTRYPOINT ["uwsgi", "--http", ":8080", "--module", "myapp.wsgi"]
