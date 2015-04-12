# createdigialspb-docker-postgresql / createdigitalspb/postgresql-9.4:1.0

Based on brilliant postgresql image by PaintedFox! We're keeping it here for making small modifications and for safety
reasons.


## Usage

``` shell
$ mkdir -p /tmp/postgresql
$ docker run -d --name="postgresql" \
             -p 127.0.0.1:5432:5432 \
             -v /tmp/postgresql:/data \
             -e POSTGRESQL_USER="super" \
             -e POSTGRESQL_NAME="database_name" \
             -e POSTGRESQL_PASS="$(pwgen -s -1 16)" \
             createdigialspb/postgresql
```

## TODO

Base this image on our own baseimage
