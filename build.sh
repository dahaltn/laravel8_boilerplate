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

# environment="USER INPUT"
echo "Choose Environment from the list below"
echo "1) dev"
echo "2) prod"
echo "3) non-traefik"

read -p "Choose Environment: " environment

if [ ! "$(docker ps -q -f name=webserver)" ] || [ ! "$(docker ps -q -f name=db)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=webserver)" ]; then
    # cleanup
    docker rm webserver
  fi

  if [ ! "$(docker network ls -q -f name=app-network)" ]
   then
         docker network create app-network
  fi

    if [ "$environment" = "dev" ]
     then
      docker-compose up --build -d
      elif ["$environment" = "prod"]
      then
          docker-compose -f docker-compose-prod.yml up --build -d
      else
          docker-compose -f docker-compose-non-traefik.yml up --build -d
    fi
  fi
  # run containers from prod compose file.
#else
#  docker exec webserver composer install
#  docker exec webserver php artisan migrate
#fi
#   DB_NAME=laravel
#   docker exec db /usr/bin/mysqldump -u root --password=newnew laravel > laravel_initial_setup_backup.sql
#   docker exec -i db mysql -u root --password=newnew laravel < laravel_initial_setup_backup.sql

#    docker exec webserver composer install -n
#    docker exec webserver composer id -n
#    docker exec webserver drush cim -y
#    docker exec webserver drush cex -y
