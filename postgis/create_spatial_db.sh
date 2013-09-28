#!/bin/bash

# need
# sudo -s -u postgres

DB_NAME=$1
DB_USER=$2
PATH_TO_POSTGIS=$3
: ${DB_USER:="postgres"}
: ${PATH_TO_POSTGIS:="/usr/local/pgsql/share/contrib/postgis-2.1"}

createdb --owner=$DB_USER --encoding=UNICODE $1
createlang plpgsql  $1
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/postgis.sql
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/postgis_comments.sql
psql -d $1 -U postgres -f $PATH_TO_POSTGIS/spatial_ref_sys.sql
