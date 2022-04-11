FROM python:3.10.4-alpine3.15
COPY . /http-service
WORKDIR /http-service
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN apk add --no-cache --virtual --upgrade git \
    && apk add --upgrade xz \
    && python -m pip install -r requirements.txt \
    && rm -rf /root/.cache/pip
CMD ["python", "main.py"]