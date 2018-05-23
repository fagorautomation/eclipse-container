#!/bin/sh

echo "### FAGOR AUTOMATION Docker image ###"

# Find out Yocto SDK environment setup file. It asumes
# that the SDK is installed in /workdir directory
ENV_FILE=`ls /workdir/environment-setup-*`


if [ -z "$ENV_FILE" ]
then
	echo "KK"
else
	. $ENV_FILE
fi

# Create an executable file that calls the crosscompiler with needed all parameters
echo "$CC \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcc"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcc"

# The same for the rest tooclhain tools
echo "$CXX \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-g++"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-g++"
echo "$CPP \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcpp"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gcpp"
echo "$AS \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-as"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-as"
echo "$LD \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ld"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ld"
echo "$STRIP \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-strip"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-strip"
echo "$RANLIB \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ranlib"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ranlib"
echo "$OBJCOPY \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objcopy"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objcopy"
echo "$OBJDUMP \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objdump"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-objdump"
echo "$AR \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ar"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-ar"
echo "$NM \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-nm"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-nm"
echo "$GDB \$@" > "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gdb"
chmod +x "$OECORE_NATIVE_SYSROOT/usr/bin/yocto-gdb"


$@
