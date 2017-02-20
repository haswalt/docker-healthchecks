#!/bin/sh
set -e

gosu hc uwsgi --master \
    --http-socket :9090 \
    --processes 4 \
    --chdir /src \
    --module hc.wsgi:application \
    --enable-threads \
    --thunder-lock \
    --static-map /static=/src/static-collected
