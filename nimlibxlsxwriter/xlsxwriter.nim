import workbook
export workbook
import worksheet
export worksheet
import format
export format
import utility
export utility
import tree
export tree
import shared_strings
export shared_strings
import common
export common
import hash_table
export hash_table
import drawing
export drawing
import chart
export chart
import queue
export queue
when defined(Windows):
  const dynlibXlsxwriter = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibXlsxwriter = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibXlsxwriter = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter.h --> nimlibxlsxwriter/xlsxwriter.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_VERSION_ID* = 94
