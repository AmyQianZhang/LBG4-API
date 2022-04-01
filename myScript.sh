#!/bin/bash

image=my-image
container=my-container
status=$(docker ps -a | grep ${container})

if [ status==true ]
then
	docker rm -f ${container}
fi

cd ~/LBG4-API

npm i

npm test

docker build -t ${image} .
docker image prune -f

docker run -d -p 5000:5000 --name ${container} ${image}
