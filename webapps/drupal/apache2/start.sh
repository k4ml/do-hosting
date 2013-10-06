#!/bin/bash

apache2 -d /home/user1/webapps/drupal/apache2 -f apache2.conf -e info -DFOREGROUND
