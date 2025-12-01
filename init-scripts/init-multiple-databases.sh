# #!/bin/bash
# set -e

# create_db_if_not_exists() {
#   local DB_NAME=$1

#   echo "Checking if $DB_NAME exists..."
#   DB_EXISTS=$(psql -U "$POSTGRES_USER" -d postgres -tc "SELECT 1 FROM pg_database WHERE datname = '${DB_NAME}';" | xargs)

#   if [ "$DB_EXISTS" != "1" ]; then
#     echo "Creating $DB_NAME..."
#     psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
#       CREATE DATABASE $DB_NAME;
#       GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $POSTGRES_USER;
# EOSQL
#   else
#     echo "Database $DB_NAME already exists. Skipping creation."
#   fi
# }

# create_db_if_not_exists dev_quest_db
# # create_db_if_not_exists dev_quest_test_db
