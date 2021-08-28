FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app/
COPY . /app
ENV PYTHONPATH=/app

COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

COPY . ./
CMD streamlit run src/app.py --server.enableCORS false --server.port $PORT