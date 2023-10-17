#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 [create_new|start]"
  exit 1
fi

SQL_CONTAINER_NAME="ytubeshare_dev"
SQL_PORT="3306"
SQL_ROOT_PASSWORD="my-secret-pw"
SQL_IMAGE="mysql:5.7"

DATA_DIR=$(pwd)/mysql_data

ACTION="$1"

is_sql_container_running() {
  docker ps --format '{{.Names}}' | grep -q "^$SQL_CONTAINER_NAME$"
}

create_sql_container() {
  docker run -d -p $SQL_PORT:3306 \
    --platform linux/x86_64 \
    --name $SQL_CONTAINER_NAME \
    -v $DATA_DIR:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=$SQL_ROOT_PASSWORD \
    $SQL_IMAGE
}

create_database_if_not_exists() {
  docker exec -i $SQL_CONTAINER_NAME mysql -uroot -p$SQL_ROOT_PASSWORD -e 'create database '
}

start_sql_container() {
  if is_sql_container_running; then
    docker start $SQL_CONTAINER_NAME
    echo "SQL container started."
  else
    echo "SQL container does not exist. Use './setup_db_local.sh create_new' to create a new container."
  fi

  if ! check_database_existence; then
    echo "Database ytubeshare_dev does not exist. Creating the database..."
    create_database_if_not_exists
    echo "Database ytubeshare_dev is ready."
  fi
}

case "$ACTION" in
  "create_new")
    if is_sql_container_running; then
      echo "SQL container already exists. Use './setup_db_local.sh start' to start the existing container."
    else
      echo "Creating a new SQL container..."
      create_sql_container
      echo "SQL container created and started."
    fi
    ;;
  "start")
    start_sql_container
    ;;
  *)
    echo "Invalid action. Usage: $0 [create_new|start]"
    exit 1
    ;;
esac
