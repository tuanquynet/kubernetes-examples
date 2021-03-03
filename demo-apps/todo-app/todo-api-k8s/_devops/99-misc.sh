# test docker image
docker run --name=todo-api -it -d -p 3001:3001 --env-file ./todo-api/.env mylocal/todo-app-api

# stop and remove container
docker stop todo-api && docker rm todo-api