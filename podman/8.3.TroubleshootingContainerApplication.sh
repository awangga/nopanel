  104  source /usr/local/etc/ocp4.config
  105  cd ~/DO180-apps
  106  git checkout master
  107  git checkout -b troubleshoot-review
  108  git push -u origin troubleshoot-review
  109  oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
  110  oc new-project ${RHT_OCP4_DEV_USER}-nodejs-app
  111  oc new-app --as-deployment-config --context-dir=nodejs-app https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#troubleshoot-review -i nodejs:12 --name nodejs-dev --build-env npm_config_registry=http://${RHT_OCP4_NEXUS_SERVER}/repository/npm-proxy
  135  oc logs -f bc/nodejs-dev
  136  oc get pods
  137  cd DO180-apps/
  138  cd nodejs-app/
  139  cat package.json
  140  sed -i s/4.20/4.x/ package.json
  141  cat package.json
  142  git commit -am "Fixed Express release"
  143  git push
  144  oc start-build bc/nodejs-dev
  145  oc logs -f bc/nodejs-dev
  146  oc get pods
  147  oc logs -f dc/nodejs-dev
  148  sed -i s/http-error/html-errors/ server.js
  149  cat server.js
  150  oc logs -f dc/nodejs-dev
  151  git commit -am "Fixed module typo"
  152  git push
  153  oc start-build bc/nodejs-dev
  154  oc logs -f bc/nodejs-dev
  155  oc get pods -w
  156  oc expose svc nodejs-dev
  157  oc get route
  158  curl nodejs-dev-awangga-nodejs-app.apps.na45.prod.nextcle.com
  159  oc logs dc/nodejs-dev
  160  sed -i  s/process.environment/process.env/ server.js
  161  git commit -am "Fixed process.env"
  162  git push
  163  oc start-build bc/nodejs-dev
  164  oc logs -f bc/nodejs-dev
  165  oc get pods
  166  curl nodejs-dev-awangga-nodejs-app.apps.na45.prod.nextcle.com
