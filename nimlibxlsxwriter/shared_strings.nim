import common
when defined(Windows):
  const dynlibSharedstrings = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibSharedstrings = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibSharedstrings = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/shared_strings.h --> nimlibxlsxwriter/shared_strings.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  sst_rb_tree* {.bycopy.} = object
    rbh_root*: ptr sst_element

  sst_order_list* {.bycopy.} = object
    stqh_first*: ptr sst_element
    stqh_last*: ptr ptr sst_element

  INNER_C_STRUCT_temp_7* {.bycopy.} = object
    stqe_next*: ptr sst_element

  INNER_C_STRUCT_temp_8* {.bycopy.} = object
    rbe_left*: ptr sst_element
    rbe_right*: ptr sst_element
    rbe_parent*: ptr sst_element
    rbe_color*: cint

  sst_element* {.bycopy.} = object
    index*: uint32
    string*: cstring
    is_rich_string*: uint8
    sst_order_pointers*: INNER_C_STRUCT_temp_7
    sst_tree_pointers*: INNER_C_STRUCT_temp_8

  lxw_sst* {.bycopy.} = object
    file*: ptr FILE
    string_count*: uint32
    unique_count*: uint32
    order_list*: ptr sst_order_list
    rb_tree*: ptr sst_rb_tree


proc lxw_sst_new*(): ptr lxw_sst {.stdcall, importc: "lxw_sst_new",
                               dynlib: dynlibSharedstrings.}
proc lxw_sst_free*(sst: ptr lxw_sst) {.stdcall, importc: "lxw_sst_free",
                                   dynlib: dynlibSharedstrings.}
proc lxw_get_sst_index*(sst: ptr lxw_sst; string: cstring; is_rich_string: uint8): ptr sst_element {.
    stdcall, importc: "lxw_get_sst_index", dynlib: dynlibSharedstrings.}
proc lxw_sst_assemble_xml_file*(self: ptr lxw_sst) {.stdcall,
    importc: "lxw_sst_assemble_xml_file", dynlib: dynlibSharedstrings.}