@echo off

set BINDIR=%PLUGIN_INSTALL_DIR%\bin

set PGUSER=postgres
set PGPASSWORD=postgres
set PGPORT=%PLUGIN_PORT%
set PGHOST=127.0.0.1
set PGDATABASE=%PLUGIN_DATABASE_NAME%
set PGDATA=%PLUGIN_DATA_DIR%

%BINDIR%\pg_ctl stop -m fast

@echo on
