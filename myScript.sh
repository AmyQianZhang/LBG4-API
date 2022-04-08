#!/bin/bash

image=amy-image
#container=amy-container

#if docker ps -a | grep ${container} > /dev/null
#then
#	docker rm -f ${container}
#fi

npm i

npm test

docker build -t gcr.io/lbg-210322/${image}:v${BUILD_ID} .

docker image prune -f

docker push gcr.io/lbg-210322/${image}:v${BUILD_ID}

docker tag gcr.io/lbg-210322/${image}:v${BUILD_ID} gcr.io/lbg-210322/${image}:latest

docker push gcr.io/lbg-210322/${image}:latest

kubectl apply -f kubernetes/application.yml

#kubectl rollout restart deployment amy-app-deploy

#sed -e "s,{{VERSION}},${BUILD_ID},g" kubernetes/application.yml | kubectl apply -f -

if ! kubectl get services amy-app-service > /dev/null
then
	kubectl apply -f kubernetes/service.yml
fi
