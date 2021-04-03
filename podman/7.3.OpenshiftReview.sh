# openshift login and create new project
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-deploy

#build database and push
  745  sudo podman build -t do180-mysql-57-rhel7 .
  746  sudo podman images
  747  sudo podman login quay.io -u awangga
  748  sudo podman tag do180-mysql-57-rhel7 quay.io/awangga/do180-mysql-57-rhel7
  749  sudo podman images
  750  sudo podman push quay.io/awangga/do180-mysql-57-rhel7



  763  sudo podman build -t do180-quote-php .
  764  sudo podman imaged
  765  sudo podman images
  766  sudo podman tag do180-quote-php quay.io/awangga/do180-quote-php
  767  sudo podman images
  768  sudo podman push quay.io/awangga/do180-quote-php

  775  oc create -f quote-php-template.json
  776  oc process quote-php-persistent -p RHT_OCP4_QUAY_USER=${RHT_OCP4_QUAY_USER} | oc create -f -
  777  oc get pods -w
  778  oc expose svc quote-php
  779  oc get route
  780  curl -w "\n" http://quote-php-${RHT_OCP4_DEV_USER}-deploy.${RHT_OCP4_WILDCARD_DOMAIN}
  
 