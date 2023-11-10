import worksheet
import chartsheet
import chart
import shared_strings
import hash_table
import common
import times
import format
when defined(Windows):
  const dynlibWorkbook = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibWorkbook = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibWorkbook = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/workbook.h --> nimlibxlsxwriter/workbook.nim
import os, strutils
# import std/Time  # To use C "Time" uncomment this line and use Time.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_DEFINED_NAME_LENGTH* = 128

type
  lxw_worksheet_names* {.bycopy.} = object
    rbh_root*: ptr lxw_worksheet_name

  lxw_chartsheet_names* {.bycopy.} = object
    rbh_root*: ptr lxw_chartsheet_name

  lxw_image_md5s* {.bycopy.} = object
    rbh_root*: ptr lxw_image_md5

  lxw_sheets* {.bycopy.} = object
    stqh_first*: ptr lxw_sheet
    stqh_last*: ptr ptr lxw_sheet

  lxw_worksheets* {.bycopy.} = object
    stqh_first*: ptr lxw_worksheet
    stqh_last*: ptr ptr lxw_worksheet

  lxw_chartsheets* {.bycopy.} = object
    stqh_first*: ptr lxw_chartsheet
    stqh_last*: ptr ptr lxw_chartsheet

  lxw_charts* {.bycopy.} = object
    stqh_first*: ptr lxw_chart
    stqh_last*: ptr ptr lxw_chart

  lxw_defined_names* {.bycopy.} = object
    tqh_first*: ptr lxw_defined_name
    tqh_last*: ptr ptr lxw_defined_name

  INNER_C_UNION_temp_14* {.bycopy.} = object {.union.}
    worksheet*: ptr lxw_worksheet
    chartsheet*: ptr lxw_chartsheet

  INNER_C_STRUCT_temp_17* {.bycopy.} = object
    stqe_next*: ptr lxw_sheet

  INNER_C_STRUCT_temp_22* {.bycopy.} = object
    rbe_left*: ptr lxw_worksheet_name
    rbe_right*: ptr lxw_worksheet_name
    rbe_parent*: ptr lxw_worksheet_name
    rbe_color*: cint

  INNER_C_STRUCT_temp_27* {.bycopy.} = object
    rbe_left*: ptr lxw_chartsheet_name
    rbe_right*: ptr lxw_chartsheet_name
    rbe_parent*: ptr lxw_chartsheet_name
    rbe_color*: cint

  INNER_C_STRUCT_temp_32* {.bycopy.} = object
    rbe_left*: ptr lxw_image_md5
    rbe_right*: ptr lxw_image_md5
    rbe_parent*: ptr lxw_image_md5
    rbe_color*: cint

  INNER_C_STRUCT_temp_42* {.bycopy.} = object
    tqe_next*: ptr lxw_defined_name
    tqe_prev*: ptr ptr lxw_defined_name

  lxw_sheet* {.bycopy.} = object
    is_chartsheet*: uint8
    u*: INNER_C_UNION_temp_14
    list_pointers*: INNER_C_STRUCT_temp_17

  lxw_worksheet_name* {.bycopy.} = object
    name*: cstring
    worksheet*: ptr lxw_worksheet
    tree_pointers*: INNER_C_STRUCT_temp_22

  lxw_chartsheet_name* {.bycopy.} = object
    name*: cstring
    chartsheet*: ptr lxw_chartsheet
    tree_pointers*: INNER_C_STRUCT_temp_27

  lxw_image_md5* {.bycopy.} = object
    id*: uint32
    md5*: cstring
    tree_pointers*: INNER_C_STRUCT_temp_32

  lxw_defined_name* {.bycopy.} = object
    index*: int16
    hidden*: uint8
    name*: array[128, char]
    app_name*: array[128, char]
    formula*: array[128, char]
    normalised_name*: array[128, char]
    normalised_sheetname*: array[128, char]
    list_pointers*: INNER_C_STRUCT_temp_42

  lxw_doc_properties* {.bycopy.} = object
    title*: cstring
    subject*: cstring
    author*: cstring
    manager*: cstring
    company*: cstring
    category*: cstring
    keywords*: cstring
    comments*: cstring
    status*: cstring
    hyperlink_base*: cstring
    created*: Time

  lxw_workbook_options* {.bycopy.} = object
    constant_memory*: uint8
    tmpdir*: cstring
    use_zip64*: uint8

  lxw_workbook* {.bycopy.} = object
    file*: ptr FILE
    sheets*: ptr lxw_sheets
    worksheets*: ptr lxw_worksheets
    chartsheets*: ptr lxw_chartsheets
    worksheet_names*: ptr lxw_worksheet_names
    chartsheet_names*: ptr lxw_chartsheet_names
    image_md5s*: ptr lxw_image_md5s
    charts*: ptr lxw_charts
    ordered_charts*: ptr lxw_charts
    formats*: ptr lxw_formats
    defined_names*: ptr lxw_defined_names
    sst*: ptr lxw_sst
    properties*: ptr lxw_doc_properties
    custom_properties*: ptr lxw_custom_properties
    filename*: cstring
    options*: lxw_workbook_options
    num_sheets*: uint16
    num_worksheets*: uint16
    num_chartsheets*: uint16
    first_sheet*: uint16
    active_sheet*: uint16
    num_xf_formats*: uint16
    num_format_count*: uint16
    drawing_count*: uint16
    comment_count*: uint16
    font_count*: uint16
    border_count*: uint16
    fill_count*: uint16
    optimize*: uint8
    max_url_length*: uint16
    has_png*: uint8
    has_jpeg*: uint8
    has_bmp*: uint8
    has_vml*: uint8
    has_comments*: uint8
    used_xf_formats*: ptr lxw_hash_table
    vba_project*: cstring
    vba_codename*: cstring
    default_url_format*: ptr lxw_format


proc workbook_new*(filename: cstring): ptr lxw_workbook {.stdcall,
    importc: "workbook_new", dynlib: dynlibWorkbook.}
proc workbook_new_opt*(filename: cstring; options: ptr lxw_workbook_options): ptr lxw_workbook {.
    stdcall, importc: "workbook_new_opt", dynlib: dynlibWorkbook.}
proc workbook_add_worksheet*(workbook: ptr lxw_workbook; sheetname: cstring): ptr lxw_worksheet {.
    stdcall, importc: "workbook_add_worksheet", dynlib: dynlibWorkbook.}
proc workbook_add_chartsheet*(workbook: ptr lxw_workbook; sheetname: cstring): ptr lxw_chartsheet {.
    stdcall, importc: "workbook_add_chartsheet", dynlib: dynlibWorkbook.}
proc workbook_add_format*(workbook: ptr lxw_workbook): ptr lxw_format {.stdcall,
    importc: "workbook_add_format", dynlib: dynlibWorkbook.}
proc workbook_add_chart*(workbook: ptr lxw_workbook; chart_type: uint8): ptr lxw_chart {.
    stdcall, importc: "workbook_add_chart", dynlib: dynlibWorkbook.}
proc workbook_close*(workbook: ptr lxw_workbook): lxw_error {.stdcall,
    importc: "workbook_close", dynlib: dynlibWorkbook.}
proc workbook_set_properties*(workbook: ptr lxw_workbook;
                             properties: ptr lxw_doc_properties): lxw_error {.
    stdcall, importc: "workbook_set_properties", dynlib: dynlibWorkbook.}
proc workbook_set_custom_property_string*(workbook: ptr lxw_workbook; name: cstring;
    value: cstring): lxw_error {.stdcall,
                              importc: "workbook_set_custom_property_string",
                              dynlib: dynlibWorkbook.}
proc workbook_set_custom_property_number*(workbook: ptr lxw_workbook; name: cstring;
    value: cdouble): lxw_error {.stdcall,
                              importc: "workbook_set_custom_property_number",
                              dynlib: dynlibWorkbook.}
proc workbook_set_custom_property_integer*(workbook: ptr lxw_workbook;
    name: cstring; value: int32): lxw_error {.stdcall,
    importc: "workbook_set_custom_property_integer", dynlib: dynlibWorkbook.}
proc workbook_set_custom_property_boolean*(workbook: ptr lxw_workbook;
    name: cstring; value: uint8): lxw_error {.stdcall,
    importc: "workbook_set_custom_property_boolean", dynlib: dynlibWorkbook.}
proc workbook_set_custom_property_datetime*(workbook: ptr lxw_workbook;
    name: cstring; datetime: ptr lxw_datetime): lxw_error {.stdcall,
    importc: "workbook_set_custom_property_datetime", dynlib: dynlibWorkbook.}
proc workbook_define_name*(workbook: ptr lxw_workbook; name: cstring; formula: cstring): lxw_error {.
    stdcall, importc: "workbook_define_name", dynlib: dynlibWorkbook.}
proc workbook_get_default_url_format*(workbook: ptr lxw_workbook): ptr lxw_format {.
    stdcall, importc: "workbook_get_default_url_format", dynlib: dynlibWorkbook.}
proc workbook_get_worksheet_by_name*(workbook: ptr lxw_workbook; name: cstring): ptr lxw_worksheet {.
    stdcall, importc: "workbook_get_worksheet_by_name", dynlib: dynlibWorkbook.}
proc workbook_get_chartsheet_by_name*(workbook: ptr lxw_workbook; name: cstring): ptr lxw_chartsheet {.
    stdcall, importc: "workbook_get_chartsheet_by_name", dynlib: dynlibWorkbook.}
proc workbook_validate_sheet_name*(workbook: ptr lxw_workbook; sheetname: cstring): lxw_error {.
    stdcall, importc: "workbook_validate_sheet_name", dynlib: dynlibWorkbook.}
proc workbook_add_vba_project*(workbook: ptr lxw_workbook; filename: cstring): lxw_error {.
    stdcall, importc: "workbook_add_vba_project", dynlib: dynlibWorkbook.}
proc workbook_set_vba_name*(workbook: ptr lxw_workbook; name: cstring): lxw_error {.
    stdcall, importc: "workbook_set_vba_name", dynlib: dynlibWorkbook.}
proc lxw_workbook_free*(workbook: ptr lxw_workbook) {.stdcall,
    importc: "lxw_workbook_free", dynlib: dynlibWorkbook.}
proc lxw_workbook_assemble_xml_file*(workbook: ptr lxw_workbook) {.stdcall,
    importc: "lxw_workbook_assemble_xml_file", dynlib: dynlibWorkbook.}
proc lxw_workbook_set_default_xf_indices*(workbook: ptr lxw_workbook) {.stdcall,
    importc: "lxw_workbook_set_default_xf_indices", dynlib: dynlibWorkbook.}
proc workbook_unset_default_url_format*(workbook: ptr lxw_workbook) {.stdcall,
    importc: "workbook_unset_default_url_format", dynlib: dynlibWorkbook.}