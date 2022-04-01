ARG DISTRO_VERSION

FROM ubuntu:${DISTRO_VERSION}

LABEL maintainer="Ultimaker b.v. <software-cura@ultimaker.com>"

ENV PATH=/usr/local/bin/:/opt/conan/binutils/bin:${PATH} \
    CONAN_USER_HOME=/home/conan

ARG CMAKE_VERSION
ARG CMAKE_VERSION_FULL
ARG PYTHON_VERSION
ARG CONAN_VERSION

WORKDIR /root

COPY conan.lock conanfile.txt /opt/conan/

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:git-core/ppa -y \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends --no-install-suggests -o=Dpkg::Use-Pty=0 \
       sudo \
       binutils \
       wget \
       git \
       g++-multilib \
       libgmp-dev \
       libmpfr-dev \
       libmpc-dev \
       nasm \
       dh-autoreconf \
       libffi-dev \
       libssl-dev \
       pkg-config \
       subversion \
       zlib1g-dev \
       libbz2-dev \
       libsqlite3-dev \
       libreadline-dev \
       xz-utils \
       curl \
       libncurses5-dev \
       libncursesw5-dev \
       liblzma-dev \
       ca-certificates \
       autoconf-archive \
       gdb \
       lcov \
       libssl-dev \
       libgdbm-dev \
       uuid-dev \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q --no-check-certificate https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION_FULL}/cmake-${CMAKE_VERSION_FULL}.tar.gz \
    && tar -xzf cmake-${CMAKE_VERSION_FULL}.tar.gz \
       --exclude=bin/cmake-gui \
       --exclude=doc/cmake \
       --exclude=share/cmake-${CMAKE_VERSION}/Help \
       --exclude=share/vim \
       --exclude=share/vim \
    && cp -fR cmake-${CMAKE_VERSION_FULL}/* /usr \
    && rm -rf /root/cmake-${CMAKE_VERSION_FULL} \
    && rm /root/cmake-${CMAKE_VERSION_FULL}.tar.gz \
    && curl -fL https://getcli.jfrog.io | sh -s 1.48.1 \
    && mv jfrog /usr/local/bin/jfrog \
    && chmod +x /usr/local/bin/jfrog \
    && groupadd 1001 -g 1001 \
    && groupadd 1000 -g 1000 \
    && groupadd 2000 -g 2000 \
    && groupadd 999 -g 999 \
    && useradd -ms /bin/bash conan -g 1001 -G 1000,2000,999 \
    && printf "conan:conan" | chpasswd \
    && adduser conan sudo \
    && printf "conan ALL= NOPASSWD: ALL\\n" >> /etc/sudoers \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations --with-openssl=/usr/ \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf Python-${PYTHON_VERSION}* \
    && python3 -m pip install -q --upgrade --no-cache-dir pip \
    && printf '/usr/local/lib\n' > /etc/ld.so.conf.d/20local-lib.conf \
    && printf '/usr/local/lib64\n' >> /etc/ld.so.conf.d/20local-lib.conf \
    && mv /etc/ld.so.conf.d/libc.conf /etc/ld.so.conf.d/10libc.conf \
    && rm /etc/ld.so.cache \
    && ldconfig -C /etc/ld.so.cache \
    && apt-get -qq purge -y g++-multilib gcc gcc-5 \
    && apt-get -qq autoremove -y \
    && apt-get -qq autoclean \
    && apt-get -qq update \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && chown -R conan:1001 /opt/conan

USER conan
WORKDIR /home/conan

RUN python3 -m pip install conan==${CONAN_VERSION} \
    && CONAN_REVISIONS_ENABLED=1 CONAN_USER_HOME=/tmp/conan conan install -r conancenter -g deploy -if /opt/conan -l /opt/conan/conan.lock /opt/conan/conanfile.txt \
    && rm -rf /tmp/conan \
    && conan config set general.revisions_enabled=1