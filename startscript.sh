#!/bin/bash


module load singularity

if [ ! -f mysql.simg ]; then
    singularity pull --name mysql.simg shub://ISU-HPC/mysql
    echo ''
fi

DATADIR=$1
SOCKETDIR=$2

: "${DATADIR:?Must supply the path to the mysql data directory as the first argument to this script}"
: "${SOCKETDIR:?Must supply the path to the mysql socket directory as the second argument to this script}"

echo "Using \"$DATADIR\" as writable mysql database directory"
echo "Will create mysql communication socket in \"$SOCKETDIR\""
echo
echo "If these directories do not exist they will be created. Otherwise the contents of existing directories will be used."

case $DATADIR in
    /*) DATADIR_PATH="$DATADIR" ;;
    *) DATADIR_PATH="$PWD/$DATADIR" ;; 
esac

case $SOCKETDIR in
    /*) SOCKETDIR_PATH="$SOCKETDIR" ;;
    *) SOCKETDIR_PATH="$PWD/$SOCKETDIR" ;; 
esac

mkdir -p $DATADIR_PATH
mkdir -p $SOCKETDIR_PATH

echo "Use the following string to connect to the database if using Perl DBI."
echo "Substitute the database name that you wish to use for the placeholder <DBNAME>."
echo "Provide the password supplied in the ~/.mysqlrootpw file for the placeholder <PASSWORD>."
echo
echo "dbConnectString=DBI:mysql:database=<DBNAME>;mysql_socket=$SOCKETDIR_PATH/mysqld.sock;user=root;password=<PASSWORD>"
echo


singularity instance.start --bind ${DATADIR_PATH}:/var/lib/mysql --bind ${SOCKETDIR_PATH}:/run/mysqld ./mysql.simg mysql 
singularity run instance://mysql 


