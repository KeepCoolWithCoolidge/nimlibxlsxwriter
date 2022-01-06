# Package

version       = "0.3.0"
author        = "Original: KeepCoolWithCoolidge / Fork: ThomasTJdev"
description   = "libxslxwriter wrapper for Nim"
license       = "MIT"

# Dependencies
requires "nim >= 1.2.0"

import distros



task setup, "Check OS":
  if detectOs(Windows):
    quit("Cannot run on Windows. Checkout legacy/LEGACY.md for support")

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

before install:
  setupTask()