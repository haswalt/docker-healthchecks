Healthchecks Docker
===================

Docker image to run the [healthchecks](https://github.com/healthchecks/healthchecks) django application

*N.B.* Due to no tagging on the healthchecks repository this will always build with the latest commit

## Building

```
docker build -t haswalt/healthchecks .
```

## Running

```
docker run -p 9090:9090 haswalt/healthchecks
```

The container is no accepting requests on port 9090.

## Configuration

This image is built to take basic configuration from environment variables passed:

```
docker run -p 9090:9090 \
           -e HEALTHCHECKS_DEBUG=False \
           -e HEALTHCHECKS_HOST=localhost \
           -e HEALTHCHECKS_SITE_ROOT="http://localhost:8000" \
           -e HEALTHCHECKS_DB=mysql \
           -e HEALTHCHECKS_DB_HOST=localhost \
           -e HEALTHCHECKS_DB_USER=root \
           -e HEALTHCHECKS_DB_PASSWORD=pa55word\
           -e HEALTHCHECKS_EMAIL_FROM="healthchecks@example.org" \
           -e HEALTHCHECKS_EMAIL_HOST=localhost \
           -e HEALTHCHECKS_EMAIL_PORT=25 \
           -e HEALTHCHECKS_EMAIL_USER="" \
           -e HEALTHCHECKS_EMAIL_PASSWORD="" \
          haswalt/healthchecks
```
