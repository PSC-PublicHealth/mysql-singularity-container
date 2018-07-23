#!/bin/bash


module load singularity

if [ ! -f mysql.simg ]; then
    #singularity pull --name mysql.simg shub://ISU-HPC/mysql
    echo ''
fi

DATADIR=$1
SOCKETDIR=$2

: "${DATADIR:?Must supply the path to the mysql data directory as the first argument to this script}"
: "${SOCKETDIR:?Must supply the path to the mysql socket directory as the second argument to this script}"

echo "Using \"$DATADIR\" as writable mysql database directory"
echo "Will create mysql communication socket in \"$SOCKETDIR\""

#singularity instance.start --bind ${PWD}/mysql/var/lib/mysql/:/var/lib/mysql --bind ${PWD}/mysql/run/mysqld:/run/mysqld ./mysql.simg mysql 
#singularity run instance://mysql 


