FROM centos:centos7

# Environment vars for easy configuration
ENV CURA_BENV_BUILD_TYPE=Release
ENV CURA_BENV_SOURCE_DIR=/srv/cura-build-environment

# Install package repositories
RUN yum -y update
RUN yum install -y \
    epel-release
RUN yum update -y
RUN yum install -y \
    centos-release-scl-rh
RUN yum update -y
RUN yum install -y \
    centos-release-scl
RUN yum update -y

# Install dependencies
RUN yum install -y \
    devtoolset-3-gcc \
    devtoolset-3-gcc-c++ \
    devtoolset-3-gcc-gfortran \
    cmake3 \
    curl \
    git \
    make \
    openssl-devel \
    tar \
    which \
    zlib-devel

# Enable devtools-3
ENV PATH=${PATH}:/opt/rh/devtoolset-3/root/usr/bin

# Set up the build environment
RUN mkdir $CURA_BENV_SOURCE_DIR
WORKDIR $CURA_BENV_SOURCE_DIR
ADD . .

# We remove appImageKit as we don't need it and depends on too many things
RUN rm $CURA_BENV_SOURCE_DIR/projects/appimagekit.cmake

# Build the build environment
RUN mkdir $CURA_BENV_SOURCE_DIR/build
WORKDIR $CURA_BENV_SOURCE_DIR/build
RUN cmake3 .. -DCMAKE_BUILD_TYPE=$CURA_BENV_BUILD_TYPE
RUN make

# Cleanup, we only need the built dependencies in the image, not the sources
RUN rm -Rf $CURA_BENV_SOURCE_DIR
RUN rm -Rf /var/cache
