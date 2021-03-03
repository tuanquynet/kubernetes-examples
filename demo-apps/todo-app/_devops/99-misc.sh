# forward port to pod and test it
# kubectl port-forward --namespace todo-app pod_name <local_port>:<container_port>
kubectl port-forward --namespace todo-app pod_name 8080:8080
# test port


curl http://app.todo.local