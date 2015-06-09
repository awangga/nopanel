#!/bin/bash

if [ ! "$VIRTUALSERVER_PARENT" ]
then
  if [ "$VIRTUALSERVER_ACTION" == "CREATE_DOMAIN" ]
  then
    if [ ! "$VIRTUALSERVER_CREATED" ]
    then
      mkdir -p /home/chroot/$VIRTUALSERVER_USER/home
    else
      echo "Setting up $VIRTUALSERVER_DOM to chroot'ed environment for sftp"

      usermod -d /home/chroot/$VIRTUALSERVER_USER/home $VIRTUALSERVER_USER
      #ln -s $VIRTUALSERVER_HOME /home/chroot/$VIRTUALSERVER_USER

      echo " .. done"
    fi
  elif [ "$VIRTUALSERVER_ACTION" == "DELETE_DOMAIN" ]
  then
    if [ "$VIRTUALSERVER_CREATED" ]
    then
      echo "Cleaning up $VIRTUALSERVER_DOM's chroot'ed environment"

      rm -rf /home/chroot/$VIRTUALSERVER_USER

      echo " .. done"
    fi
  fi
fi

