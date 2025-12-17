FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    libaio1t64 \
    curl \
    unzip \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/oracle

RUN curl -L -o instantclient-basic.zip \
    https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linux.x64-21.11.0.0.0dbru.zip \
    && unzip instantclient-basic.zip \
    && rm instantclient-basic.zip

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_11

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "bibliotecaapp.wsgi:application", "--bind", "0.0.0.0:8000"]
