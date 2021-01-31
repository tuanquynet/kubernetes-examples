# delete deployment
kubectl delete deployment -l app=redis
# delete service
kubectl delete service -l app=redis
# delete deployment
kubectl delete deployment -l app=guestbook
# delete service
kubectl delete service -l app=guestbook