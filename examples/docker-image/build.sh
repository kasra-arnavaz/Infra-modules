#!/bin/bash
script_dir="$(dirname "$0")"
docker_path="${script_dir}/../../images/docker"
image_name="flask-app"
container_name="${image_name}-container"
tag_name="kasraz/${image_name}"

docker build -t $image_name $docker_path
docker tag $image_name $tag_name
docker push $tag_name
# Remove container if it already exists
if [ $(docker ps -aq -f name=^/${container_name}$) ]; then
    docker stop $container_name
    docker rm $container_name
fi
docker run --name $container_name -p 5000:5000 -d $tag_name