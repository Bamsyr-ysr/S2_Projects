#!/bin/bash

set -e

# Execute le script d'installation du plan de contrôle (Master) pour Kubernetes
wget https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml -O ../manifests/dashboard.yaml
bash install-master.sh

# Copie du dossier d'installation sur les  workers
# Mot de passe SSH pour les utilisateurs worker1 et worker2 --WARyR4b#oJap--
#Changer  les adresses IP des workers si besoin
sshpass -p "WARyR4b#oJap" scp -o StrictHostKeyChecking=no -r ~/k8s-simple-install/ worker1@192.168.100.135:/home/worker1/

sshpass -p "WARyR4b#oJap" scp -o StrictHostKeyChecking=no -r ~/k8s-simple-install/ worker2@192.168.100.136:/home/worker2/

# Connection ssh worker1
sshpass -p "WARyR4b#oJap" ssh -o StrictHostKeyChecking=no worker1@192.168.100.135 \
"cd ~/k8s-simple-install/scripts && bash install-worker.sh"
 
# Connection ssh worker2
sshpass -p "WARyR4b#oJap" ssh -o StrictHostKeyChecking=no worker2@192.168.100.136 \
"cd ~/k8s-simple-install/scripts && bash install-worker.sh"

#cd ~/k8s-simple-install/scripts/
bash deploy-test-app.sh

# Affichage des noeuds
kubectl get nodes
# Affichage des pods
kubectl get pods
# Affichage des services
kubectl get svc
