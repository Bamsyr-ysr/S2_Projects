#!/bin/bash

set -e

kubectl apply -f ../manifests/test-app.yaml
kubectl apply -f ../manifests/dashboard.yaml
