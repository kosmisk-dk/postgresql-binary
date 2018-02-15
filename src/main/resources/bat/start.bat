@echo off

set BINDIR=%PLUGIN_INSTALL_DIR%\bin

set PGUSER=postgres
set PGPASSWORD=postgres
set PGPORT=%PLUGIN_PORT%
set PGHOST=127.0.0.1
set PGDATABASE=postgres
set PGDATA=%PLUGIN_DATA_DIR%

%BINDIR%\pg_ctl start -l %PLUGIN_LOG_FILE% -o "-F -p %PGPORT%"
if not %errorlevel% == 0 exit 1

%BINDIR%\psql -c "CREATE DATABASE %PLUGIN_DATABASE_NAME%;"
if not %errorlevel% == 0 exit 1

%BINDIR%\psql -c "CREATE ROLE %PLUGIN_USER% WITH PASSWORD %PLUGIN_PASSWORD_SQL% LOGIN SUPERUSER;"
if not %errorlevel% == 0 exit 1

%BINDIR%\psql -c "GRANT ALL PRIVILEGES ON DATABASE %PLUGIN_DATABASE_NAME% TO %PLUGIN_USER%;"
if not %errorlevel% == 0 exit 1

set PGUSER=%PLUGIN_USER%
set PGPASSWORD=%PLUGIN_PASSWORD%
set PGDATABASE=%PLUGIN_DATABASE_NAME%

:Loop
if "%1" == "" GOTO LoopBreak

%BINDIR%\psql --file="%1"

SHIFT
GOTO Loop
:LoopBreak

@echo on
