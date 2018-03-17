# Package

version       = "0.1.0"
author        = "KeepCoolWithCoolidge"
description   = "libxslxwriter wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.1.4"

import distros

var cmd = ""
if detectOs(Windows):
    cmd = "cmd /c "

task setup, "Checkout and generate":
    exec cmd & "nimgen nimlibxlsxwriter.cfg"

before install:
    setupTask()