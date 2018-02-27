FROM centos:centos7

# Environment vars for easy configuration
ENV CURA_BENV_BUILD_TYPE=Release
ENV CURA_BENV_GIT_DIR=/srv/cura-build-environment

# Install build environment dependencies
RUN yum -y update
RUN yum install -y \
    epel-release
RUN yum install -y \
    centos-release-scl \
    cmake3 \
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
    xz \
    x11vnc \
    xorg-x11-server-Xvfb \
    xorg-x11-twm \
    tigervnc-server \
    xterm \
    xorg-x11-font \
    xdotool

# Init xstartup
ADD ./xstartup /
RUN mkdir /.vnc
RUN x11vnc -storepasswd 123456 /.vnc/passwd
RUN  \cp -f ./xstartup /.vnc/.
RUN chmod -v +x /.vnc/xstartup
EXPOSE 5901

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
