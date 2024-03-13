#!/bin/bash
# Builds the Docker image and pushes it the docker hub

script_path=$(dirname "$0")
docker_path="$script_path/docker-image"
image_name="flask-app"
tag_name="kasraz/${image_name}"

docker build -t $image_name $docker_path
docker login
docker tag $image_name $tag_name
docker push $tag_name