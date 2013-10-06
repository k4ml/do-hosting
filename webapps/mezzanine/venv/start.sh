#!/bin/bash

exec /home/user1/webapps/mezzanine/venv/bin/gunicorn \
    -b 127.0.0.1:10001 \
    --access-logfile - \
    --error-logfile - \
    myproject.wsgi:application
