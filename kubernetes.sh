#!/bin/bash

# Aplicar um arquivo YAML em um namespace específico
kubectl apply -f $CAMINHO_DO_ARQUIVO_YAML --namespace=$NAMESPACE

# Descrever um pod específico
kubectl describe pod $POD_NOME

# Descrever um serviço específico
kubectl describe service $SERVICO_NOME

# Executar um comando dentro de um pod
kubectl exec -it $POD_NOME -- /bin/bash

# Obter logs de um pod específico
kubectl logs $POD_NOME

# Escalar um deployment para replicar mais pods
kubectl scale deployment $DEPLOYMENT_NOME --replicas=3

# Excluir um recurso do Kubernetes
kubectl delete pod $POD_NOME

# Excluir todos os pods de um deployment
kubectl delete pods --selector=app=$DEPLOYMENT_NOME

# Excluir todos os ...
kubectl delete storageclass --all
kubectl delete statefulset --all
kubectl delete service --all
kubectl delete configmap --all
kubectl delete deployment --all
kubectl delete pv --all
kubectl delete pvc --all

# Listar todos os ...
kubectl get storageclass
kubectl get statefulset
kubectl get service
kubectl get configmap
kubectl get deployment
kubectl get pv
kubectl get pvc
kubectl get namespaces
kubectl get pods

