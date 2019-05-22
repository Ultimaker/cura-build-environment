# -------------------------------
# Stage 1: Build cura-build-environment
#
FROM centos:centos7

# Set build time arugments
ARG X11VNC_PASSWORD=123456
ARG CURA_BUILD_ENV_BUILD_TYPE=Release
ARG CURA_BUILD_ENV_PATH=/srv/cura-build-environment
ARG CURA_BUILD_ENV_WORK_DIR=/tmp/cura-build-environment
# FIXME: change to master when done
ARG CURA_ARCUS_BRANCH_OR_TAG=WIP_fix_docker
ARG CURA_SAVITAR_BRANCH_OR_TAG=WIP_fix_docker

# Create unprivileged user
RUN groupadd -g 1000 ultimaker \
 && useradd -g ultimaker -u 1000 ultimaker -m

# Install package repositories
RUN yum -y update && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y centos-release-scl-rh centos-release-scl && \
    yum update -y

# Install dependencies
RUN yum install -y \
    devtoolset-7-gcc \
    devtoolset-7-gcc-c++ \
    devtoolset-7-gcc-gfortran \
    cmake3 \
    curl \
    git \
    libtool \
    make \
    file \
    tar \
    which \
    bzip2 \
    bzip2-devel \
    freetype \
    freetype-devel \
    fontconfig \
    fontconfig-devel \
    mesa-libGL \
    mesa-libGL-devel \
    xorg-x11-server-Xvfb \
    libX11-devel \
    xdotool \
    tigervnc-server \
    x11vnc \
    xterm

# Init xstartup
ADD ./xstartup /
RUN mkdir -p /.vnc && \
    x11vnc -storepasswd "${X11VNC_PASSWORD}" /.vnc/passwd && \
    cp -f ./xstartup /.vnc/ && \
    chmod a+x /.vnc/xstartup

# Note: make sure to run the following lines before your UI application:
#   Xvfb :1 -screen 0 1600x1200x16 &
#   export DISPLAY=:1.0

# Set up the build environment
RUN mkdir -p "${CURA_BUILD_ENV_WORK_DIR}" "${CURA_BUILD_ENV_PATH}"
ADD . "${CURA_BUILD_ENV_WORK_DIR}"/src

# Build the build environment
RUN mkdir -p "${CURA_BUILD_ENV_WORK_DIR}"/build \
 && chown -R ultimaker:ultimaker "${CURA_BUILD_ENV_WORK_DIR}" \
 && chown -R ultimaker:ultimaker "${CURA_BUILD_ENV_PATH}"
WORKDIR "${CURA_BUILD_ENV_WORK_DIR}"/build
USER ultimaker
RUN "${CURA_BUILD_ENV_WORK_DIR}"/src/docker/build.sh \
        "${CURA_BUILD_ENV_WORK_DIR}"/src

# -------------------------------
# Stage 2: Create a cleaner image with cura-build-environment installed
#
FROM centos:centos7

# Set build time arguments
ARG X11VNC_PASSWORD=123456
ARG CURA_BUILD_ENV_BUILD_TYPE=Release
ARG CURA_BUILD_ENV_PATH=/srv/cura-build-environment
# FIXME: change to master when done
ARG CURA_ARCUS_BRANCH_OR_TAG=fix_cmake_3.12
ARG CURA_SAVITAR_BRANCH_OR_TAG=fix_cmake_3.12

# Set environment variables
ENV CURA_BUILD_ENV_BUILD_TYPE="${CURA_BUILD_ENV_BUILD_TYPE}" \
    CURA_BUILD_ENV_PATH="${CURA_BUILD_ENV_PATH}" \
    CURA_ARCUS_BRANCH_OR_TAG="${CURA_ARCUS_BRANCH_OR_TAG}" \
    CURA_SAVITAR_BRANCH_OR_TAG="${CURA_SAVITAR_BRANCH_OR_TAG}"

# Create unprivileged user
RUN groupadd -g 1000 ultimaker \
 && useradd -g ultimaker -u 1000 ultimaker

# Install package repositories
RUN yum -y update && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y centos-release-scl-rh centos-release-scl && \
    yum update -y

# Install dependencies
RUN yum install -y \
    devtoolset-7-gcc \
    devtoolset-7-gcc-c++ \
    devtoolset-7-gcc-gfortran \
    cmake3 \
    curl \
    git \
    gettext \
    doxygen \
    libtool \
    make \
    file \
    tar \
    which \
    bzip2 \
    bzip2-devel \
    freetype \
    freetype-devel \
    fontconfig \
    fontconfig-devel \
    mesa-libGL \
    mesa-libGL-devel \
    xorg-x11-server-Xvfb \
    libX11-devel \
    patchelf \
    xdotool \
    tigervnc-server \
    x11vnc \
    xterm

# Init xstartup
ADD ./xstartup /
RUN mkdir -p /.vnc && \
    x11vnc -storepasswd "${X11VNC_PASSWORD}" /.vnc/passwd && \
    cp -f ./xstartup /.vnc/ && \
    chmod a+x /.vnc/xstartup

# Note: make sure to run the following lines before your UI application:
#   Xvfb :1 -screen 0 1600x1200x16 &
#   export DISPLAY=:1.0

# Copy cura-build-environment here
COPY --from=0 "${CURA_BUILD_ENV_PATH}" "${CURA_BUILD_ENV_PATH}"

# Cleanup
RUN rm -rf /tmp/* && \
    rm -rf /var/cache

# Change working directory and set user
WORKDIR /home/ultimaker
USER ultimaker
