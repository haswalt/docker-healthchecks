#!/bin/bash
set -e

while ! python3 manage.py migrate 2>&1; do
    sleep 5
done

python3 manage.py collectstatic --no-input

exec "$@"
