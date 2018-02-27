FROM centos:7

# Environment vars for easy configuration
ENV BUILD_TYPE=Release
ENV GIT_DIR=/usr/git
ENV INSTALL_DIR=/usr/cura
ENV LIB_INSTALL_DIR=$INSTALL_DIR/libs
ENV APP_INSTALL_DIR=$INSTALL_DIR/app

# Step 0: Install build environment dependencies
RUN yum -y update
RUN yum install -y \
    centos-release-scl \
    curl \
    devtoolset-7 \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    git \
    openssl-devel \
    make \
    mesa-libGL \
    mesa-libGL-devel \
    tar \
    which \
    xz

# Manually install cmake3 as it's not availabe in yum by default
RUN curl http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm -O
RUN rpm -Uvh epel-release-7-11.noarch.rpm
RUN yum install -y cmake3

# Step 1: Set up the build environment
RUN mkdir $GIT_DIR
WORKDIR $GIT_DIR
RUN git clone https://github.com/Ultimaker/cura-build-environment
WORKDIR $GIT_DIR/cura-build-environment
RUN mkdir build
WORKDIR $GIT_DIR/cura-build-environment/build
RUN cmake3 .. \
    -DCMAKE_INSTALL_PREFIX=$LIB_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_Fortran_COMPILER=gfortran
RUN make
