# SLO tools testing 

```
git clone git@github.com:prometheus-operator/kube-prometheus.git
git clone git@github.com:pyrra-dev/pyrra.git
go install sigs.k8s.io/kind@v0.14.0 && kind create cluster
cd kube-prometheus
kubectl apply --server-side -f manifests/setup
kubectl apply -f manifests/
cd ../pyrra
kubectl apply -f ./config/crd/bases/pyrra.dev_servicelevelobjectives.yaml
kubectl apply -f ./config/rbac/role.yaml
kubectl apply -f ./config/api.yaml
kubectl apply -f ./config/kubernetes.yaml
kubectl apply -f ./examples/kubernetes/slos/

# remove pyrra 
kubectl delete -f ./config/
kubectl delete -f ./config/rbac
kubectl delete -f ./config/crd/bases

# sloth
# docker or build binary
sloth generate -i sloth-configs/k8s.apiserver.yaml -o sloth-configs/tmp/k8s.apiserver.yaml
# add grafana 14348 dashboard to visualise slo
# for the next cmd to be executed as expected k8s operator must be installed
kubectl apply -f sloth-configs/tmp/k8s.apiserver.yaml

```