#!/bin/sh
MAX_WAIT=15
DB_HOST=db
DB_PORT=3306

echo "Waiting for MySQL to be ready..."
i=0
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
  i=$((i + 1))
  if [ $i -ge $MAX_WAIT ]; then
    echo "MySQL was not ready within the given time limit. Exiting."
    exit 1
  fi
done
echo "MySQL is ready!"
