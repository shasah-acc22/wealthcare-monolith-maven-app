#!/usr/bin/env bash

echo "build Started ...."


echo "build dockerhub Started ...."

#cdir=$(dirname "$0")
#folderPath=$(cd ${cdir}; pwd -P)
#cd "$folderPath"
cd ../
#rootPATH="$(pwd)"
#echo "RootPath value is ............> $rootPATH"

# Docker Image related variables
# Example : docker.io/gandhicloudlab/welathcare-web-ocp-oss:0.0.1
export IMAGE_SUFFIX=ocp-oss:0.0.1
export REGISTRY_USER=$(oc whoami)
export NAMESPACE=wealthcare-monolith-ns
export OPENSHIFT_REGISTRY_NAME=$(oc get route -n openshift-image-registry | awk '{print $2}' | awk 'NR==2')

# Logging to openshift image registry
docker login -u $(oc whoami) -p $(oc whoami -t) ${OPENSHIFT_REGISTRY_NAME}

if [[ -z ${IMAGE_SUFFIX} ]];
then
    IMAGE_SUFFIX=dev:0.0.1
fi
if [[ -z ${REGISTRY_USER} ]];
then
    REGISTRY_USER=mydockeruser
fi

SERVICE_NAME=wealthcare-monolith

#cp ../target/*.jar app.jar
docker build -f config/Dockerfile -t docker.io/${SERVICE_NAME}-${IMAGE_SUFFIX} .
docker tag docker.io/${SERVICE_NAME}-${IMAGE_SUFFIX} ${OPENSHIFT_REGISTRY_NAME}/${NAMESPACE}/${SERVICE_NAME}-${IMAGE_SUFFIX}
docker push ${OPENSHIFT_REGISTRY_NAME}/${NAMESPACE}/${SERVICE_NAME}-${IMAGE_SUFFIX}

echo "build completed ...."
