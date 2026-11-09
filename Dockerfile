FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2 \
    libxshmfence1 wget curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY *.py certs/ ./

ENV CHROME_BIN=/usr/bin/chromium
ENV DEALWATCH_CHROME=/usr/bin/chromium
ENV PYTHONUNBUFFERED=1

# Создаём пользователя и директорию для Chrome profile
RUN useradd -m appuser && mkdir -p /home/appuser/.cache && chown -R appuser /app
USER appuser

CMD ["python", "dealwatch.py"]
