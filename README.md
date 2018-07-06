# eclipse-container
Ubuntu based docker container image with Eclipse Oxigen installed.
It configures Yocto SDK development environment asuming that the SDK is installed on /workdir directory.
It also can install the SDK passed as argument. The SDK installer must be located in /workdir directory.

Use the following command to run the image:

docker run -ti --rm \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ~/sdkdir:/workdir \
           eclipse-container


Use the following command to install a SDK:

docker run -ti --rm \
           -v ~/sdkdir:/workdir \
           eclipse-container \
	   --sdk yocto-sdk.sh
