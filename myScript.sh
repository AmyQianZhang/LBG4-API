#!/bin/bash

image=amy-image
container=amy-container

if docker ps -a | grep ${container} > /dev/null
then
	docker rm -f ${container}
fi

npm i

npm test

docker build -t gcr.io/lbg-210322/${image}:${BUILD_ID} .

docker image prune -f

docker push gcr.io/lbg-210322/${image}:${BUILD_ID}



#docker run -d -p 5000:5000 --name ${container} ${image}
