FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

RUN apt-get update && apt-get install -y libaio1 unzip curl

RUN mkdir -p /app/oracle_wallet
COPY cwallet.sso /app/oracle_wallet/
COPY ewallet.p12 /app/oracle_wallet/
COPY ewallet.pem /app/oracle_wallet/
COPY keystore.jks /app/oracle_wallet/
COPY sqlnet.ora /app/oracle_wallet/
COPY ojdbc.properties /app/oracle_wallet/
COPY tnsnames.ora /app/oracle_wallet/
COPY truststore.jks /app/oracle_wallet/

EXPOSE 8000

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "bibliotecaapp.wsgi:application", "--bind", "0.0.0.0:8000", "--timeout", "90"]