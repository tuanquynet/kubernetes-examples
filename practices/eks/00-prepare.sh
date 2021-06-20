## Prerequisite
- vpc
- subnet
- aws role

# Create cluster
aws eks create-cluster \
   --region <region-code> \
   --name <my-cluster> \
   --kubernetes-version <1.20> \
   --role-arn <arn:aws:iam::111122223333:role/eks-service-role-AWSServiceRoleForAmazonEKS-EXAMPLEBKZRQR> \
   --resources-vpc-config subnetIds=<subnet-a9189fe2>,<subnet-50432629>,securityGroupIds=<sg-f5c54184>

# Create node-group
eksctl create nodegroup \
  --cluster <my-cluster> \
  --region <us-west-2> \
  --name <my-mng> \
  --node-type <m5.large> \
  --nodes <3> \
  --nodes-min <2> \
  --nodes-max <4> \
  --ssh-access \
  --ssh-public-key <my-key> \
  --managed