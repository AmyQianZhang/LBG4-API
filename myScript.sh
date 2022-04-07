#!/bin/bash

image=my-image
container=my-container

if docker ps -a | grep ${container} > /dev/null
then
	docker rm -f ${container}
fi

npm i

npm test

docker build -t ${image} .
docker image prune -f

#docker run -d -p 5000:5000 --name ${container} ${image}

docker tag ${image} gcr.io/lbg-210322/${image}

echo "1"
gcloud config set account amy-jenkins@lbg-210322.iam.gserviceaccount.com
echo "2"

docker push gcr.io/lbg-210322/${image}
