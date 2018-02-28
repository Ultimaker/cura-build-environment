FROM centos:centos7

# Environment vars for easy configuration
ENV CURA_BENV_BUILD_TYPE=Release
ENV CURA_BENV_GIT_DIR=/srv/cura-build-environment

# Install build environment dependencies
RUN yum -y update
RUN yum install -y \
    epel-release
RUN yum update -y
RUN yum install -y \
    centos-release-scl-rh
RUN yum update -y
RUN yum install -y \
    centos-release-scl \
    cmake3 \
    curl \
    devtoolset-3-gcc \
    devtoolset-3-gcc-c++ \
    devtoolset-3-gcc-gfortran \
    git \
    make \
    mesa-libGL \
    mesa-libGL-devel \
    openssl-devel \
    tar \
    which \
    xorg-x11-server-Xvfb \
    tigervnc-server \
    xterm \
    xdotool \
    xz

# Init xstartup
ADD ./xstartup /
RUN mkdir /.vnc
RUN x11vnc -storepasswd 123456 /.vnc/passwd
RUN  \cp -f ./xstartup /.vnc/.
RUN chmod -v +x /.vnc/xstartup

# Note: make sure to run the following lines before your UI application:
#   Xvfb :1 -screen 0 1600x1200x16 &
#   export DISPLAY=:1.0

# Make sure we can use the correct gcc toolchain
RUN scl enable devtoolset-3 bash

# Set up the build environment
RUN mkdir $CURA_BENV_GIT_DIR
WORKDIR $CURA_BENV_GIT_DIR
RUN git clone https://github.com/Ultimaker/cura-build-environment

# We remove appImageKit as we don't need it and depends on too many things
RUN rm $CURA_BENV_GIT_DIR/cura-build-environment/projects/appimagekit.cmake

# Build the build environment
RUN mkdir $CURA_BENV_GIT_DIR/cura-build-environment/build
WORKDIR $CURA_BENV_GIT_DIR/cura-build-environment/build
RUN cmake3 .. \
    -DCMAKE_BUILD_TYPE=$CURA_BENV_BUILD_TYPE \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_Fortran_COMPILER=gfortran
RUN make

# Cleanup
WORKDIR /
RUN rm -R $CURA_BENV_GIT_DIR
