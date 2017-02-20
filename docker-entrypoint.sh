#!/bin/bash
set -e

while ! gosu hc ./manage.py migrate 2>&1; do
    sleep 5
done

gosu hc ./manage.py collectstatic --no-input

exec "$@"
