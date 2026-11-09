# Деплой DealWatch на Render

Render поддерживает Docker и имеет бесплатный tier (~750 часов/месяц).

## Шаг 1: Создайте аккаунт
Зайдите на https://render.com и войдите через GitHub

## Шаг 2: Добавьте Dockerfile

Создайте файл `Dockerfile` в корне репозитория:

```dockerfile
FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    chromium \
    chromium-sandbox \
    fonts-liberation \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install -r requirements.txt

# Указываем путь к Chromium
ENV CHROME_BIN=/usr/bin/chromium
ENV DEALWATCH_CHROME=/usr/bin/chromium

CMD ["python", "dealwatch.py"]
```

## Шаг 3: Подключите на Render

1. Нажмите **New** → **Web Service**
2. Подключите репозиторий `dealwatch`
3. Выберите **Docker** как builder
4. Добавьте переменные окружения:
   - `BOT_TOKEN` — токен бота
   - `BOT_CHAT_IDS` — chat_id получателей

## Проблема

Chromium может блокировать некоторые сайты (WB, Ozon). 
Если будут ошибки CAPTCHA — рассмотрите вариант локального запуска.
