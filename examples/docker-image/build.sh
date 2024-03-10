#!/bin/bash
docker_path="../../images/docker"
image_name="flask-app"
container_name="${image_name}-container"
tag_name="kasraz/${image_name}"

container_exists = $(docker ps -a -q -f name=$container_name)
docker build -t $image_name $docker_path
docker tag $image_name $tag_name
docker push $tag_name
if [ -n "$container_exists"]; then
    docker rm $image_name-container
fi
docker run --name $container_name -p 5000:5000 -d $tag_name