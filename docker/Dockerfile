FROM python:3.6-alpine

RUN apk add --update \
    musl-dev \
    gcc

RUN pip3 install --upgrade \
    twine \
    pylint

ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

WORKDIR /module/
