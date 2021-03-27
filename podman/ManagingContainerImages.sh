# look registries conf
cat /etc/containers/registries.conf | grep "registries ="

#sudo podman search [OPTIONS] <term>
sudo podman search nginx
curl -Ls https://quay.io/v2/_catalog?n=3
curl -Ls https://registry.gitlab.com/v2/_catalog?n=3
curl -Ls https://registry.redhat.io/v2/_catalog?n=3

sudo podman login -u username -p password registry.access.redhat.com
curl -u username:password -Ls "https://sso.redhat.com/auth/realms/rhcc/protocol/redhat-docker-v2/auth?service=docker-registry"
curl -H "Authorization: Bearer eyJh...mgL4" \
-Ls https://registry.redhat.io/v2/rhscl/mysql-57-rhel7/tags/list | python -mjson.tool
# pulling image
sudo podman pull quay.io/bitnami/nginx
sudo podman images
sudo podman pull rhscl/mysql-57-rhel7:5.7
#run image
sudo podman run rhscl/mysql-57-rhel7:5.7
