import common
when defined(Windows):
  const dynlibHashtable = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibHashtable = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibHashtable = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/hash_table.h --> nimlibxlsxwriter/hash_table.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
type
  lxw_hash_order_list* {.bycopy.} = object
    stqh_first*: ptr lxw_hash_element
    stqh_last*: ptr ptr lxw_hash_element

  lxw_hash_bucket_list* {.bycopy.} = object
    slh_first*: ptr lxw_hash_element

  INNER_C_STRUCT_temp_15* {.bycopy.} = object
    stqe_next*: ptr lxw_hash_element

  INNER_C_STRUCT_temp_16* {.bycopy.} = object
    sle_next*: ptr lxw_hash_element

  lxw_hash_table* {.bycopy.} = object
    num_buckets*: uint32
    used_buckets*: uint32
    unique_count*: uint32
    free_key*: uint8
    free_value*: uint8
    order_list*: ptr lxw_hash_order_list
    buckets*: ptr ptr lxw_hash_bucket_list

  lxw_hash_element* {.bycopy.} = object
    key*: pointer
    value*: pointer
    lxw_hash_order_pointers*: INNER_C_STRUCT_temp_15
    lxw_hash_list_pointers*: INNER_C_STRUCT_temp_16


proc lxw_hash_key_exists*(lxw_hash: ptr lxw_hash_table; key: pointer; key_len: csize): ptr lxw_hash_element {.
    stdcall, importc: "lxw_hash_key_exists", dynlib: dynlibHashtable.}
proc lxw_insert_hash_element*(lxw_hash: ptr lxw_hash_table; key: pointer;
                             value: pointer; key_len: csize): ptr lxw_hash_element {.
    stdcall, importc: "lxw_insert_hash_element", dynlib: dynlibHashtable.}
proc lxw_hash_new*(num_buckets: uint32; free_key: uint8; free_value: uint8): ptr lxw_hash_table {.
    stdcall, importc: "lxw_hash_new", dynlib: dynlibHashtable.}
proc lxw_hash_free*(lxw_hash: ptr lxw_hash_table) {.stdcall,
    importc: "lxw_hash_free", dynlib: dynlibHashtable.}