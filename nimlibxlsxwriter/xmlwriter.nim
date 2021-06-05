import utility
when defined(Windows):
  const dynlibXmlwriter = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibXmlwriter = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibXmlwriter = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/xmlwriter.h --> nimlibxlsxwriter/xmlwriter.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_MAX_ATTRIBUTE_LENGTH* = 2080
  LXW_ATTR_32* = 32

type
  INNER_C_STRUCT_temp_7* {.bycopy.} = object
    stqe_next*: ptr xml_attribute

  xml_attribute* {.bycopy.} = object
    key*: array[2080, char]
    value*: array[2080, char]
    list_entries*: INNER_C_STRUCT_temp_7

  xml_attribute_list* {.bycopy.} = object
    stqh_first*: ptr xml_attribute
    stqh_last*: ptr ptr xml_attribute


proc lxw_new_attribute_str*(key: cstring; value: cstring): ptr xml_attribute {.stdcall,
    importc: "lxw_new_attribute_str", dynlib: dynlibXmlwriter.}
proc lxw_new_attribute_int*(key: cstring; value: uint32): ptr xml_attribute {.
    stdcall, importc: "lxw_new_attribute_int", dynlib: dynlibXmlwriter.}
proc lxw_new_attribute_dbl*(key: cstring; value: cdouble): ptr xml_attribute {.stdcall,
    importc: "lxw_new_attribute_dbl", dynlib: dynlibXmlwriter.}
proc lxw_xml_declaration*(xmlfile: ptr FILE) {.stdcall,
    importc: "lxw_xml_declaration", dynlib: dynlibXmlwriter.}
proc lxw_xml_start_tag*(xmlfile: ptr FILE; tag: cstring;
                       attributes: ptr xml_attribute_list) {.stdcall,
    importc: "lxw_xml_start_tag", dynlib: dynlibXmlwriter.}
proc lxw_xml_start_tag_unencoded*(xmlfile: ptr FILE; tag: cstring;
                                 attributes: ptr xml_attribute_list) {.stdcall,
    importc: "lxw_xml_start_tag_unencoded", dynlib: dynlibXmlwriter.}
proc lxw_xml_end_tag*(xmlfile: ptr FILE; tag: cstring) {.stdcall,
    importc: "lxw_xml_end_tag", dynlib: dynlibXmlwriter.}
proc lxw_xml_empty_tag*(xmlfile: ptr FILE; tag: cstring;
                       attributes: ptr xml_attribute_list) {.stdcall,
    importc: "lxw_xml_empty_tag", dynlib: dynlibXmlwriter.}
proc lxw_xml_empty_tag_unencoded*(xmlfile: ptr FILE; tag: cstring;
                                 attributes: ptr xml_attribute_list) {.stdcall,
    importc: "lxw_xml_empty_tag_unencoded", dynlib: dynlibXmlwriter.}
proc lxw_xml_data_element*(xmlfile: ptr FILE; tag: cstring; data: cstring;
                          attributes: ptr xml_attribute_list) {.stdcall,
    importc: "lxw_xml_data_element", dynlib: dynlibXmlwriter.}
proc lxw_xml_rich_si_element*(xmlfile: ptr FILE; string: cstring) {.stdcall,
    importc: "lxw_xml_rich_si_element", dynlib: dynlibXmlwriter.}
proc lxw_escape_control_characters*(string: cstring): cstring {.stdcall,
    importc: "lxw_escape_control_characters", dynlib: dynlibXmlwriter.}
proc lxw_escape_url_characters*(string: cstring; escape_hash: uint8): cstring {.
    stdcall, importc: "lxw_escape_url_characters", dynlib: dynlibXmlwriter.}
proc lxw_escape_data*(data: cstring): cstring {.stdcall, importc: "lxw_escape_data",
    dynlib: dynlibXmlwriter.}