#!/bin/bash

image=my-image
container=my-container

if docker ps -a | grep ${container} > /dev/null
then
	docker rm -f ${container}
fi

npm i

npm test

docker build -t gcr.io/lbg-210322/${image} .
docker image prune -f

#docker run -d -p 5000:5000 --name ${container} ${image}

gcloud auth activate-service-account --key-file ${SERVICE}
gcloud auth configure-docker

docker push gcr.io/lbg-210322/${image}
