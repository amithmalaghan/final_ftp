#!/bin/sh
if [ -n "$DB_IP" -a -n "$DB_NAME" -a -n "$DB_USER" -a -n "$DB_PASSWD" ]; then
    echo  " SQLConnectInfo $DB_NAME@$DB_IP $DB_USER $DB_PASSWD" >> etc/sql.conf
fi

exec "$@"