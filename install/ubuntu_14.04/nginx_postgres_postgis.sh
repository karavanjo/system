#!/usr/bin/env bash

# install postgres
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo apt-key add -
sudo apt-get update
sudo aptitude install postgresql-9.4

# install postgis 2.1
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo aptitude install postgresql-9.4-postgis-2.1

# create db
sudo -s -u postgres

DB_NAME=$1
DB_USER=$2

createuser $DB_USER -P
createdb --owner=$DB_USER --encoding=UNICODE $DB_NAME
createlang plpgsql  $DB_NAME

psql -d $1 -U postgres -c "CREATE EXTENSION postgis;";

psql -d $1 -U postgres -c "GRANT SELECT ON geometry_columns TO $DB_NAME";
psql -d $1 -U postgres -c "GRANT SELECT ON geography_columns TO $DB_NAME";
psql -d $1 -U postgres -c "GRANT SELECT ON spatial_ref_sys TO $DB_NAME";

exit