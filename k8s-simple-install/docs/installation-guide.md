
# Guide d'installation Kubernetes

## Prérequis

Avant de commencer, assurez-vous que chaque machine (master et workers) respecte les conditions minimales suivantes :

- **RAM :** Minimum 2 Go par nœud (3~4 Go recommandé pour le master)  
- **CPU :** Minimum 2 vCPU par nœud  
- **Système d'exploitation :** Ubuntu 20.04  
- **Accès SSH :** Connexion SSH/sshpass configurée 
- **Droits root / sudo** sur toutes les machines / **worker1/2 ALL=(ALL) NOPASSWD: ALL** Dans visudo pour chaque machine
- **Réseau :** Communication entre les nœuds sans restriction (ports nécessaires ouverts)  

---

## Étapes de lancement

### 1.Transfert du dossier d'installation sur le noeud master depuis votre machine d'administration

```bash
scp -r k8s-simple-install/ master@ip_noeud_master/home/master/
```

### 2.Connexion SSH au noeud master

```bash
ssh master@ip_noeud_master
```

### 3. Lancement du script d'installation du cluster(master, worker1, worker 2)

```bash
cd ~/k8s-simple-install/scripts/
bash cluster-install.sh
```

## Vérifications

- Vérifier les nœuds :

```bash
kubectl get nodes
```

- Vérifier les pods dans tous les namespaces :

```bash
kubectl get pods --all-namespaces
```

---

## Accès au Dashboard Kubernetes

### Récupération du token d'accès

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

### Accès au Dashboard

Lancer un proxy local :

```bash
kubectl proxy
```

Puis accéder via le navigateur :

```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

Utiliser le token précédemment récupéré pour l’authentification.

---

## Commandes utiles

- Voir les logs d’un pod :

```bash
kubectl logs <pod-name>
```

- Décrire un pod ou un nœud (détails et événements) :

```bash
kubectl describe pod <pod-name>
kubectl describe node <node-name>
```

- Voir les événements du cluster :

```bash
kubectl get events --sort-by='.metadata.creationTimestamp'
```

- Liste des namespaces :

```bash
kubectl get namespaces
```

---

## FAQ

### Comment redémarrer un nœud ?

```bash
sudo reboot
```

Après redémarrage, vérifier le statut du nœud :

```bash
kubectl get nodes
```

### Comment joindre un nouveau nœud au cluster ?

Sur le master, générer un nouveau token si nécessaire :

```bash
kubeadm token create --print-join-command
```

Sur le nœud à ajouter, exécuter la commande join affichée.

### Comment retirer un nœud du cluster ?

Sur le master :

```bash
kubectl drain <node-name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node-name>
```

Sur le nœud à retirer :

```bash
sudo kubeadm reset
sudo systemctl restart kubelet
```
