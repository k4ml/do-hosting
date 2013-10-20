#!/bin/bash

exec apache2 -d /home/{{ app_account_username }}/webapps/drupal/apache2 -f /home/{{ app_account_username }}/webapps/drupal/apache2/apache2.conf -e info -DFOREGROUND
