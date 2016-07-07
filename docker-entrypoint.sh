#!/bin/bash
set -e

while ! ./manage.py migrate 2>&1; do
    sleep 5
done

./manage.py ensuretriggers
./manage.py collectstatic --no-input

exec "$@"
