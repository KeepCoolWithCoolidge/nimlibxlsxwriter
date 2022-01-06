import format
when defined(Windows):
  const dynlibStyles = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibStyles = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibStyles = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/styles.h --> nimlibxlsxwriter/styles.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  lxw_styles* {.bycopy.} = object
    file*: ptr FILE
    font_count*: uint32
    xf_count*: uint32
    dxf_count*: uint32
    num_format_count*: uint32
    border_count*: uint32
    fill_count*: uint32
    xf_formats*: ptr lxw_format
    dxf_formats*: ptr lxw_format
    has_hyperlink*: uint8
    hyperlink_font_id*: uint16
    has_comments*: uint8


proc lxw_styles_new*(): ptr lxw_styles {.stdcall, importc: "lxw_styles_new",
                                     dynlib: dynlibStyles.}
proc lxw_styles_free*(styles: ptr lxw_styles) {.stdcall, importc: "lxw_styles_free",
    dynlib: dynlibStyles.}
proc lxw_styles_assemble_xml_file*(self: ptr lxw_styles) {.stdcall,
    importc: "lxw_styles_assemble_xml_file", dynlib: dynlibStyles.}
proc lxw_styles_write_string_fragment*(self: ptr lxw_styles; string: cstring) {.
    stdcall, importc: "lxw_styles_write_string_fragment", dynlib: dynlibStyles.}
proc lxw_styles_write_rich_font*(lxw_styles: ptr lxw_styles; format: ptr lxw_format) {.
    stdcall, importc: "lxw_styles_write_rich_font", dynlib: dynlibStyles.}