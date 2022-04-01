ARG DISTRO_VERSION

FROM ubuntu:${DISTRO_VERSION}

LABEL maintainer="Ultimaker b.v. <software-cura@ultimaker.com>"

ARG PYTHON_VERSION
ARG PYTHON_VERSION_FULL

ENV PYENV_ROOT=/opt/pyenv \
    PATH=/usr/local/bin/:/opt/pyenv/versions/${PYTHON_VERSION_FULL}/bin/:/opt/conan/binutils/bin:${PATH} \
    LD_LIBRARY_PATH="/home/conan/env${LD_LIBRARY_PATH}" \
    CONAN_USER_HOME=/home/conan

ARG CMAKE_VERSION
ARG CMAKE_VERSION_FULL
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
       build-essential \
       llvm \
       libxml2-dev \
       libxmlsec1-dev \
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
    && wget --no-check-certificate --quiet -O pyenv-installer https://raw.githubusercontent.com/pyenv/pyenv-installer/56d708c8bda56370c4bc1e2fce68087cfcd007eb/bin/pyenv-installer \
    && chmod +x pyenv-installer \
    && ./pyenv-installer \
    && rm pyenv-installer \
    && update-alternatives --install /usr/bin/pyenv pyenv /opt/pyenv/bin/pyenv 100 \
    && git clone https://github.com/openssl/openssl.git \
    && cd openssl \
    && git checkout OpenSSL_1_1_1m \
    && ./config \
    && apt-get remove -y openssl \
    && make -j $(nproc) \
    && make install \
    && ldconfig \
    && cd .. \
    && rm -rf openssl \
    && PYTHON_CONFIGURE_OPTS="--enable-shared --with-openssl-rpath" CPPFLAG="-I/usr/include/" LDFLAGS="-L/usr/local/lib/" pyenv install ${PYTHON_VERSION_FULL} \
    && pyenv global ${PYTHON_VERSION_FULL} \
    && update-alternatives --install /usr/bin/python3 python3 /opt/pyenv/shims/python3 100 \
    && update-alternatives --install /usr/bin/pip3 pip3 /opt/pyenv/shims/pip3 100 \
    && update-alternatives --install /usr/local/bin/python python /opt/pyenv/shims/python 100 \
    && update-alternatives --install /usr/local/bin/pip pip /opt/pyenv/shims/pip 100 \
    && ln -s /usr/share/pyshared/lsb_release.py /opt/pyenv/versions/${PYTHON_VERSION_FULL}/lib/python${PYTHON_VERSION}/site-packages/lsb_release.py \
    && pip install -q --upgrade --no-cache-dir pip \
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
    && runuser -u conan -- printf 'eval "$(pyenv init -)"\n' >> /home/conan/.bashrc \
    && runuser -u conan -- printf 'eval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc \
    && mkdir -p /home/conan/env \
    && chown -R conan:1001 /opt/pyenv \
    && chown -R conan:1001 /opt/conan

USER conan
WORKDIR /home/conan

RUN python -m pip install conan==${CONAN_VERSION} \
    && CONAN_REVISIONS_ENABLED=1 CONAN_USER_HOME=/tmp/conan conan install -r conancenter -g deploy -if /opt/conan -l /opt/conan/conan.lock /opt/conan/conanfile.txt \
    && rm -rf /tmp/conan \
    && conan config set general.revisions_enabled=1