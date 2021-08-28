FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app/
COPY . /app
ENV PYTHONPATH=/app

COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

COPY . ./

#hack to fix the streamlit healthcheck which collides with the Google Cloud Run check https://github.com/streamlit/streamlit/issues/3028
RUN find /usr/local/lib/python3.9/site-packages/streamlit -type f \( -iname \*.py -o -iname \*.js \) -print0 | xargs -0 sed -i 's/healthz/health-check/g'

CMD streamlit run src/app.py --server.enableCORS false --server.port $PORT