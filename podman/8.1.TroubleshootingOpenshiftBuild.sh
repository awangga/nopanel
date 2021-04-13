# openshift login and create new project
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-nodejs

#build source

cd ~/DO180-apps
git checkout -b troubleshoot-s2i
git push -u origin troubleshoot-s2i

oc new-app --as-deployment-config \
--context-dir=nodejs-helloworld \
https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#troubleshoot-s2i \
-i nodejs:12 --name nodejs-hello --build-env \
npm_config_registry=http://${RHT_OCP4_NEXUS_SERVER}/repository/npm-proxy
 
oc get pods -w
oc logs bc/nodejs-hello


vi ~/DO180-apps/nodejs-helloworld/package.json

git commit -am "Fixed Express release"
git push

oc start-build bc/nodejs-hello
oc logs -f bc/nodejs-hello
oc get pods
oc logs dc/nodejs-hello

vi ~/DO180-apps/nodejs-helloworld/package.json
git commit -am "Added start up script"
git push

oc start-build bc/nodejs-hello
oc get pods -w
oc logs dc/nodejs-hello

oc expose svc/nodejs-hello
oc get route -o yaml

curl -w "\n" \
> http://nodejs-hello-awangga-nodejs.apps.na45.prod.nextcle.com

