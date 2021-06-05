import common
import xmlwriter
when defined(Windows):
  const dynlibUtility = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibUtility = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibUtility = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/utility.h --> nimlibxlsxwriter/utility.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
proc lxw_version*(): cstring {.stdcall, importc: "lxw_version", dynlib: dynlibUtility.}
proc lxw_version_id*(): uint16 {.stdcall, importc: "lxw_version_id",
                                dynlib: dynlibUtility.}
proc lxw_strerror*(error_num: lxw_error): cstring {.stdcall, importc: "lxw_strerror",
    dynlib: dynlibUtility.}
proc lxw_quote_sheetname*(str: cstring): cstring {.stdcall,
    importc: "lxw_quote_sheetname", dynlib: dynlibUtility.}
proc lxw_col_to_name*(col_name: cstring; col_num: lxw_col_t; absolute: uint8) {.
    stdcall, importc: "lxw_col_to_name", dynlib: dynlibUtility.}
proc lxw_rowcol_to_cell*(cell_name: cstring; row: lxw_row_t; col: lxw_col_t) {.stdcall,
    importc: "lxw_rowcol_to_cell", dynlib: dynlibUtility.}
proc lxw_rowcol_to_cell_abs*(cell_name: cstring; row: lxw_row_t; col: lxw_col_t;
                            abs_row: uint8; abs_col: uint8) {.stdcall,
    importc: "lxw_rowcol_to_cell_abs", dynlib: dynlibUtility.}
proc lxw_rowcol_to_range*(range: cstring; first_row: lxw_row_t; first_col: lxw_col_t;
                         last_row: lxw_row_t; last_col: lxw_col_t) {.stdcall,
    importc: "lxw_rowcol_to_range", dynlib: dynlibUtility.}
proc lxw_rowcol_to_range_abs*(range: cstring; first_row: lxw_row_t;
                             first_col: lxw_col_t; last_row: lxw_row_t;
                             last_col: lxw_col_t) {.stdcall,
    importc: "lxw_rowcol_to_range_abs", dynlib: dynlibUtility.}
proc lxw_rowcol_to_formula_abs*(formula: cstring; sheetname: cstring;
                               first_row: lxw_row_t; first_col: lxw_col_t;
                               last_row: lxw_row_t; last_col: lxw_col_t) {.stdcall,
    importc: "lxw_rowcol_to_formula_abs", dynlib: dynlibUtility.}
proc lxw_name_to_row*(row_str: cstring): uint32 {.stdcall,
    importc: "lxw_name_to_row", dynlib: dynlibUtility.}
proc lxw_name_to_col*(col_str: cstring): uint16 {.stdcall,
    importc: "lxw_name_to_col", dynlib: dynlibUtility.}
proc lxw_name_to_row_2*(row_str: cstring): uint32 {.stdcall,
    importc: "lxw_name_to_row_2", dynlib: dynlibUtility.}
proc lxw_name_to_col_2*(col_str: cstring): uint16 {.stdcall,
    importc: "lxw_name_to_col_2", dynlib: dynlibUtility.}
proc lxw_datetime_to_excel_date*(datetime: ptr lxw_datetime; date_1904: uint8): cdouble {.
    stdcall, importc: "lxw_datetime_to_excel_date", dynlib: dynlibUtility.}
proc lxw_strdup*(str: cstring): cstring {.stdcall, importc: "lxw_strdup",
                                      dynlib: dynlibUtility.}
proc lxw_strdup_formula*(formula: cstring): cstring {.stdcall,
    importc: "lxw_strdup_formula", dynlib: dynlibUtility.}
proc lxw_utf8_strlen*(str: cstring): csize {.stdcall, importc: "lxw_utf8_strlen",
    dynlib: dynlibUtility.}
proc lxw_str_tolower*(str: cstring) {.stdcall, importc: "lxw_str_tolower",
                                   dynlib: dynlibUtility.}
proc lxw_tmpfile*(tmpdir: cstring): ptr FILE {.stdcall, importc: "lxw_tmpfile",
    dynlib: dynlibUtility.}
proc lxw_fopen*(filename: cstring; mode: cstring): ptr FILE {.stdcall,
    importc: "lxw_fopen", dynlib: dynlibUtility.}
proc lxw_hash_password*(password: cstring): uint16 {.stdcall,
    importc: "lxw_hash_password", dynlib: dynlibUtility.}