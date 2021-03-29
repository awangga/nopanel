#Prepare the lab environment.
source /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-mysql-openshift

#Create a new application from the rhscl/mysql-57-rhel7 container image using the oc new-app command.
oc new-app --as-deployment-config --docker-image=registry.access.redhat.com/rhscl/mysql-57-rhel7:latest --name=mysql-openshift -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=testdb -e MYSQL_ROOT_PASSWORD=r00tpa55

# get detail description
oc status
oc get pods -o=wide
oc describe pod mysql-openshift-1-glqrp
oc get svc
oc describe service mysql-openshift
oc describe dc mysql-openshift

#Expose the service creating a route with a default name and a fully qualified domain name (FQDN):
oc expose service mysql-openshift
oc get routes

#configure port forwarding between workstation and the database pod running on OpenShift using port 3306.
oc port-forward mysql-openshift-1-glqrp 3306:3306
#run in foreground, in the new tab:
mysql -uuser1 -pmypa55 --protocol tcp -h localhost
#show databases;

#Delete the project to remove all the resources within the project:
oc delete project ${RHT_OCP4_DEV_USER}-mysql-openshift