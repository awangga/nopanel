# build image and push to registri

cd ~/DO180/labs/multicontainer-openshift/images/mysql
sudo podman build -t do180-mysql-57-rhel7 .

source /usr/local/etc/ocp4.config
sudo podman login quay.io -u ${RHT_OCP4_QUAY_USER}
sudo podman tag do180-mysql-57-rhel7 quay.io/${RHT_OCP4_QUAY_USER}/do180-mysql-57-rhel7
sudo podman push quay.io/${RHT_OCP4_QUAY_USER}/do180-mysql-57-rhel7

cd ../nodejs
sudo podman build -t do180-nodejs .

cd ../../deploy/nodejs
sudo ./build.sh

sudo podman tag do180/todonodejs quay.io/${RHT_OCP4_QUAY_USER}/do180-todonodejs
sudo podman push quay.io/${RHT_OCP4_QUAY_USER}/do180-todonodejs

# openshift
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-template

cd ../../
cat todo-template.json
oc process -f todo-template.json -p RHT_OCP4_QUAY_USER=${RHT_OCP4_QUAY_USER} | oc create -f -
oc get pods -w
oc expose service todoapi
oc status
curl -w "\n" http://todoapi-awangga-template.apps.na45.prod.nextcle.com/todo/api/items/1



