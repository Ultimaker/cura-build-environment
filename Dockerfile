FROM centos:7

# Environment vars for easy configuration
ENV CURA_BENV_BUILD_TYPE=Release
ENV CURA_BENV_GIT_DIR=/srv/cura-build-environment

# Install build environment dependencies
RUN yum -y update
RUN yum install -y \
    centos-release-scl \
    curl \
    devtoolset-7 \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    git \
    make \
    mesa-libGL \
    mesa-libGL-devel \
    openssl-devel \
    tar \
    which \
    xz

# Manually install cmake3 as it's not availabe in yum by default
RUN curl http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm -O
RUN rpm -Uvh epel-release-7-11.noarch.rpm
RUN yum install -y cmake3

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
