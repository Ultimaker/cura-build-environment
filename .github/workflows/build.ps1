$gitRef = Split-Path -Path $env:GIT_REF -Leaf
$tag = "win1809-$gitRef"
$extraTag = ""
if ($gitRef -eq "master") {
  $extraTag = $env:DOCKER_IMAGE_LATEST_TAG
}

$imageTag1 = "$env:DOCKER_IMAGE_NAME" + ":" + "$tag"
docker build -t $imageTag1 -f docker/windows/Dockerfile.vs2015 .
if ($extraTag) {
  docker tag $imageTag1 $extraTag
}

$ErrorActionPreference = "Continue"
docker login -u $env:DOCKER_USER -p $env:DOCKER_PASSWORD $env:DOCKER_IO
docker push "$imageTag1"
if ($extraTag) {
  docker push "$extraTag"
}
docker logout
