This is practice base on this tutorial https://www.eksworkshop.com/beginner/060_helm/helm_micro/

# follow instruction in script.sh

# create failed deployment
Open values.yaml and modify the image name under nodejs.image to brentley/ecsdemo-nodejs-non-existing. This image does not exist, so this will break our deployment.

```shell
helm upgrade workshop ~/environment/eksdemo
```

### check pods
- `kubectl get pods`

you will see `ErrImagePull` of one pod

### check helm history
- `helm history workshop`

### rollback to first revision
helm rollback workshop 1