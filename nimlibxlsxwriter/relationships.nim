import common
when defined(Windows):
  const dynlibRelationships = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibRelationships = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibRelationships = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/relationships.h --> nimlibxlsxwriter/relationships.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  lxw_rel_tuples* {.bycopy.} = object
    stqh_first*: ptr lxw_rel_tuple
    stqh_last*: ptr ptr lxw_rel_tuple

  INNER_C_STRUCT_temp_6* {.bycopy.} = object
    stqe_next*: ptr lxw_rel_tuple

  lxw_rel_tuple* {.bycopy.} = object
    `type`*: cstring
    target*: cstring
    target_mode*: cstring
    list_pointers*: INNER_C_STRUCT_temp_6

  lxw_relationships* {.bycopy.} = object
    file*: ptr FILE
    rel_id*: uint32
    relationships*: ptr lxw_rel_tuples


proc lxw_relationships_new*(): ptr lxw_relationships {.stdcall,
    importc: "lxw_relationships_new", dynlib: dynlibRelationships.}
proc lxw_free_relationships*(relationships: ptr lxw_relationships) {.stdcall,
    importc: "lxw_free_relationships", dynlib: dynlibRelationships.}
proc lxw_relationships_assemble_xml_file*(self: ptr lxw_relationships) {.stdcall,
    importc: "lxw_relationships_assemble_xml_file", dynlib: dynlibRelationships.}
proc lxw_add_document_relationship*(self: ptr lxw_relationships; `type`: cstring;
                                   target: cstring) {.stdcall,
    importc: "lxw_add_document_relationship", dynlib: dynlibRelationships.}
proc lxw_add_package_relationship*(self: ptr lxw_relationships; `type`: cstring;
                                  target: cstring) {.stdcall,
    importc: "lxw_add_package_relationship", dynlib: dynlibRelationships.}
proc lxw_add_ms_package_relationship*(self: ptr lxw_relationships; `type`: cstring;
                                     target: cstring) {.stdcall,
    importc: "lxw_add_ms_package_relationship", dynlib: dynlibRelationships.}
proc lxw_add_worksheet_relationship*(self: ptr lxw_relationships; `type`: cstring;
                                    target: cstring; target_mode: cstring) {.
    stdcall, importc: "lxw_add_worksheet_relationship", dynlib: dynlibRelationships.}