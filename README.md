# eclipse-container
Ubuntu based docker container image with Eclipse Oxigen installed. It configures Yocto SDK development environment asuming that the SDK is installed on /workdir directory.

Use the following comand to run the image:

docker run -ti --rm \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ~/sdkdir:/workdir \
           eclipse-container
