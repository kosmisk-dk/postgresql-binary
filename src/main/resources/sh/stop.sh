#!/bin/sh

bindir="$PLUGIN_INSTALL_DIR/bin"

export PGUSER="postgres"
export PGPASSWORD="postgres"
export PGPORT="$PLUGIN_PORT"
export PGHOST="127.0.0.1"
export PGDATABASE="postgres"
export PGDATA="$PLUGIN_DATA_DIR"

"$bindir"/pg_ctl stop -m fast
