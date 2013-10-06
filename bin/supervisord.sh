#!/bin/bash

NAME=supervisord
SUPERVISORD=/usr/bin/supervisord
SUPERVISORCTL=/usr/bin/supervisorctl
PIDFILE=$HOME/var/run/supervisord.pid
OPTS="-c $HOME/etc/supervisord.conf"
PS=$NAME
TRUE=1
FALSE=0

export PATH="${PATH:+$PATH:}/usr/local/bin:/usr/sbin:/sbin:$HOME/bin:$HOME/sbin:"

isRunning(){
    pidof_daemon
    PID=$?

    if [ $PID -gt 0 ]; then
    return 1
    else
        return 0
    fi
}

pidof_daemon() {
    PIDS=`pidof -x $PS` || true

    [ -e $PIDFILE ] && PIDS2=`cat $PIDFILE`

    for i in $PIDS; do
        if [ "$i" = "$PIDS2" ]; then
            return 1
        fi
    done
    return 0
}

start () {
    echo "Starting Supervisor daemon manager..."
    isRunning
    isAlive=$?

    if [ "${isAlive}" -eq $TRUE ]; then
        echo "Supervisor is already running."
    else
        $SUPERVISORD $OPTS || echo "Failed...!"
        echo "OK"
    fi
}

stop () {
    echo "Stopping Supervisor daemon manager..."
    $SUPERVISORCTL $OPTS shutdown ||  echo "Failed...!"
    echo "OK"
}

status () {
    isRunning
    if [ "$?" -eq $FALSE ]; then
        echo 'Supervisor not running'
        exit 0
    fi	
    echo "Showing Supervisor status ..."
    $SUPERVISORCTL $OPTS status ||  echo "Failed...!"
}

case "$1" in
  start)
    start
    ;;

  stop)
    stop
    ;;

  status)
    status
    ;;

  restart|reload|force-reload)
    stop
    start
    ;;
esac

exit 0
