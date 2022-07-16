#!/usr/bin/env bash
# Scripts to exercise the webdeploy-service in various ways after its  deployed (deploy.sh)

echo "[$0]:: Begin [$*]"

echo "[$0]:: Show information..."
kubectl get deployment webdeploy
kubectl get service webdeploy-service
read
clear

#echo "[$0]:: Service URL ..."
#minikube service webdeploy-service --url

echo "[$0]:: Scaling Up...[5]"
kubectl scale --replicas=5 deployment/webdeploy
kubectl get deployment webdeploy
read
clear

echo "[$0]:: Scaling Down...[3]"
kubectl scale --replicas=3 deployment/webdeploy
kubectl get deployment webdeploy
read
clear

echo "[$0]:: Rollout ...[v2]"
kubectl describe deployment webdeploy
kubectl describe service    webdeploy-service
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v2
read

echo "[$0]:: Post Rollout ..."
kubectl describe deployment webdeploy

echo "[$0]:: Rollback ..."
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v1
read
clear

echo "[$0]:: Post Rollback ..."
kubectl describe deployment webdeploy

echo "[$0]:: End   "
exit  0
