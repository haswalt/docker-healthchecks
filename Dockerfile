FROM ubuntu:16.04

ENV BUILDDEPS "gcc libxml2-dev python3 python3-dev python3-setuptools python3-pip libpq-dev libxslt-dev git"

# Install deps
RUN apt-get update && apt-get install -y $BUILDDEPS --no-install-recommends \
    && rm -fr /var/lib/apt/lists/*

RUN git clone https://github.com/healthchecks/healthchecks.git /src
WORKDIR /src

RUN pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir uwsgi

RUN apt-get purge -y --auto-remove $BUILDEPS

COPY uwsgi.ini /src
COPY local_settings.py /src/hc

CMD [ "uwsgi", "--ini", "uwsgi.ini" ]
