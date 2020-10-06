# Docker
Docker cloud implementation in digital ocean. Simple and clear commmand. First download ubuntu image from docker hub, 
run the image with name n6. Check if docker process and login to bash. 
```sh
docker pull ubuntu
docker run -d -t --name n6 ubuntu
docker ps
docker exec -it n6 bash
```

if you wan to mapping docker port(8080) to host(80) just add -p option
```sh
docker run -d -t -p 80:8080 --name n6 ubuntu
```

to Stop and start docker and look at docker resources
```sh
docker stop n6
docker start n6
docker stats
```

you may change image to different version using tag lates. or you may use your own image in dockerhub by using username/image:tag format.
```sh
docker container run -d -t ubuntu:lates
```
So you must start deploy your apps on your docker container, and put it on the dockerhub.


## Kubernetes
For automatic deployment you must use k8s with yaml configuration. This benefit for load balance or high availaibility apps.
kubctl is all we need, just download it and place on your system execution path. afterthat download or create yaml file and 
add to your OS env variable this is for accessing the kubernetes:

```sh
export KUBECONFIG=filename.yaml
kubectl get nodes
kubectl cluster-info
```

A pods consisting a container, you must create pod to put your container. Explain the task in yaml file and apply it. 
```sh
kubectl run podname --image=ubuntu:latest --port=80
kubectl get pods
kubectl describe pods
kubectl delete pods podname
#creating newdeployment for multiply HA.
kubectl apply -f newdeployment.yaml
kubectl get deployments
kubectl edit newdeployment
kubectl get pods -o wide
#create yaml service and apply it
kubectl apply -f newservice.yaml
kubectl get services
kubectl describe service servicenew
```
