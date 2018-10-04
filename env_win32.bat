call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86

REM cryptography by default links to OpenSSL 1.1.0 which has different library
REM file names, so we need this flag to be able to link to OpenSSL 1.0.2
set CRYPTOGRAPHY_WINDOWS_LINK_LEGACY_OPENSSL=1
