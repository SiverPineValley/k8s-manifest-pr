# configmap 생성
#kubectl create configmap sample-configmap --from-file=./default.conf --from-literal=thread=16 --from-literal=connection.max=100 --from-literal=connection.min=10 --from-literal=sample.properties=property.1=value-1 --dry-run=client -o yaml > sample-configmap.yaml
kubectl apply -f sample-configmap.yaml 
kubectl get configmap -o wide

# pod 생성
#kubectl run po sample-configmap-pod --image=nginx:1.18 --dry-run=client -o yaml > sample-configmap-pod.yaml
#vi sample-configmap-pod.yaml 
kubectl apply -f sample-configmap-pod.yaml 
kubectl get po sample-configmap-pod -o wide

# 환경설정 확인
kubectl exec -it sample-configmap-pod -- env | grep CPU
kubectl exec -it sample-configmap-pod -- env | grep NODE_NAME
kubectl exec -it sample-configmap-pod -- env | grep HOSTNAME

# storage 적용
#vi sample-configmap-pod.yaml 
#k replace -f sample-configmap-pod.yaml --force
kubectl exec -it sample-configmap-pod -- cat /mnt/nginx.conf
