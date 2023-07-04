#!/bin/bash
# from docker host, place in ${INVOL}/docker/db/backup-script.sh & sudo chmod +x ${INVOL}/docker/db/backup-script.sh
# create folder ${INVOL}/docker/db/backups
# add to ${INVOL}/docker/db/crontabs/root: 0     0       *       *       *       /bin/bash /config/backup-script.sh


#FREQUENTY=`basename "$0"`
FREQUENTY="daily"
TIMESTAMP=$(date +"%Y-%m-%d")

case $FREQUENTY in

  daily)
    DAYS=6
    ;;

  weekly)
    DAYS=30
    find /config/backups -type f -name $TIMESTAMP-daily.sql.gz -delete
    ;;

  monthly)
    DAYS=122
    find /config/backups -type f -name $TIMESTAMP-weekly.sql.gz -delete
    ;;
esac

mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip > /config/backups/$TIMESTAMP-$FREQUENTY.sql.gz

# Remove old backups
find /config/backups -mtime +${DAYS} -type f -name *-$FREQUENTY.sql.gz -delete

exit 0;
