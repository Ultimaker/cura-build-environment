FROM debian:buster AS base

LABEL linux_distro="debian-buster" \
      architecture="amd64" \
      python_version="3.10.2" \
      qt_version="6.2.2"

# Set build time arguments
ARG SOURCE="/home/ultimaker/source"
ARG INSTALL="/home/ultimaker/install"
ARG BUILD="/home/ultimaker/build"
ARG ENVIRONMENT="/home/ultimaker/env"
ARG CONAN_DATA="/home/ultimaker/.conan/data"

# Create unprivileged user
RUN groupadd -g 1000 ultimaker && \
    useradd -g ultimaker -u 1000 ultimaker -m

# Update and install packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y build-essential g++ gfortran libtool make autoconf automake git curl wget cmake tar \
        libffi-dev pkg-config libx11-xcb-dev libxcb* libfreetype6-dev libgl1-mesa-dev libegl1-mesa libxkbcommon-dev \
        libxkbcommon-x11-dev libx11-dev libxml2-dev libxslt-dev libfontconfig1-dev patchelf libssl-dev autopoint \
        libdbus-1-3 libwayland-egl1 libwayland-cursor0 ninja-build zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
        libsqlite3-dev libreadline-dev libbz2-dev libx11-dev libx11-xcb-dev libfontenc-dev libice-dev libsm-dev \
        libxau-dev libxaw7-dev libxcomposite-dev libxcursor-dev libxdamage-dev libxdmcp-dev libxext-dev libxfixes-dev \
        libxft-dev libxi-dev libxinerama-dev libxkbfile-dev libxmu-dev libxmuu-dev libxpm-dev libxrandr-dev \
        libxrender-dev libxres-dev libxss-dev libxt-dev libxtst-dev libxv-dev libxvmc-dev libxxf86vm-dev xtrans-dev \
        libxcb-render0-dev libxcb-render-util0-dev libxcb-xkb-dev libxcb-icccm4-dev libxcb-image0-dev \
        libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-xinerama0-dev \
        xkb-data libxcb-dri3-dev uuid-dev libxcb-util0-dev

ENV PATH="/home/ultimaker/env/bin:/home/ultimaker/install/bin:/usr/local/bin/:${PATH}" \
    LD_LIBRARY_PATH="/home/ultimaker/env/lib:/home/ultimaker/install/lib:/usr/lib/x86_64-linux-gnu/:/usr/lib/:/lib/:/lib/x86_64-linux-gnu/:${LD_LIBRARY_PATH}" \
    HOME=/home/ultimaker \
    USER=ultimaker

FROM base AS base_cmake

RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.5/cmake-3.21.5.tar.gz && \
    tar -zxvf cmake-3.21.5.tar.gz && \
    cd cmake-3.21.5 && \
    cmake . && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -rf cmake-3.21.5 && \
    apt-get remove -y cmake

FROM base_cmake AS base_python

RUN wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz && \
    tar -xf Python-3.10.2.tgz && \
    cd Python-3.10.2 && \
    ./configure --enable-optimizations && \
    make -j $(nproc) && \
    make install

FROM base_python AS base_conan

RUN python3 -m pip install conan && \
    conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default && \
    conan config install https://github.com/ultimaker/conan-config.git && \
    conan config set general.revisions_enabled=1 && \
    conan config set general.scm_to_conandata=1

FROM base_conan AS cura_build_environment

# Cleanup
USER root
WORKDIR /
RUN rm -rf /tmp/* && \
    rm -rf /var/cache

# Set up the build folders
RUN mkdir -p /home/ultimaker/source /home/ultimaker/build /home/ultimaker/install /home/ultimaker/env && \
    chown -R ultimaker:ultimaker /home/ultimaker

# Change working directory
USER ultimaker:ultimaker
WORKDIR /home/ultimaker/
