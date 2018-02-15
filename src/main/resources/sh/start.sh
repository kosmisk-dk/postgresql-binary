#!/bin/sh

bindir="$PLUGIN_INSTALL_DIR/bin"

export PGUSER="postgres"
export PGPASSWORD="postgres"
export PGPORT="$PLUGIN_PORT"
export PGHOST="127.0.0.1"
export PGDATABASE="postgres"
export PGDATA="$PLUGIN_DATA_DIR"

"$bindir"/pg_ctl -w start -l "$PLUGIN_LOG_FILE" -o "-F -i -k ''"

"$bindir"/psql postgres -c "CREATE DATABASE $PLUGIN_DATABASE_NAME;"
"$bindir"/psql postgres -c "CREATE ROLE $PLUGIN_USER WITH PASSWORD $PLUGIN_PASSWORD_SQL LOGIN SUPERUSER;"
"$bindir"/psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE $PLUGIN_DATABASE_NAME TO $PLUGIN_USER;"

export PGUSER="$PLUGIN_USER"
export PGPASSWORD="$PLUGIN_PASSWORD"
export PGDATABASE="$PLUGIN_DATABASE_NAME"

for script in "$@"; do
    echo "Loading: $script" >&2
    "$bindir"/psql < "$script"
done
