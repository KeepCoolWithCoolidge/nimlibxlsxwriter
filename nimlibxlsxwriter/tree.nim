when defined(Windows):
  const dynlibTree = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibTree = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibTree = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/third_party/tree.h --> nimlibxlsxwriter/tree.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  SPLAY_NEGINF* = -1
  SPLAY_INF* = 1
  RB_BLACK* = 0
  RB_RED* = 1
  RB_NEGINF* = -1
  RB_INF* = 1
