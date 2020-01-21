$gitRef = Split-Path -Path $env:GIT_REF -Leaf
$imageTag1 = "$env:DOCKER_IMAGE_NAME" + ":" + "$gitRef"
$imageTag2 = "$env:DOCKER_IMAGE_NAME" + ":" + "$env:DOCKER_IMAGE_TAG"
docker build -t $imageTag1 -t $imageTag2 -f docker/windows/Dockerfile.vs2015 .
$ErrorActionPreference = "Continue"
docker login -u $env:DOCKER_USER -p $env:DOCKER_PASSWORD $env:DOCKER_IO
docker push "$imageTag1"
docker push "$imageTag2"
docker logout
