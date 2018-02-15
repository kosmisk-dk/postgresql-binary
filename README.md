# Binary Package of PostgreSQL - for dk.kosmisk:postgresql-maven-plugin

This is the artifact for [https://github.com/kosmisk-dk/postgresql-maven-plugin](dk.kosmisk:postgresql-maven-plugin).
It contains a PostgreSQL binary and a few scripts needed by by the plugin

## Content
The package is build by unpacking architecture dependent distribution files from
postgresql.org's download page:
[https://www.enterprisedb.com/download-postgresql-binaries](https://www.enterprisedb.com/download-postgresql-binaries)/
And selecting only the needed folders, package them together with scripts to:

* **prepare** construct a database with credentials postgres/postgres
* **start** start the database and create the given user/database
* **stop** shutdown the database

The scripts are given environment variables with the configuration of the
database in question.

The variables are:

* **PLUGIN_INSTALL_DIR** the directory containing the `bin` directory of the
unpacked postgresql installation
*  **PLUGIN_PORT** the port the instance is going to listen to
*  **PLUGIN_USER** the name of the user (not `postgres`)
*  **PLUGIN_PASSWORD** the password of the user
*  **PLUGIN_DATABASE_NAME** the name of the database
*  **PLUGIN_DATA_DIR** the location of the database content
*  **PLUGIN_LOG_FILE** the location of the log file

Each of the variables are accompanied by one `*_SQL` which has the same content
as a SQL text ie. `PLUGIN_PASSWORD=I'll change it` gives `PLUGIN_PASSWORD_SQL='I''ll change it'`

Besides from this the `start` script is also given an optional list of sql files
as arguments. These files should be loaded in order.

Specific jobs for each command:

* **prepare**
    * create a database in `${PLUGIN_DATA_DIR}`
    * set up a `archive_command` that simply removes the archive log
* **start**
    * start up the database
    * create a base with name from `${PLUGIN_DATABASE_NAME}`
    * create a super user on said base identified by `${PLUGIN_USER}`/`${PLUGIN_PASSWORD}`
    * load all sql files given on command line into said base as said user
* **stop**
    * shutdown the database
