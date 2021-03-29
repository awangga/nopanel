#Prepare the lab environment.create s2i branch copy from master before
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-s2i


#Create a new PHP application using Source-to-Image from the php-helloworld directory using the s2i branch
oc new-app --as-deployment-config php:7.3 --name=php-helloworld https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#s2i --context-dir php-helloworld

# get detail description
oc get pods
oc logs --all-containers -f php-helloworld-1-build
oc describe dc/php-helloworld

#Expose service, change domain name
oc expose service php-helloworld --name ${RHT_OCP4_DEV_USER}-helloworld
oc get route -o jsonpath='{..spec.host}{"\n"}'
curl -s ${RHT_OCP4_DEV_USER}-helloworld-${RHT_OCP4_DEV_USER}-s2i.${RHT_OCP4_WILDCARD_DOMAIN}

# Do the changes from source code
cd ~/DO180-apps/php-helloworld
vim index.php
git add .
git commit -m 'Changed index page contents.'
git push origin s2i

#Start a new Source-to-Image build process and wait for it to build and deploy, check it.
oc start-build php-helloworld
oc logs php-helloworld-2-build -f
oc get pods -w
curl -s ${RHT_OCP4_DEV_USER}-helloworld-${RHT_OCP4_DEV_USER}-s2i.${RHT_OCP4_WILDCARD_DOMAIN}

