import common
when defined(Windows):
  const dynlibDrawing = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibDrawing = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibDrawing = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/drawing.h --> nimlibxlsxwriter/drawing.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  lxw_drawing_types* {.size: sizeof(cint).} = enum
    LXW_DRAWING_NONE = 0, LXW_DRAWING_IMAGE, LXW_DRAWING_CHART, LXW_DRAWING_SHAPE


type
  image_types* {.size: sizeof(cint).} = enum
    LXW_IMAGE_UNKNOWN = 0, LXW_IMAGE_PNG, LXW_IMAGE_JPEG, LXW_IMAGE_BMP


type
  INNER_C_STRUCT_temp_34* {.bycopy.} = object
    stqe_next*: ptr lxw_drawing_object

  lxw_drawing_coords* {.bycopy.} = object
    col*: uint32
    row*: uint32
    col_offset*: cdouble
    row_offset*: cdouble

  lxw_drawing_object* {.bycopy.} = object
    `type`*: uint8
    anchor*: uint8
    `from`*: lxw_drawing_coords
    to*: lxw_drawing_coords
    col_absolute*: uint32
    row_absolute*: uint32
    width*: uint32
    height*: uint32
    shape*: uint8
    rel_index*: uint32
    url_rel_index*: uint32
    description*: cstring
    tip*: cstring
    list_pointers*: INNER_C_STRUCT_temp_34

  lxw_drawing_objects* {.bycopy.} = object
    stqh_first*: ptr lxw_drawing_object
    stqh_last*: ptr ptr lxw_drawing_object

  lxw_drawing* {.bycopy.} = object
    file*: ptr FILE
    embedded*: uint8
    orientation*: uint8
    drawing_objects*: ptr lxw_drawing_objects


proc lxw_drawing_new*(): ptr lxw_drawing {.stdcall, importc: "lxw_drawing_new",
                                       dynlib: dynlibDrawing.}
proc lxw_drawing_free*(drawing: ptr lxw_drawing) {.stdcall,
    importc: "lxw_drawing_free", dynlib: dynlibDrawing.}
proc lxw_drawing_assemble_xml_file*(self: ptr lxw_drawing) {.stdcall,
    importc: "lxw_drawing_assemble_xml_file", dynlib: dynlibDrawing.}
proc lxw_free_drawing_object*(drawing_object: ptr lxw_drawing_object) {.stdcall,
    importc: "lxw_free_drawing_object", dynlib: dynlibDrawing.}
proc lxw_add_drawing_object*(drawing: ptr lxw_drawing;
                            drawing_object: ptr lxw_drawing_object) {.stdcall,
    importc: "lxw_add_drawing_object", dynlib: dynlibDrawing.}