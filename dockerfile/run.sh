#!/bin/sh

echo "### FAGOR AUTOMATION Eclipse Docker image for developers ###"

setup_yocto_environment()
{
	# Find out Yocto SDK environment setup file. It asumes
	# that the SDK is installed in /workdir directory
	ENV_FILE=`ls /workdir/environment-setup-*`
		
	if [ -z "$ENV_FILE" ]
	then
		echo "SDK environment setup file not found."
		return 0
	else
		echo "Setting up Yocto SDK environment."
		. $ENV_FILE
		export LINUX_DIR="$OECORE_TARGET_SYSROOT/usr/src/kernel"
		return 1
	fi
}


if [ "$1" = "--sdk" ]
then
	# If there is one already installed, remove it first
	if [ -d /workdir/sysroots ]
	then
		echo "### Deleting previusly installed SDK ###"
		rm -fr /workdir/sysroots
	fi
	echo "### Installing SDK in /workdir ###"
	/workdir/$2 -d /workdir -y
	
	setup_yocto_environment

	if [ $? -eq 1 ]
	then
		echo "## External kernel module build from SDK needs a workaround ###"
		cd $LINUX_DIR 
 		make scripts
	fi 
else
	setup_yocto_environment
	
	if [ $? -eq 1 ]
	then
		if [ ! -f $OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcc ]
		then
			echo "Creating yocto- prefix tooclhain."
			# Create an executable file that calls the crosscompiler with needed all parameters
			sudo sh -c "echo '$CC \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcc"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcc"
	
			# The same for the rest tooclhain tools
			sudo sh -c "echo '$CXX \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-g++"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-g++"
			sudo sh -c "echo '$CPP \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcpp"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcpp"
			sudo sh -c "echo '$AS \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-as"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-as"
			sudo sh -c "echo '$LD \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-ld"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ld"
			sudo sh -c "echo '$STRIP \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-strip"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-strip"
			sudo sh -c "echo '$RANLIB \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-ranlib"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ranlib"
			sudo sh -c "echo '$OBJCOPY \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-objcopy"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objcopy"
			sudo sh -c "echo '$OBJDUMP \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-objdump"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objdump"
			sudo sh -c "echo '$AR \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-ar"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ar"
			sudo sh -c "echo '$NM \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-nm"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-nm"
			sudo sh -c "echo '$GDB \$@' > $OECORE_NATIVE_SYSROOT/usr/bin/yocto-gdb"
			sudo chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gdb"
		fi
	fi

	# Pass through parameters
	$@
fi
