aws eks describe-cluster \
    --region <region-code> \
    --name <my-cluster> \
    --query "cluster.status"