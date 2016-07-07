FROM ubuntu:16.04

ENV BUILDDEPS "gcc libxml2-dev python3 python3-dev python3-setuptools python3-pip libpq-dev libxslt-dev git libpcre3 libpcre3-dev"

# Install deps
RUN apt-get update && apt-get install -y $BUILDDEPS --no-install-recommends \
    && rm -fr /var/lib/apt/lists/*

RUN git clone https://github.com/healthchecks/healthchecks.git /src
WORKDIR /src

RUN pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir uwsgi

RUN apt-get purge -y --auto-remove $BUILDEPS

COPY local_settings.py /src/hc

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 9090

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "uwsgi", "--master", "--http-socket", ":9090", "--processes", "4", "--chdir", "/src", "--module", "hc.wsgi:application", "--enable-threads", "--thunder-lock", "--check-static", "/src" ]
