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

    def generate(self):
        cmake = CMakeDeps(self)
        cmake.generate()

        tc = CMakeToolchain(self)

        # Don't use Visual Studio as the CMAKE_GENERATOR
        if self.settings.compiler == "Visual Studio":
            tc.blocks["generic_system"].values["generator_platform"] = None
            tc.blocks["generic_system"].values["toolset"] = None

        tc.variables["CHARON_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["CURA_BRANCH_OR_TAG"] = "origin/qt6_beyond_the_splash"
        tc.variables["URANIUM_BRANCH_OR_TAG"] = "origin/qt6_beyond_the_splash"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["SAVITAR_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["LIBNEST2D_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["PYNEST2D_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["ARCUS_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"
        tc.variables["CURAENGINE_BRANCH_OR_TAG"] = "origin/CURA-8640_PyQt6_upgrade"

        tc.variables["CURA_VERSION_MAJOR"] = "5"
        tc.variables["CURA_VERSION_EXTRA"] = "a+1"

        tc.generate()
