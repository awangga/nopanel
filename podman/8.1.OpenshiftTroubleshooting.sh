# openshift login and create new project
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-nodejs

# make change
cd ~/DO180-apps
git checkout -b troubleshoot-s2i
git push -u origin troubleshoot-s2i

#openshift new app
oc new-app --as-deployment-config \
--context-dir=nodejs-helloworld \
https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#troubleshoot-s2i \
-i nodejs:12 --name nodejs-hello --build-env \
npm_config_registry=http://${RHT_OCP4_NEXUS_SERVER}/repository/npm-proxy



oc get pods -w
oc logs bc/nodejs-hello
