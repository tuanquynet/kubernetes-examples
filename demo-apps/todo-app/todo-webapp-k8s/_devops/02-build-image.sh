docker build -t mylocal/todo-app-webapp .

# docker run -d mylocal/todo-app-webapp

docker tag mylocal/todo-app-webapp localhost:5000/todo-app-webapp
