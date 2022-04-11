FROM python:3.10.4-alpine3.15
COPY . /http-service
WORKDIR /http-service
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN apk add --no-cache --virtual --upgrade git \
    && apk add --upgrade xz \
    && python -m pip install -r requirements.txt \
    && rm -rf /root/.cache/pip
EXPOSE 8080
CMD ["uvicorn", "app.api:app", "--host", "0.0.0.0", "--port", "8080"]