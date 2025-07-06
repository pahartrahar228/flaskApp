FROM python:3.12-alpine

RUN apk add --no-cache curl git build-base

WORKDIR /app
RUN git clone https://github.com/DogukanUrker/flaskBlog.git

WORKDIR /app/flaskBlog/app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 1283

CMD ["gunicorn", "-b", "0.0.0.0:1283", "app:app"]
