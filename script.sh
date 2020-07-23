#!/bin/bash
docker_space_before(){
CURRENTSPACE=`docker system df`
echo "Current Docker Space:"
echo $CURRENTSPACE
}
docker_find (){
echo "#####################################################################"
echo "Finding images"
echo "#####################################################################"
REMOVEIMAGES=`docker images | grep " [days|months|weeks]* ago" | awk '{print $3}'`

echo "Listing of images on this Worker node"
echo $REMOVEIMAGES

}

docker_cleanup(){
echo "#####################################################################" 
echo "Cleaning images" 
echo "#####################################################################"
yes | docker image prune -a 
}

docker_space_after(){
CURRENTSPACE=`docker system df`
echo "Current Docker Space, after clean up:" 
echo $CURRENTSPACE 
}
docker_space_before
docker_find
docker_cleanup
docker_space_after
