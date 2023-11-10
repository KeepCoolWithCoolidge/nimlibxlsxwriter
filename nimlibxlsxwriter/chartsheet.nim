import common
import worksheet
import drawing
import utility
import chart
import format

when defined(Windows):
  const dynlibChartsheet = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibChartsheet = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibChartsheet = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/chartsheet.h --> nimlibxlsxwriter/chartsheet.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  INNER_C_STRUCT_temp_17* {.bycopy.} = object
    stqe_next*: ptr lxw_chartsheet

  lxw_chartsheet* {.bycopy.} = object
    file*: ptr FILE
    worksheet*: ptr lxw_worksheet
    chart*: ptr lxw_chart
    protection*: lxw_protection_obj
    is_protected*: uint8
    name*: cstring
    quoted_name*: cstring
    tmpdir*: cstring
    index*: uint32
    active*: uint8
    selected*: uint8
    hidden*: uint8
    active_sheet*: ptr uint16
    first_sheet*: ptr uint16
    rel_count*: uint16
    list_pointers*: INNER_C_STRUCT_temp_17


proc chartsheet_set_chart*(chartsheet: ptr lxw_chartsheet; chart: ptr lxw_chart): lxw_error {.
    stdcall, importc: "chartsheet_set_chart", dynlib: dynlibChartsheet.}
proc chartsheet_set_chart_opt*(chartsheet: ptr lxw_chartsheet; chart: ptr lxw_chart;
                              user_options: ptr lxw_chart_options): lxw_error {.
    stdcall, importc: "chartsheet_set_chart_opt", dynlib: dynlibChartsheet.}
proc chartsheet_activate*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_activate", dynlib: dynlibChartsheet.}
proc chartsheet_select*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_select", dynlib: dynlibChartsheet.}
proc chartsheet_hide*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_hide", dynlib: dynlibChartsheet.}
proc chartsheet_set_first_sheet*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_set_first_sheet", dynlib: dynlibChartsheet.}
proc chartsheet_set_tab_color*(chartsheet: ptr lxw_chartsheet; color: lxw_color_t) {.
    stdcall, importc: "chartsheet_set_tab_color", dynlib: dynlibChartsheet.}
proc chartsheet_protect*(chartsheet: ptr lxw_chartsheet; password: cstring;
                        options: ptr lxw_protection) {.stdcall,
    importc: "chartsheet_protect", dynlib: dynlibChartsheet.}
proc chartsheet_set_zoom*(chartsheet: ptr lxw_chartsheet; scale: uint16) {.stdcall,
    importc: "chartsheet_set_zoom", dynlib: dynlibChartsheet.}
proc chartsheet_set_landscape*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_set_landscape", dynlib: dynlibChartsheet.}
proc chartsheet_set_portrait*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "chartsheet_set_portrait", dynlib: dynlibChartsheet.}
proc chartsheet_set_paper*(chartsheet: ptr lxw_chartsheet; paper_type: uint8) {.
    stdcall, importc: "chartsheet_set_paper", dynlib: dynlibChartsheet.}
proc chartsheet_set_margins*(chartsheet: ptr lxw_chartsheet; left: cdouble;
                            right: cdouble; top: cdouble; bottom: cdouble) {.stdcall,
    importc: "chartsheet_set_margins", dynlib: dynlibChartsheet.}
proc chartsheet_set_header*(chartsheet: ptr lxw_chartsheet; string: cstring): lxw_error {.
    stdcall, importc: "chartsheet_set_header", dynlib: dynlibChartsheet.}
proc chartsheet_set_footer*(chartsheet: ptr lxw_chartsheet; string: cstring): lxw_error {.
    stdcall, importc: "chartsheet_set_footer", dynlib: dynlibChartsheet.}
proc chartsheet_set_header_opt*(chartsheet: ptr lxw_chartsheet; string: cstring;
                               options: ptr lxw_header_footer_options): lxw_error {.
    stdcall, importc: "chartsheet_set_header_opt", dynlib: dynlibChartsheet.}
proc chartsheet_set_footer_opt*(chartsheet: ptr lxw_chartsheet; string: cstring;
                               options: ptr lxw_header_footer_options): lxw_error {.
    stdcall, importc: "chartsheet_set_footer_opt", dynlib: dynlibChartsheet.}
proc lxw_chartsheet_new*(init_data: ptr lxw_worksheet_init_data): ptr lxw_chartsheet {.
    stdcall, importc: "lxw_chartsheet_new", dynlib: dynlibChartsheet.}
proc lxw_chartsheet_free*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "lxw_chartsheet_free", dynlib: dynlibChartsheet.}
proc lxw_chartsheet_assemble_xml_file*(chartsheet: ptr lxw_chartsheet) {.stdcall,
    importc: "lxw_chartsheet_assemble_xml_file", dynlib: dynlibChartsheet.}