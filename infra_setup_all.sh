cd 01-ekscluster-terraform-manifests && terraform apply -auto-approve \
&& cd ../02-ebs-terraform-manifests && terraform apply -auto-approve \
&& cd ../03-externaldns-terraform-manifests && terraform apply -auto-approve \
&& cd ../04-lbc-terraform-manifests && terraform apply -auto-approve \
&& cd ../05-argocd-terraform-manifests && terraform apply -auto-approve \
&& cd .. \
&& aws eks --region ap-southeast-1 update-kubeconfig --name magiclab396-dev-openim-cluster-1 \
&& kubectl create -n istio-system secret tls myk8s-magiclab396-credential --key=openim.k8s.magiclab396.com.key --cert=openim.k8s.magiclab396.com.crt \
&& kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --d