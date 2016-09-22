#!/bin/sh

export MACOSX_DEPLOYMENT_TARGET=10.7
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
export CFLAGS="-I/usr/local/opt/openssl/include -stdlib=libc++"
export CXXFLAGS="-I/usr/local/opt/openssl/include -stdlib=libc++"
export LDFLAGS="-L/usr/local/opt/openssl/lib -stdlib=libc++"

