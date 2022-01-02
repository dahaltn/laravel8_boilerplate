# Laravel8 boilerplate
Laravel 8 boilerplate in docker-compose with Treafik and SSL setup with .github workflow ready

To start the containers in prod environment run 
```
docker network create app-network
docker-compose -f docker-compose-prod.yml up --build -d
```
For local dev 
```
docker network create app-network
docker-compose up --build -d
```
without Treafik and SSL just run (No extrenal network need to create)
```
docker-compose -f docker-compose-no-trafik.yml up --build -d

```

make sure to replace with your mail in the traefik-data/traefik.yml to be able work the SSL

### Tech stacks
* Laravel 8.x
* nginx
* php:8.1-fpm
* Docker
* Docker-compose
* treafik with auto SSL resolvers
* mysql


### License
The Laravel8  boilerplate is open-sourced software licensed under the MIT license.

if anything, happy to help reach me at: dahaltn@gmail.com
Cheers
