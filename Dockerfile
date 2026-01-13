FROM python:3.11-slim-bookworm
# force rebuild bookworm + build deps

WORKDIR /app

RUN apt-get update && apt-get install -y \
    ffmpeg \
    aria2 \
    curl \
    coreutils \
    ca-certificates \
    gcc \
    g++ \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install latest yt-dlp binary
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /usr/local/bin/yt-dlp && chmod +x /usr/local/bin/yt-dlp

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "bot.py"]
