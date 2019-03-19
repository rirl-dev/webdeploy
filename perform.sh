#!/usr/bin/env bash
# Scripts to exercise the webdeploy-service in various ways after its  deployed (deploy.sh)
hold() {
#    echo "$1"; sleep 10
     echo "$1>Ready?..."; read X
}

echo "[$0]:: Begin [$*]"

echo "[$0]:: Show information..."
kubectl get deployment webdeploy
kubectl get service webdeploy-service
hold "[Show information]"

#echo "[$0]:: Service URL ..."
#minikube service webdeploy-service --url

echo "[$0]:: Scaling ..."
kubectl scale --replicas=5 deployment/webdeploy
kubectl get deployment webdeploy
kubectl get service webdeploy-service
hold "[Scale to 5]"

kubectl scale --replicas=3 deployment/webdeploy
kubectl get deployment webdeploy
kubectl get service webdeploy-service
hold "[Scale to 3]"

echo "[$0]:: Rollout ..."
kubectl get deployment webdeploy
kubectl describe service    webdeploy-service
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v2
hold "[Rollout v2]"


echo "[$0]:: Post Rollout ..."
kubectl get deployment webdeploy
kubectl describe service webdeploy-service
hold "[Post Rollout]"

echo "[$0]:: Rollback ..."
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v1
hold "[Rollout v1]"


echo "[$0]:: Post Rollback ..."
kubectl get deployment webdeploy
kubectl describe service webdeploy-service
hold "[Post Rollback]"

echo "[$0]:: End   "
exit  0
