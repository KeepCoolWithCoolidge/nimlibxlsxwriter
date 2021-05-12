# Package

version       = "0.1.4"
author        = "Original: KeepCoolWithCoolidge / Fork: ThomasTJdev"
description   = "libxslxwriter wrapper for Nim"
license       = "MIT"
skipDirs      = @["tests"]

# Dependencies

requires "nim >= 1.2.0"
requires "nimgen >= 0.5.2"
requires "c2nim >= 0.9.14"

import distros

var cmd = ""
if detectOs(Windows):
    cmd = "cmd /c "

task setup, "Checkout and generate":
    exec cmd & "nimgen nimlibxlsxwriter.cfg"

before install:
    setupTask()

task test, "Run tests":
    withDir("tests"):
        exec "nim c -r anatomy.nim"
        exec "nim c -r array_formula.nim"
        exec "nim c -r autofilter.nim"
        exec "nim c -r chart_area.nim"
        exec "nim c -r chart_bar.nim"
        exec "nim c -r chart_clustered.nim"
        exec "nim c -r chart_column.nim"
        exec "nim c -r chart_data_table.nim"
        exec "nim c -r chart_data_tools.nim"
        exec "nim c -r chart_test.nim"
        exec "nim c -r date_and_times.nim"
        exec "nim c -r date_and_times_2.nim"
        exec "nim c -r date_and_times_3.nim"
