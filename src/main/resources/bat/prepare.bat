@echo off

set BINDIR=%PLUGIN_INSTALL_DIR%\bin

set PGUSER=postgres
set PGPASSWORD=postgres
set PGPORT=%PLUGIN_PORT%
set PGHOST=127.0.0.1
set PGDATABASE=%PLUGIN_DATABASE_NAME%
set PGDATA=%PLUGIN_DATA_DIR%

%BINDIR%\pg_ctl initdb -o "--auth-host=md5 --auth-local=md5 --encoding=UTF-8 --nosync --username=postgres --pwfile=%PLUGIN_INSTALL_DIR%\password.txt"
if not %errorlevel% == 0 exit 1

echo host all all 0.0.0.0/0 md5 > %PGDATA%\pg_hba.conf
echo host all all ::0/0 md5 >> %PGDATA%\pg_hba.conf

echo "archive_command = 'DEL /Q %p' >> %PGDATA%\postgresql.conf

@echo on
