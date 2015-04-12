#!/bin/bash
# Starts up postgresql within the container.

# Fix perm error on aufs (has to be started here, not in Dockerfile)
sh /etc/my_init.d/00_fix_aufs.sh

# fix stats dirs
mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp
chown postgres:postgres /var/run/postgresql/9.4-main.pg_stat_tmp

# Stop on error
set -e

DATA_DIR=/data

if [[ -e /firstrun ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

wait_for_postgres_and_run_post_start_action() {
  # Wait for postgres to finish starting up first.
  while [[ ! -e /run/postgresql/9.4-main.pid ]] ; do
      inotifywait -q -e create /run/postgresql/ >> /dev/null
  done

  post_start_action
}

pre_start_action

wait_for_postgres_and_run_post_start_action &

# Start PostgreSQL
echo "Starting PostgreSQL..."
setuser postgres /usr/lib/postgresql/9.4/bin/postgres -D /etc/postgresql/9.4/main
