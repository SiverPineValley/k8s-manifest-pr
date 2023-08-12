# Opaque 타입 secret 생성
#kubectl create secret generic sample-secret --from-env-file=db.env
kubectl get secret sample-secret -o json | jq -r .data.username | base64 --decode
kubectl get secret sample-secret -o json | jq -r .data.dbname | base64 --decode

# TLS 타입 secret 생성
#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./tls.key -out ./tls.crt -subj "/CN=sample1.example.com"
#kubectl create secret tls sample-secret-tls --key=tls.key --cert=tls.crt
k get secret sample-secret-tls -o json | jq -r .data

# 도커 레지스트리 인증 정보 시크릿 생성
#kubectl create secret docker-registry sample-registry-auth \
#--docker-server=REGISTRY_SERVER \
#--docker-username=REGISTRY_USER \
#--docker-password=REGISTRY_USER_PASSWORD \
#--docker-email=REGISTRY_USER_EMAIL

kubectl get secret sample-registry-auth -o json | jq -r .data
kubectl get secret sample-registry-auth -o yaml | grep "\.dockerconfigjson" | awk -F ' ' '{print $2}' | base64 --decode

# 기본 인증 타입 secret
#kubectl create secret generic sample-basic-auth --type kubernetes.io/basic-auth --from-literal=username=root --from-literal=password=rootpassword

# SSH 인증 타입 secret
#ssh-keygen -t rsa -b 2048 -f sample-key.key -C "sample"	
#kubectl create secret generic sample-basic-auth-ssh --type kubernetes.io/ssh-auth --from-file=ssh-privatekey=./sample-key.key

# secret 환경변수 Pod 생성
#kubectl run sample-secret-pod --image=busybox:latest --dry-run=client -o yaml > sample-secret-pod.yaml
#vi sample-secret-pod.yaml
#kubectl apply -f sample-secret-pod.yaml
kubectl exec -it sample-secret-pod -- env | grep DB_USERNAME

# secret 볼륨 마운트
k exec -it sample-secret-pod -- cat /mnt/password.txt
