#!/bin/bash


bash common-setup.sh

# 10. Initialisation du plan de contrôle (Master)
sudo kubeadm init

# 11. Configuration locale de kubectl pour l’utilisateur courant
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 12. Installation d’un plugin CNI (RESEAU POD)
# Flannel
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/refs/heads/master/Documentation/kube-flannel.yml

# Génère join command
echo "sudo $(kubeadm token create --print-join-command)" > join-command.sh
chmod +wx join-command.sh