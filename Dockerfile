FROM ubuntu:16.04

# Install deps
RUN buildDeps='gcc libxml2-dev python3-setuptools python3-pip libpq-dev libxslt1-dev git libpcre3-dev libmysqlclient-dev' \
    && set -x && apt-get -qq update \
    && apt-get install -y python3 python3-dev libxml2 libxslt1.1 libpq libmysqlclient $buildDeps --no-install-recommends \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && git clone https://github.com/healthchecks/healthchecks.git /src \
    && cd /src && pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir uwsgi mysqlclient psycopg2 pyscopg \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -fr /var/lib/apt/lists/*

WORKDIR /src

COPY local_settings.py /src/hc
COPY docker-entrypoint.sh /entrypoint.sh
COPY start.sh /start.sh
RUN rm -fr /src/.git

EXPOSE 9090

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/start.sh" ]
