when defined(Windows):
  const dynlibQueue = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibQueue = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibQueue = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/third_party/queue.h --> nimlibxlsxwriter/queue.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
