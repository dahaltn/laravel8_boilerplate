#!/bin/sh

# Check the acme.json and permission to store SSL certificate.
ACME_JSON=traefik-data/acme.json
if [ -f "$ACME_JSON" ]; then
  if [ $(stat -c "%a" "$ACME_JSON") != "600" ]; then
    chmod 600 $ACME_JSON
  fi
else
  touch $ACME_JSON && chmod 600 $ACME_JSON
fi

if [ ! "$(docker ps -q -f name=webserver)" ] || [ ! "$(docker ps -q -f name=db)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=webserver)" ]; then
    # cleanup
    docker rm webserver
  fi

  if [ ! "$(docker network ls -q -f name=app-network)" ]; then
    docker network create app-network
  fi
  # run containers from prod compose file.
  docker-compose -f docker-compose-prod.yml up --build -d
else
  docker exec webserver composer install
  docker exec webserver php artisan migrate
fi
#   DB_NAME=laravel
#   docker exec db /usr/bin/mysqldump -u root --password=newnew laravel > laravel_initial_setup_backup.sql
#   docker exec -i db mysql -u root --password=newnew laravel < laravel_initial_setup_backup.sql

#    docker exec webserver composer install -n
#    docker exec webserver composer id -n
#    docker exec webserver drush cim -y
#    docker exec webserver drush cex -y
