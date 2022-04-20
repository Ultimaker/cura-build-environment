from pathlib import Path

from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMakeDeps, CMake

from conans.errors import ConanInvalidConfiguration
from conans.tools import Version
from conan.tools.files import files

required_conan_version = ">=1.46.2"


class CuraBuildEnvironemtConan(ConanFile):
    name = "cura-build-environment"
    description = "Building Cura dependencies"
    topics = ("conan", "python", "pypi", "pip")
    settings = "os", "compiler", "build_type", "arch"
    build_policy = "missing"

    def configure(self):
        self.options["boost"].header_only = True

    def requirements(self):
        self.requires("protobuf/3.17.1")
        self.requires("clipper/6.4.2")
        self.requires("boost/1.78.0")
        self.requires("gtest/1.8.1")
        self.requires("nlopt/2.7.0")
        self.requires("rapidjson/1.1.0")
        self.requires("stb/20200203")

    def generate(self):
        cmake = CMakeDeps(self)
        cmake.generate()

        tc = CMakeToolchain(self)

        # Don't use Visual Studio as the CMAKE_GENERATOR
        if self.settings.compiler == "Visual Studio":
            tc.blocks["generic_system"].values["generator_platform"] = None
            tc.blocks["generic_system"].values["toolset"] = None

        # FIXME: These need to be removed once we got Rundeck up and running
        tc.variables["CHARON_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["CURA_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["URANIUM_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["SAVITAR_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["LIBNEST2D_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["PYNEST2D_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["CURAENGINE_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["CURABINARYDATA_BRANCH_OR_TAG"] = "origin/5.0"
        tc.variables["CURA_VERSION_MAJOR"] = "5"
        tc.variables["CURA_VERSION_MINOR"] = "0"
        tc.variables["CURA_VERSION_PATCH"] = "0"
        tc.variables["CURA_VERSION_PRE_RELEASE_TAG"] = "a"
        tc.variables["CURA_VERSION_BUILD"] = "9"

        tc.variables["CURA_CLOUD_API_VERSION"] = "1"
        tc.variables["CURA_CLOUD_API_ROOT"] = "https://api.ultimaker.com"
        tc.variables["CURA_CLOUD_ACCOUNT_API_ROOT"] = "https://account.ultimaker.com"
        tc.variables["CURA_MARKETPLACE_ROOT"] = "https://marketplace.ultimaker.com"
        tc.variables["CURA_DIGITAL_FACTORY_URL"] = "https://digitalfactory.ultimaker.com"


        tc.generate()
