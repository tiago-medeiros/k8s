#!/bin/bash

# Check kind command
if ! type kind > /dev/null 2>&1
then
    echo "kind not found"
    exit 1
fi

# Start the cluster
kind create cluster --config=conf.yaml

# Deploy NGINX ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Deploy prometheus stack
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install -n monitoring prometheus prometheus-community/kube-prometheus-stack
