#Prepare the lab environment.
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-route

#Create a new PHP application using Source-to-Image from the php-helloworld directory in the Git repository at http://github.com/yourgituser/DO180-apps/
oc new-app --as-deployment-config php:7.3~https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps --context-dir php-helloworld --name php-helloworld

# get detail description
oc get pods -w
oc logs -f bc/php-helloworld
oc logs -f dc/php-helloworld
oc describe svc/php-helloworld

#Expose service, change domain name
oc expose svc/php-helloworld
oc describe route
curl php-helloworld-${RHT_OCP4_DEV_USER}-route.${RHT_OCP4_WILDCARD_DOMAIN}

oc delete route/php-helloworld
oc expose svc/php-helloworld --name=${RHT_OCP4_DEV_USER}-xyz
curl ${RHT_OCP4_DEV_USER}-xyz-${RHT_OCP4_DEV_USER}-route.${RHT_OCP4_WILDCARD_DOMAIN}