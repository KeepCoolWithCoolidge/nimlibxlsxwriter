import queue
import tree
import hash_table
export hash_table.lxw_hash_table
from format import lxw_format

when defined(Windows):
  const dynlibCommon = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibCommon = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibCommon = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/common.h --> nimlibxlsxwriter/common.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_MD5_SIZE* = 16
  LXW_SHEETNAME_MAX* = 31
  LXW_EPOCH_1900* = 0
  LXW_EPOCH_1904* = 1
  LXW_FILENAME_LENGTH* = 128
  LXW_IGNORE* = 1
  LXW_PORTRAIT* = 1
  LXW_LANDSCAPE* = 0

type
  lxw_row_t* = uint32
  lxw_col_t* = uint16
  lxw_boolean* {.size: sizeof(cint).} = enum
    LXW_FALSE, LXW_TRUE


type
  lxw_error* {.size: sizeof(cint).} = enum
    LXW_NO_ERROR = 0, LXW_ERROR_MEMORY_MALLOC_FAILED, LXW_ERROR_CREATING_XLSX_FILE,
    LXW_ERROR_CREATING_TMPFILE, LXW_ERROR_READING_TMPFILE,
    LXW_ERROR_ZIP_FILE_OPERATION, LXW_ERROR_ZIP_PARAMETER_ERROR,
    LXW_ERROR_ZIP_BAD_ZIP_FILE, LXW_ERROR_ZIP_INTERNAL_ERROR,
    LXW_ERROR_ZIP_FILE_ADD, LXW_ERROR_ZIP_CLOSE, LXW_ERROR_FEATURE_NOT_SUPPORTED,
    LXW_ERROR_NULL_PARAMETER_IGNORED, LXW_ERROR_PARAMETER_VALIDATION,
    LXW_ERROR_SHEETNAME_LENGTH_EXCEEDED, LXW_ERROR_INVALID_SHEETNAME_CHARACTER,
    LXW_ERROR_SHEETNAME_START_END_APOSTROPHE, LXW_ERROR_SHEETNAME_ALREADY_USED,
    LXW_ERROR_32_STRING_LENGTH_EXCEEDED, LXW_ERROR_128_STRING_LENGTH_EXCEEDED,
    LXW_ERROR_255_STRING_LENGTH_EXCEEDED, LXW_ERROR_MAX_STRING_LENGTH_EXCEEDED,
    LXW_ERROR_SHARED_STRING_INDEX_NOT_FOUND,
    LXW_ERROR_WORKSHEET_INDEX_OUT_OF_RANGE,
    LXW_ERROR_WORKSHEET_MAX_URL_LENGTH_EXCEEDED,
    LXW_ERROR_WORKSHEET_MAX_NUMBER_URLS_EXCEEDED, LXW_ERROR_IMAGE_DIMENSIONS,
    LXW_MAX_ERRNO
  lxw_datetime* {.bycopy.} = object
    year*: cint
    month*: cint
    day*: cint
    hour*: cint
    min*: cint
    sec*: cdouble



type
  lxw_custom_property_types* {.size: sizeof(cint).} = enum
    LXW_CUSTOM_NONE, LXW_CUSTOM_STRING, LXW_CUSTOM_DOUBLE, LXW_CUSTOM_INTEGER,
    LXW_CUSTOM_BOOLEAN, LXW_CUSTOM_DATETIME


type
  lxw_formats* {.bycopy.} = object
    stqh_first*: ptr lxw_format
    stqh_last*: ptr ptr lxw_format

  lxw_tuples* {.bycopy.} = object
    stqh_first*: ptr lxw_tuple
    stqh_last*: ptr ptr lxw_tuple

  lxw_custom_properties* {.bycopy.} = object
    stqh_first*: ptr lxw_custom_property
    stqh_last*: ptr ptr lxw_custom_property

  INNER_C_STRUCT_temp_69* {.bycopy.} = object
    stqe_next*: ptr lxw_tuple

  INNER_C_UNION_temp_75* {.bycopy.} = object {.union.}
    string*: cstring
    number*: cdouble
    integer*: int32
    boolean*: uint8
    datetime*: lxw_datetime

  INNER_C_STRUCT_temp_81* {.bycopy.} = object
    stqe_next*: ptr lxw_custom_property

  lxw_tuple* {.bycopy.} = object
    key*: cstring
    value*: cstring
    list_pointers*: INNER_C_STRUCT_temp_69

  lxw_custom_property* {.bycopy.} = object
    `type`*: lxw_custom_property_types
    name*: cstring
    u*: INNER_C_UNION_temp_75
    list_pointers*: INNER_C_STRUCT_temp_81

