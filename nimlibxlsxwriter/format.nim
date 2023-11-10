import common
when defined(Windows):
  const dynlibFormat = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibFormat = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibFormat = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/format.h --> nimlibxlsxwriter/format.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_FORMAT_FIELD_LEN* = 128
  LXW_DEFAULT_FONT_FAMILY* = 2
  LXW_DEFAULT_FONT_THEME* = 1
  LXW_PROPERTY_UNSET* = -1
  LXW_COLOR_UNSET* = 0x00000000
  LXW_COLOR_MASK* = 0x00000000
  LXW_MIN_FONT_SIZE* = 1.0
  LXW_MAX_FONT_SIZE* = 409.0

type
  lxw_color_t* = uint32
  lxw_format_underlines* {.size: sizeof(cint).} = enum
    LXW_UNDERLINE_NONE = 0, LXW_UNDERLINE_SINGLE, LXW_UNDERLINE_DOUBLE,
    LXW_UNDERLINE_SINGLE_ACCOUNTING, LXW_UNDERLINE_DOUBLE_ACCOUNTING


type
  lxw_format_scripts* {.size: sizeof(cint).} = enum
    LXW_FONT_SUPERSCRIPT = 1, LXW_FONT_SUBSCRIPT


type
  lxw_format_alignments* {.size: sizeof(cint).} = enum
    LXW_ALIGN_NONE = 0, LXW_ALIGN_LEFT, LXW_ALIGN_CENTER, LXW_ALIGN_RIGHT,
    LXW_ALIGN_FILL, LXW_ALIGN_JUSTIFY, LXW_ALIGN_CENTER_ACROSS,
    LXW_ALIGN_DISTRIBUTED, LXW_ALIGN_VERTICAL_TOP, LXW_ALIGN_VERTICAL_BOTTOM,
    LXW_ALIGN_VERTICAL_CENTER, LXW_ALIGN_VERTICAL_JUSTIFY,
    LXW_ALIGN_VERTICAL_DISTRIBUTED


type
  lxw_format_diagonal_types* {.size: sizeof(cint).} = enum
    LXW_DIAGONAL_BORDER_UP = 1, LXW_DIAGONAL_BORDER_DOWN,
    LXW_DIAGONAL_BORDER_UP_DOWN


type
  lxw_defined_colors* {.size: sizeof(cint).} = enum
    LXW_COLOR_NAVY = 0x00000080, LXW_COLOR_BLUE = 0x000000FF,
    LXW_COLOR_GREEN = 0x00008000, LXW_COLOR_LIME = 0x0000FF00,
    LXW_COLOR_CYAN = 0x0000FFFF, LXW_COLOR_BROWN = 0x00800000,
    LXW_COLOR_PURPLE = 0x00800080, LXW_COLOR_GRAY = 0x00808080,
    LXW_COLOR_SILVER = 0x00C0C0C0, LXW_COLOR_RED = 0x00FF0000,
    LXW_COLOR_MAGENTA = 0x00FF00FF, LXW_COLOR_ORANGE = 0x00FF6600,
    LXW_COLOR_YELLOW = 0x00FFFF00, LXW_COLOR_WHITE = 0x00FFFFFF,
    LXW_COLOR_BLACK = 0x01000000

const
  LXW_COLOR_PINK = LXW_COLOR_MAGENTA

type
  lxw_format_patterns* {.size: sizeof(cint).} = enum
    LXW_PATTERN_NONE = 0, LXW_PATTERN_SOLID, LXW_PATTERN_MEDIUM_GRAY,
    LXW_PATTERN_DARK_GRAY, LXW_PATTERN_LIGHT_GRAY, LXW_PATTERN_DARK_HORIZONTAL,
    LXW_PATTERN_DARK_VERTICAL, LXW_PATTERN_DARK_DOWN, LXW_PATTERN_DARK_UP,
    LXW_PATTERN_DARK_GRID, LXW_PATTERN_DARK_TRELLIS, LXW_PATTERN_LIGHT_HORIZONTAL,
    LXW_PATTERN_LIGHT_VERTICAL, LXW_PATTERN_LIGHT_DOWN, LXW_PATTERN_LIGHT_UP,
    LXW_PATTERN_LIGHT_GRID, LXW_PATTERN_LIGHT_TRELLIS, LXW_PATTERN_GRAY_125,
    LXW_PATTERN_GRAY_0625


type
  lxw_format_borders* {.size: sizeof(cint).} = enum
    LXW_BORDER_NONE, LXW_BORDER_THIN, LXW_BORDER_MEDIUM, LXW_BORDER_DASHED,
    LXW_BORDER_DOTTED, LXW_BORDER_THICK, LXW_BORDER_DOUBLE, LXW_BORDER_HAIR,
    LXW_BORDER_MEDIUM_DASHED, LXW_BORDER_DASH_DOT, LXW_BORDER_MEDIUM_DASH_DOT,
    LXW_BORDER_DASH_DOT_DOT, LXW_BORDER_MEDIUM_DASH_DOT_DOT,
    LXW_BORDER_SLANT_DASH_DOT


type
  INNER_C_STRUCT_temp_162* {.bycopy.} = object
    stqe_next*: ptr lxw_format

  lxw_format* {.bycopy.} = object
    file*: ptr FILE
    xf_format_indices*: ptr lxw_hash_table
    num_xf_formats*: ptr uint16
    xf_index*: int32
    dxf_index*: int32
    xf_id*: int32
    num_format*: array[128, char]
    font_name*: array[128, char]
    font_scheme*: array[128, char]
    num_format_index*: uint16
    font_index*: uint16
    has_font*: uint8
    has_dxf_font*: uint8
    font_size*: cdouble
    bold*: uint8
    italic*: uint8
    font_color*: lxw_color_t
    underline*: uint8
    font_strikeout*: uint8
    font_outline*: uint8
    font_shadow*: uint8
    font_script*: uint8
    font_family*: uint8
    font_charset*: uint8
    font_condense*: uint8
    font_extend*: uint8
    theme*: uint8
    hyperlink*: uint8
    hidden*: uint8
    locked*: uint8
    text_h_align*: uint8
    text_wrap*: uint8
    text_v_align*: uint8
    text_justlast*: uint8
    rotation*: int16
    fg_color*: lxw_color_t
    bg_color*: lxw_color_t
    pattern*: uint8
    has_fill*: uint8
    has_dxf_fill*: uint8
    fill_index*: int32
    fill_count*: int32
    border_index*: int32
    has_border*: uint8
    has_dxf_border*: uint8
    border_count*: int32
    bottom*: uint8
    diag_border*: uint8
    diag_type*: uint8
    left*: uint8
    right*: uint8
    top*: uint8
    bottom_color*: lxw_color_t
    diag_color*: lxw_color_t
    left_color*: lxw_color_t
    right_color*: lxw_color_t
    top_color*: lxw_color_t
    indent*: uint8
    shrink*: uint8
    merge_range*: uint8
    reading_order*: uint8
    just_distrib*: uint8
    color_indexed*: uint8
    font_only*: uint8
    list_pointers*: INNER_C_STRUCT_temp_162

  lxw_font* {.bycopy.} = object
    font_name*: array[128, char]
    font_size*: cdouble
    bold*: uint8
    italic*: uint8
    underline*: uint8
    theme*: uint8
    font_strikeout*: uint8
    font_outline*: uint8
    font_shadow*: uint8
    font_script*: uint8
    font_family*: uint8
    font_charset*: uint8
    font_condense*: uint8
    font_extend*: uint8
    font_color*: lxw_color_t

  lxw_border* {.bycopy.} = object
    bottom*: uint8
    diag_border*: uint8
    diag_type*: uint8
    left*: uint8
    right*: uint8
    top*: uint8
    bottom_color*: lxw_color_t
    diag_color*: lxw_color_t
    left_color*: lxw_color_t
    right_color*: lxw_color_t
    top_color*: lxw_color_t

  lxw_fill* {.bycopy.} = object
    fg_color*: lxw_color_t
    bg_color*: lxw_color_t
    pattern*: uint8


proc lxw_format_new*(): ptr lxw_format {.stdcall, importc: "lxw_format_new",
                                     dynlib: dynlibFormat.}
proc lxw_format_free*(format: ptr lxw_format) {.stdcall, importc: "lxw_format_free",
    dynlib: dynlibFormat.}
proc lxw_format_get_xf_index*(format: ptr lxw_format): int32 {.stdcall,
    importc: "lxw_format_get_xf_index", dynlib: dynlibFormat.}
proc lxw_format_get_font_key*(format: ptr lxw_format): ptr lxw_font {.stdcall,
    importc: "lxw_format_get_font_key", dynlib: dynlibFormat.}
proc lxw_format_get_border_key*(format: ptr lxw_format): ptr lxw_border {.stdcall,
    importc: "lxw_format_get_border_key", dynlib: dynlibFormat.}
proc lxw_format_get_fill_key*(format: ptr lxw_format): ptr lxw_fill {.stdcall,
    importc: "lxw_format_get_fill_key", dynlib: dynlibFormat.}
proc format_set_font_name*(format: ptr lxw_format; font_name: cstring) {.stdcall,
    importc: "format_set_font_name", dynlib: dynlibFormat.}
proc format_set_font_size*(format: ptr lxw_format; size: cdouble) {.stdcall,
    importc: "format_set_font_size", dynlib: dynlibFormat.}
proc format_set_font_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_font_color", dynlib: dynlibFormat.}
proc format_set_bold*(format: ptr lxw_format) {.stdcall, importc: "format_set_bold",
    dynlib: dynlibFormat.}
proc format_set_italic*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_italic", dynlib: dynlibFormat.}
proc format_set_underline*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_underline", dynlib: dynlibFormat.}
proc format_set_font_strikeout*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_strikeout", dynlib: dynlibFormat.}
proc format_set_font_script*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_font_script", dynlib: dynlibFormat.}
proc format_set_num_format*(format: ptr lxw_format; num_format: cstring) {.stdcall,
    importc: "format_set_num_format", dynlib: dynlibFormat.}
proc format_set_num_format_index*(format: ptr lxw_format; index: uint8) {.stdcall,
    importc: "format_set_num_format_index", dynlib: dynlibFormat.}
proc format_set_unlocked*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_unlocked", dynlib: dynlibFormat.}
proc format_set_hidden*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_hidden", dynlib: dynlibFormat.}
proc format_set_align*(format: ptr lxw_format; alignment: uint8) {.stdcall,
    importc: "format_set_align", dynlib: dynlibFormat.}
proc format_set_text_wrap*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_text_wrap", dynlib: dynlibFormat.}
proc format_set_rotation*(format: ptr lxw_format; angle: int16) {.stdcall,
    importc: "format_set_rotation", dynlib: dynlibFormat.}
proc format_set_indent*(format: ptr lxw_format; level: uint8) {.stdcall,
    importc: "format_set_indent", dynlib: dynlibFormat.}
proc format_set_shrink*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_shrink", dynlib: dynlibFormat.}
proc format_set_pattern*(format: ptr lxw_format; index: uint8) {.stdcall,
    importc: "format_set_pattern", dynlib: dynlibFormat.}
proc format_set_bg_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_bg_color", dynlib: dynlibFormat.}
proc format_set_fg_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_fg_color", dynlib: dynlibFormat.}
proc format_set_border*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_border", dynlib: dynlibFormat.}
proc format_set_bottom*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_bottom", dynlib: dynlibFormat.}
proc format_set_top*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_top", dynlib: dynlibFormat.}
proc format_set_left*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_left", dynlib: dynlibFormat.}
proc format_set_right*(format: ptr lxw_format; style: uint8) {.stdcall,
    importc: "format_set_right", dynlib: dynlibFormat.}
proc format_set_border_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_border_color", dynlib: dynlibFormat.}
proc format_set_bottom_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_bottom_color", dynlib: dynlibFormat.}
proc format_set_top_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_top_color", dynlib: dynlibFormat.}
proc format_set_left_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_left_color", dynlib: dynlibFormat.}
proc format_set_right_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_right_color", dynlib: dynlibFormat.}
proc format_set_diag_type*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_diag_type", dynlib: dynlibFormat.}
proc format_set_diag_color*(format: ptr lxw_format; color: lxw_color_t) {.stdcall,
    importc: "format_set_diag_color", dynlib: dynlibFormat.}
proc format_set_diag_border*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_diag_border", dynlib: dynlibFormat.}
proc format_set_font_outline*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_outline", dynlib: dynlibFormat.}
proc format_set_font_shadow*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_shadow", dynlib: dynlibFormat.}
proc format_set_font_family*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_font_family", dynlib: dynlibFormat.}
proc format_set_font_charset*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_font_charset", dynlib: dynlibFormat.}
proc format_set_font_scheme*(format: ptr lxw_format; font_scheme: cstring) {.stdcall,
    importc: "format_set_font_scheme", dynlib: dynlibFormat.}
proc format_set_font_condense*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_condense", dynlib: dynlibFormat.}
proc format_set_font_extend*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_extend", dynlib: dynlibFormat.}
proc format_set_reading_order*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_reading_order", dynlib: dynlibFormat.}
proc format_set_theme*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_theme", dynlib: dynlibFormat.}
proc format_set_hyperlink*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_hyperlink", dynlib: dynlibFormat.}
proc format_set_color_indexed*(format: ptr lxw_format; value: uint8) {.stdcall,
    importc: "format_set_color_indexed", dynlib: dynlibFormat.}
proc format_set_font_only*(format: ptr lxw_format) {.stdcall,
    importc: "format_set_font_only", dynlib: dynlibFormat.}