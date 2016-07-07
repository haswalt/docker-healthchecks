FROM ubuntu:16.04

# Install deps
RUN buildDeps='gcc libxml2-dev python3-setuptools python3-pip libpq-dev libxslt1-dev git libpcre3-dev' \
    && set -x && apt-get -qq update \
    && apt-get install -y python3 python3-dev libxml2 libxslt1.1 $buildDeps --no-install-recommends \
    && git clone https://github.com/healthchecks/healthchecks.git /src \
    && cd /src && pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir uwsgi \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -fr /var/lib/apt/lists/*

WORKDIR /src

COPY local_settings.py /src/hc
COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 9090

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "uwsgi", "--master", "--http-socket", ":9090", "--processes", "4", "--chdir", "/src", "--module", "hc.wsgi:application", "--enable-threads", "--thunder-lock", "--check-static", "/src" ]
