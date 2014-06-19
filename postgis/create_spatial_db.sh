#!/bin/bash

# need
# sudo -s -u postgres

DB_NAME=$1
DB_USER=$2
PATH_TO_POSTGIS=$3
# : ${DB_USER:="postgres"}
: ${PATH_TO_POSTGIS:="/usr/local/pgsql/share/contrib/postgis-2.1"}

# create user --login --pwprompt
createuser $DB_USER -P
createdb --owner=$DB_USER --encoding=UNICODE $DB_NAME
createlang plpgsql  $DB_NAME
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/postgis.sql
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/postgis_comments.sql
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/spatial_ref_sys.sql

psql -d $1 -U postgres -c "GRANT SELECT ON geometry_columns TO $DB_NAME";
psql -d $1 -U postgres -c "GRANT SELECT ON geography_columns TO $DB_NAME";
psql -d $1 -U postgres -c "GRANT SELECT ON spatial_ref_sys TO $DB_NAME";
