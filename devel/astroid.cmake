ExternalProject_Add(Astroid
    URL https://pypi.python.org/packages/55/14/be963877c2f336c6df8a77457f47163fd55427c0344bab2ba3f940d4edb8/astroid-1.4.9.tar.gz
    URL_MD5 a57438971de05eb801b82eae59c05217
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Astroid DEPENDS Python)
