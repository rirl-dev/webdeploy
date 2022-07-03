#!/usr/bin/env bash
# Simple deployment wrapper for webdeploy (kubernetes, minikube cluster).
# Assumptions:
#   Docker images have been built and published to Docker hub.
#   Kubernetes cluster is running (minikube) with load balancer support enabled (minikube tunnel)
#   kubectl is installed and available on the path
#
# Creates the deployment and the service using the k8s resources
#

echo "[$0]:: Begin [$*]"
status=0

echo "[$0]:: Creating K8S deployment..."
set -x;  kubectl create --v=9 -f ./k8s/webdeploy-deployment.yaml; status=$?; set +x
if [ $status -ne 0 ] ; then
  echo "[$0]:: FAILED K8S deployment..."
  exit $status
fi

kubectl get deployment webdeploy

echo "[$0]:: Creating K8S service..."
set -x;  kubectl create -f ./k8s/webdeploy-service.yaml; status=$?; set +x
if [ $status -ne 0 ] ; then
  echo "[$0]:: FAILED K8S service..."
  exit $status
fi
kubectl get service webdeploy-service

echo "[$0]:: End   [$status]"
exit $status
