#!/bin/sh

bindir="$PLUGIN_INSTALL_DIR/bin"

export PGUSER="postgres"
export PGPASSWORD="postgres"
export PGPORT="$PLUGIN_PORT"
export PGHOST="127.0.0.1"
export PGDATABASE="$PLUGIN_DATABASE_NAME"
export PGDATA="$PLUGIN_DATA_DIR"

"$bindir"/pg_ctl initdb  -o "--auth-host=md5 --auth-local=md5 --nosync --username=postgres --pwfile=$PLUGIN_INSTALL_DIR/password.txt"

rm -f $PLUGIN_DATA_DIR/pg_hba.conf
echo 'host all all 0.0.0.0/0 md5' >> $PLUGIN_DATA_DIR/pg_hba.conf
echo 'host all all ::0/0 md5' >> $PLUGIN_DATA_DIR/pg_hba.conf

echo "archive_command = 'rm -f %p'" >> $PLUGIN_DATA_DIR/postgresql.conf
