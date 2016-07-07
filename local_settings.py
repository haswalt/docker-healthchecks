"""
Local settings for the HealthChecks app
"""

import os

DEBUG = os.getenv('HEALTHCHECKS_DEBUG', False)

HOST = os.getenv('HEALTHCHECKS_HOST', "localhost")
SITE_ROOT = os.getenv('HEALTHCHECKS_SITE_ROOT', "http://localhost:8000")
PING_ENDPOINT = SITE_ROOT + "/ping/"

DEFAULT_FROM_EMAIL = os.getenv('HEALTHCHECKS_FROM_EMAIL', "healthchecks@example.org")

if os.environ.get("HEALTHCHECKS_DB") == "postgres":
    DATABASES = {
        'default': {
            'ENGINE':   'django.db.backends.postgresql',
            'NAME':     'hc',
            'USER':     os.getenv('HEALTHCHECKS_DB_USER', "postgres"),
            'PASSWORD': os.getenv('HEALTHCHECKS_DB_PASSWORD', ""),
            'HOST':     os.getenv('HEALTHCHECKS_DB_HOST', "localhost"),
            'TEST': {'CHARSET': 'UTF8'}
        }
    }

if os.environ.get("HEALTHCHECKS_DB") == "mysql":
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'USER':     os.getenv('HEALTHCHECKS_DB_USER', "root"),
            'PASSWORD': os.getenv('HEALTHCHECKS_DB_PASSWORD', ""),
            'NAME':     'hc',
            'HOST': os.getenv('HEALTHCHECKS_DB_HOST', "localhost"),
            'TEST': {'CHARSET': 'UTF8'}
        }
    }

