# Pull base image.
FROM fagorautomation/ubuntu-base:v1.01

USER root

# Update OS.
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update

# upgrade 
# RUN apt-get -y upgrade 

# Install basic packages. 
RUN apt-get install -y xz-utils sudo file gcc

# Install Eclipse dependency packages
RUN apt-get install -y openjdk-8-jdk libcanberra-gtk-module

# Download and install Eclipse Oxygen
RUN wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/oxygen/3a/eclipse-cpp-oxygen-3a-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo "Instaling Eclipse" && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

# Install the following Eclipse Plugins
# TFC Target Explorer 
# TFC Remote System Explorer add-in
# TFC C/C++ Debugger
# C/C++ Remote (over TFC/TE ) Run/Debug Launcher
RUN /opt/eclipse/eclipse \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://download.eclipse.org/releases/oxygen \
-installIUs org.eclipse.tcf.cdt.feature.feature.group,org.eclipse.tcf.te.tcf.feature.feature.group,org.eclipse.tcf.rse.feature.feature.group,org.eclipse.tcf.te.tcf.launch.cdt.feature.feature.group


# Copy entrypoint script. Sets up Yocto SDK environment
COPY run.sh /
RUN chmod +x /run.sh

RUN echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER developer

ENTRYPOINT ["/run.sh"]
CMD ["/opt/eclipse/eclipse"]
