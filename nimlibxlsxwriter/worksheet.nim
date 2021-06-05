import shared_strings
import chart
import drawing
import common
import format
import styles
import utility
import relationships
when defined(Windows):
  const dynlibWorksheet = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibWorksheet = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibWorksheet = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/worksheet.h --> nimlibxlsxwriter/worksheet.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_ROW_MAX* = 1048576
  LXW_COL_MAX* = 16384
  LXW_COL_META_MAX* = 128
  LXW_HEADER_FOOTER_MAX* = 255
  LXW_MAX_NUMBER_URLS* = 65530
  LXW_PANE_NAME_LENGTH* = 12
  LXW_IMAGE_BUFFER_SIZE* = 1024
  LXW_BREAKS_MAX* = 1023

type
  lxw_gridlines* {.size: sizeof(cint).} = enum
    LXW_HIDE_ALL_GRIDLINES = 0, LXW_SHOW_SCREEN_GRIDLINES, LXW_SHOW_PRINT_GRIDLINES,
    LXW_SHOW_ALL_GRIDLINES


type
  lxw_validation_boolean* {.size: sizeof(cint).} = enum
    LXW_VALIDATION_DEFAULT, LXW_VALIDATION_OFF, LXW_VALIDATION_ON


type
  lxw_validation_types* {.size: sizeof(cint).} = enum
    LXW_VALIDATION_TYPE_NONE, LXW_VALIDATION_TYPE_INTEGER,
    LXW_VALIDATION_TYPE_INTEGER_FORMULA, LXW_VALIDATION_TYPE_DECIMAL,
    LXW_VALIDATION_TYPE_DECIMAL_FORMULA, LXW_VALIDATION_TYPE_LIST,
    LXW_VALIDATION_TYPE_LIST_FORMULA, LXW_VALIDATION_TYPE_DATE,
    LXW_VALIDATION_TYPE_DATE_FORMULA, LXW_VALIDATION_TYPE_DATE_NUMBER,
    LXW_VALIDATION_TYPE_TIME, LXW_VALIDATION_TYPE_TIME_FORMULA,
    LXW_VALIDATION_TYPE_TIME_NUMBER, LXW_VALIDATION_TYPE_LENGTH,
    LXW_VALIDATION_TYPE_LENGTH_FORMULA, LXW_VALIDATION_TYPE_CUSTOM_FORMULA,
    LXW_VALIDATION_TYPE_ANY


type
  lxw_validation_criteria* {.size: sizeof(cint).} = enum
    LXW_VALIDATION_CRITERIA_NONE, LXW_VALIDATION_CRITERIA_BETWEEN,
    LXW_VALIDATION_CRITERIA_NOT_BETWEEN, LXW_VALIDATION_CRITERIA_EQUAL_TO,
    LXW_VALIDATION_CRITERIA_NOT_EQUAL_TO, LXW_VALIDATION_CRITERIA_GREATER_THAN,
    LXW_VALIDATION_CRITERIA_LESS_THAN,
    LXW_VALIDATION_CRITERIA_GREATER_THAN_OR_EQUAL_TO,
    LXW_VALIDATION_CRITERIA_LESS_THAN_OR_EQUAL_TO


type
  lxw_validation_error_types* {.size: sizeof(cint).} = enum
    LXW_VALIDATION_ERROR_TYPE_STOP, LXW_VALIDATION_ERROR_TYPE_WARNING,
    LXW_VALIDATION_ERROR_TYPE_INFORMATION


type
  lxw_comment_display_types* {.size: sizeof(cint).} = enum
    LXW_COMMENT_DISPLAY_DEFAULT, LXW_COMMENT_DISPLAY_HIDDEN,
    LXW_COMMENT_DISPLAY_VISIBLE


type
  lxw_object_position* {.size: sizeof(cint).} = enum
    LXW_OBJECT_POSITION_DEFAULT, LXW_OBJECT_MOVE_AND_SIZE,
    LXW_OBJECT_MOVE_DONT_SIZE, LXW_OBJECT_DONT_MOVE_DONT_SIZE,
    LXW_OBJECT_MOVE_AND_SIZE_AFTER


type
  cell_types* {.size: sizeof(cint).} = enum
    NUMBER_CELL = 1, STRING_CELL, INLINE_STRING_CELL, INLINE_RICH_STRING_CELL,
    FORMULA_CELL, ARRAY_FORMULA_CELL, BLANK_CELL, BOOLEAN_CELL, COMMENT,
    HYPERLINK_URL, HYPERLINK_INTERNAL, HYPERLINK_EXTERNAL


type
  pane_types* {.size: sizeof(cint).} = enum
    NO_PANES = 0, FREEZE_PANES, SPLIT_PANES, FREEZE_SPLIT_PANES


type
  lxw_table_cells* {.bycopy.} = object
    rbh_root*: ptr lxw_cell

  lxw_drawing_rel_ids* {.bycopy.} = object
    rbh_root*: ptr lxw_drawing_rel_id

  lxw_table_rows* {.bycopy.} = object
    rbh_root*: ptr lxw_row
    cached_row*: ptr lxw_row
    cached_row_num*: lxw_row_t

  lxw_merged_ranges* {.bycopy.} = object
    stqh_first*: ptr lxw_merged_range
    stqh_last*: ptr ptr lxw_merged_range

  lxw_selections* {.bycopy.} = object
    stqh_first*: ptr lxw_selection
    stqh_last*: ptr ptr lxw_selection

  lxw_data_validations* {.bycopy.} = object
    stqh_first*: ptr lxw_data_val_obj
    stqh_last*: ptr ptr lxw_data_val_obj

  lxw_image_props* {.bycopy.} = object
    stqh_first*: ptr lxw_object_properties
    stqh_last*: ptr ptr lxw_object_properties

  lxw_chart_props* {.bycopy.} = object
    stqh_first*: ptr lxw_object_properties
    stqh_last*: ptr ptr lxw_object_properties

  lxw_comment_objs* {.bycopy.} = object
    stqh_first*: ptr lxw_vml_obj
    stqh_last*: ptr ptr lxw_vml_obj

  INNER_C_STRUCT_temp_120* {.bycopy.} = object
    stqe_next*: ptr lxw_merged_range

  INNER_C_STRUCT_temp_159* {.bycopy.} = object
    stqe_next*: ptr lxw_selection

  INNER_C_STRUCT_temp_206* {.bycopy.} = object
    stqe_next*: ptr lxw_data_val_obj

  INNER_C_STRUCT_temp_250* {.bycopy.} = object
    stqe_next*: ptr lxw_object_properties

  INNER_C_STRUCT_temp_289* {.bycopy.} = object
    stqe_next*: ptr lxw_vml_obj

  INNER_C_STRUCT_temp_454* {.bycopy.} = object
    stqe_next*: ptr lxw_worksheet

  INNER_C_STRUCT_temp_480* {.bycopy.} = object
    rbe_left*: ptr lxw_row
    rbe_right*: ptr lxw_row
    rbe_parent*: ptr lxw_row
    rbe_color*: cint

  INNER_C_UNION_temp_489* {.bycopy.} = object {.union.}
    number*: cdouble
    string_id*: int32
    string*: cstring

  INNER_C_STRUCT_temp_497* {.bycopy.} = object
    rbe_left*: ptr lxw_cell
    rbe_right*: ptr lxw_cell
    rbe_parent*: ptr lxw_cell
    rbe_color*: cint

  INNER_C_STRUCT_temp_502* {.bycopy.} = object
    rbe_left*: ptr lxw_drawing_rel_id
    rbe_right*: ptr lxw_drawing_rel_id
    rbe_parent*: ptr lxw_drawing_rel_id
    rbe_color*: cint

  lxw_row_col_options* {.bycopy.} = object
    hidden*: uint8
    level*: uint8
    collapsed*: uint8

  lxw_col_options* {.bycopy.} = object
    firstcol*: lxw_col_t
    lastcol*: lxw_col_t
    width*: cdouble
    format*: ptr lxw_format
    hidden*: uint8
    level*: uint8
    collapsed*: uint8

  lxw_merged_range* {.bycopy.} = object
    first_row*: lxw_row_t
    last_row*: lxw_row_t
    first_col*: lxw_col_t
    last_col*: lxw_col_t
    list_pointers*: INNER_C_STRUCT_temp_120

  lxw_repeat_rows* {.bycopy.} = object
    in_use*: uint8
    first_row*: lxw_row_t
    last_row*: lxw_row_t

  lxw_repeat_cols* {.bycopy.} = object
    in_use*: uint8
    first_col*: lxw_col_t
    last_col*: lxw_col_t

  lxw_print_area* {.bycopy.} = object
    in_use*: uint8
    first_row*: lxw_row_t
    last_row*: lxw_row_t
    first_col*: lxw_col_t
    last_col*: lxw_col_t

  lxw_autofilter* {.bycopy.} = object
    in_use*: uint8
    first_row*: lxw_row_t
    last_row*: lxw_row_t
    first_col*: lxw_col_t
    last_col*: lxw_col_t

  lxw_panes* {.bycopy.} = object
    `type`*: uint8
    first_row*: lxw_row_t
    first_col*: lxw_col_t
    top_row*: lxw_row_t
    left_col*: lxw_col_t
    x_split*: cdouble
    y_split*: cdouble

  lxw_selection* {.bycopy.} = object
    pane*: array[12, char]
    active_cell*: array["$XFWD$1048576".len * 2, char]
    sqref*: array["$XFWD$1048576".len * 2, char]
    list_pointers*: INNER_C_STRUCT_temp_159

  lxw_data_validation* {.bycopy.} = object
    validate*: uint8
    criteria*: uint8
    ignore_blank*: uint8
    show_input*: uint8
    show_error*: uint8
    error_type*: uint8
    dropdown*: uint8
    value_number*: cdouble
    value_formula*: cstring
    value_list*: cstringArray
    value_datetime*: lxw_datetime
    minimum_number*: cdouble
    minimum_formula*: cstring
    minimum_datetime*: lxw_datetime
    maximum_number*: cdouble
    maximum_formula*: cstring
    maximum_datetime*: lxw_datetime
    input_title*: cstring
    input_message*: cstring
    error_title*: cstring
    error_message*: cstring

  lxw_data_val_obj* {.bycopy.} = object
    validate*: uint8
    criteria*: uint8
    ignore_blank*: uint8
    show_input*: uint8
    show_error*: uint8
    error_type*: uint8
    dropdown*: uint8
    value_number*: cdouble
    value_formula*: cstring
    value_list*: cstringArray
    minimum_number*: cdouble
    minimum_formula*: cstring
    minimum_datetime*: lxw_datetime
    maximum_number*: cdouble
    maximum_formula*: cstring
    maximum_datetime*: lxw_datetime
    input_title*: cstring
    input_message*: cstring
    error_title*: cstring
    error_message*: cstring
    sqref*: array["$XFWD$1048576".len * 2, char]
    list_pointers*: INNER_C_STRUCT_temp_206

  lxw_image_options* {.bycopy.} = object
    x_offset*: int32
    y_offset*: int32
    x_scale*: cdouble
    y_scale*: cdouble
    object_position*: uint8
    description*: cstring
    url*: cstring
    tip*: cstring

  lxw_chart_options* {.bycopy.} = object
    x_offset*: int32
    y_offset*: int32
    x_scale*: cdouble
    y_scale*: cdouble
    object_position*: uint8

  lxw_object_properties* {.bycopy.} = object
    x_offset*: int32
    y_offset*: int32
    x_scale*: cdouble
    y_scale*: cdouble
    row*: lxw_row_t
    col*: lxw_col_t
    filename*: cstring
    description*: cstring
    url*: cstring
    tip*: cstring
    object_position*: uint8
    stream*: ptr FILE
    image_type*: uint8
    is_image_buffer*: uint8
    image_buffer*: ptr cuchar
    image_buffer_size*: csize
    width*: cdouble
    height*: cdouble
    extension*: cstring
    x_dpi*: cdouble
    y_dpi*: cdouble
    chart*: ptr lxw_chart
    is_duplicate*: uint8
    md5*: cstring
    list_pointers*: INNER_C_STRUCT_temp_250

  lxw_comment_options* {.bycopy.} = object
    visible*: uint8
    author*: cstring
    width*: uint16
    height*: uint16
    x_scale*: cdouble
    y_scale*: cdouble
    color*: lxw_color_t
    font_name*: cstring
    font_size*: cdouble
    font_family*: uint8
    start_row*: lxw_row_t
    start_col*: lxw_col_t
    x_offset*: int32
    y_offset*: int32

  lxw_vml_obj* {.bycopy.} = object
    row*: lxw_row_t
    col*: lxw_col_t
    start_row*: lxw_row_t
    start_col*: lxw_col_t
    x_offset*: int32
    y_offset*: int32
    col_absolute*: uint32
    row_absolute*: uint32
    width*: uint32
    height*: uint32
    color*: lxw_color_t
    font_family*: uint8
    visible*: uint8
    author_id*: uint32
    font_size*: cdouble
    `from`*: lxw_drawing_coords
    to*: lxw_drawing_coords
    author*: cstring
    font_name*: cstring
    text*: cstring
    list_pointers*: INNER_C_STRUCT_temp_289

  lxw_header_footer_options* {.bycopy.} = object
    margin*: cdouble

  lxw_protection* {.bycopy.} = object
    no_select_locked_cells*: uint8
    no_select_unlocked_cells*: uint8
    format_cells*: uint8
    format_columns*: uint8
    format_rows*: uint8
    insert_columns*: uint8
    insert_rows*: uint8
    insert_hyperlinks*: uint8
    delete_columns*: uint8
    delete_rows*: uint8
    sort*: uint8
    autofilter*: uint8
    pivot_tables*: uint8
    scenarios*: uint8
    objects*: uint8
    no_content*: uint8
    no_objects*: uint8

  lxw_protection_obj* {.bycopy.} = object
    no_select_locked_cells*: uint8
    no_select_unlocked_cells*: uint8
    format_cells*: uint8
    format_columns*: uint8
    format_rows*: uint8
    insert_columns*: uint8
    insert_rows*: uint8
    insert_hyperlinks*: uint8
    delete_columns*: uint8
    delete_rows*: uint8
    sort*: uint8
    autofilter*: uint8
    pivot_tables*: uint8
    scenarios*: uint8
    objects*: uint8
    no_content*: uint8
    no_objects*: uint8
    no_sheet*: uint8
    is_configured*: uint8
    hash*: array[5, char]

  lxw_rich_string_tuple* {.bycopy.} = object
    format*: ptr lxw_format
    string*: cstring

  lxw_rel_tuples* = object

  lxw_worksheet* {.bycopy.} = object
    file*: ptr FILE
    optimize_tmpfile*: ptr FILE
    table*: ptr lxw_table_rows
    hyperlinks*: ptr lxw_table_rows
    comments*: ptr lxw_table_rows
    array*: ptr ptr lxw_cell
    merged_ranges*: ptr lxw_merged_ranges
    selections*: ptr lxw_selections
    data_validations*: ptr lxw_data_validations
    image_props*: ptr lxw_image_props
    chart_data*: ptr lxw_chart_props
    drawing_rel_ids*: ptr lxw_drawing_rel_ids
    comment_objs*: ptr lxw_comment_objs
    dim_rowmin*: lxw_row_t
    dim_rowmax*: lxw_row_t
    dim_colmin*: lxw_col_t
    dim_colmax*: lxw_col_t
    sst*: ptr lxw_sst
    name*: cstring
    quoted_name*: cstring
    tmpdir*: cstring
    index*: uint32
    active*: uint8
    selected*: uint8
    hidden*: uint8
    active_sheet*: ptr uint16
    first_sheet*: ptr uint16
    is_chartsheet*: uint8
    col_options*: ptr ptr lxw_col_options
    col_options_max*: uint16
    col_sizes*: ptr cdouble
    col_sizes_max*: uint16
    col_formats*: ptr ptr lxw_format
    col_formats_max*: uint16
    col_size_changed*: uint8
    row_size_changed*: uint8
    optimize*: uint8
    optimize_row*: ptr lxw_row
    fit_height*: uint16
    fit_width*: uint16
    horizontal_dpi*: uint16
    hlink_count*: uint16
    page_start*: uint16
    print_scale*: uint16
    rel_count*: uint16
    vertical_dpi*: uint16
    zoom*: uint16
    filter_on*: uint8
    fit_page*: uint8
    hcenter*: uint8
    orientation*: uint8
    outline_changed*: uint8
    outline_on*: uint8
    outline_style*: uint8
    outline_below*: uint8
    outline_right*: uint8
    page_order*: uint8
    page_setup_changed*: uint8
    page_view*: uint8
    paper_size*: uint8
    print_gridlines*: uint8
    print_headers*: uint8
    print_options_changed*: uint8
    right_to_left*: uint8
    screen_gridlines*: uint8
    show_zeros*: uint8
    vcenter*: uint8
    zoom_scale_normal*: uint8
    num_validations*: uint8
    vba_codename*: cstring
    tab_color*: lxw_color_t
    margin_left*: cdouble
    margin_right*: cdouble
    margin_top*: cdouble
    margin_bottom*: cdouble
    margin_header*: cdouble
    margin_footer*: cdouble
    default_row_height*: cdouble
    default_row_pixels*: uint32
    default_col_pixels*: uint32
    default_row_zeroed*: uint8
    default_row_set*: uint8
    outline_row_level*: uint8
    outline_col_level*: uint8
    header_footer_changed*: uint8
    header*: array[255, char]
    footer*: array[255, char]
    repeat_rows*: lxw_repeat_rows
    repeat_cols*: lxw_repeat_cols
    print_area*: lxw_print_area
    autofilter*: lxw_autofilter
    merged_range_count*: uint16
    max_url_length*: uint16
    hbreaks*: ptr lxw_row_t
    vbreaks*: ptr lxw_col_t
    hbreaks_count*: uint16
    vbreaks_count*: uint16
    drawing_rel_id*: uint32
    external_hyperlinks*: ptr lxw_rel_tuples
    external_drawing_links*: ptr lxw_rel_tuples
    drawing_links*: ptr lxw_rel_tuples
    panes*: lxw_panes
    protection*: lxw_protection_obj
    drawing*: ptr lxw_drawing
    default_url_format*: ptr lxw_format
    has_vml*: uint8
    has_comments*: uint8
    has_header_vml*: uint8
    external_vml_comment_link*: ptr lxw_rel_tuple
    external_comment_link*: ptr lxw_rel_tuple
    comment_author*: cstring
    vml_data_id_str*: cstring
    vml_shape_id*: uint32
    comment_display_default*: uint8
    list_pointers*: INNER_C_STRUCT_temp_454

  lxw_worksheet_init_data* {.bycopy.} = object
    index*: uint32
    hidden*: uint8
    optimize*: uint8
    active_sheet*: ptr uint16
    first_sheet*: ptr uint16
    sst*: ptr lxw_sst
    name*: cstring
    quoted_name*: cstring
    tmpdir*: cstring
    default_url_format*: ptr lxw_format
    max_url_length*: uint16

  lxw_row* {.bycopy.} = object
    row_num*: lxw_row_t
    height*: cdouble
    format*: ptr lxw_format
    hidden*: uint8
    level*: uint8
    collapsed*: uint8
    row_changed*: uint8
    data_changed*: uint8
    height_changed*: uint8
    cells*: ptr lxw_table_cells
    tree_pointers*: INNER_C_STRUCT_temp_480

  lxw_cell* {.bycopy.} = object
    row_num*: lxw_row_t
    col_num*: lxw_col_t
    `type`*: cell_types
    format*: ptr lxw_format
    comment*: ptr lxw_vml_obj
    u*: INNER_C_UNION_temp_489
    formula_result*: cdouble
    user_data1*: cstring
    user_data2*: cstring
    sst_string*: cstring
    tree_pointers*: INNER_C_STRUCT_temp_497

  lxw_drawing_rel_id* {.bycopy.} = object
    id*: uint32
    target*: cstring
    tree_pointers*: INNER_C_STRUCT_temp_502


proc worksheet_write_number*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                            col: lxw_col_t; number: cdouble; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_number", dynlib: dynlibWorksheet.}
proc worksheet_write_string*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                            col: lxw_col_t; string: cstring; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_string", dynlib: dynlibWorksheet.}
proc worksheet_write_formula*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                             col: lxw_col_t; formula: cstring;
                             format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_write_formula", dynlib: dynlibWorksheet.}
proc worksheet_write_array_formula*(worksheet: ptr lxw_worksheet;
                                   first_row: lxw_row_t; first_col: lxw_col_t;
                                   last_row: lxw_row_t; last_col: lxw_col_t;
                                   formula: cstring; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_array_formula", dynlib: dynlibWorksheet.}
proc worksheet_write_array_formula_num*(worksheet: ptr lxw_worksheet;
                                       first_row: lxw_row_t; first_col: lxw_col_t;
                                       last_row: lxw_row_t; last_col: lxw_col_t;
                                       formula: cstring; format: ptr lxw_format;
                                       result: cdouble): lxw_error {.stdcall,
    importc: "worksheet_write_array_formula_num", dynlib: dynlibWorksheet.}
proc worksheet_write_datetime*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                              col: lxw_col_t; datetime: ptr lxw_datetime;
                              format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_write_datetime", dynlib: dynlibWorksheet.}
proc worksheet_write_url*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                         col: lxw_col_t; url: cstring; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_url", dynlib: dynlibWorksheet.}
proc worksheet_write_url_opt*(worksheet: ptr lxw_worksheet; row_num: lxw_row_t;
                             col_num: lxw_col_t; url: cstring;
                             format: ptr lxw_format; string: cstring;
                             tooltip: cstring): lxw_error {.stdcall,
    importc: "worksheet_write_url_opt", dynlib: dynlibWorksheet.}
proc worksheet_write_boolean*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                             col: lxw_col_t; value: cint; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_boolean", dynlib: dynlibWorksheet.}
proc worksheet_write_blank*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                           col: lxw_col_t; format: ptr lxw_format): lxw_error {.
    stdcall, importc: "worksheet_write_blank", dynlib: dynlibWorksheet.}
proc worksheet_write_formula_num*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                 col: lxw_col_t; formula: cstring;
                                 format: ptr lxw_format; result: cdouble): lxw_error {.
    stdcall, importc: "worksheet_write_formula_num", dynlib: dynlibWorksheet.}
proc worksheet_write_rich_string*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                 col: lxw_col_t;
                                 rich_string: ptr ptr lxw_rich_string_tuple;
                                 format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_write_rich_string", dynlib: dynlibWorksheet.}
proc worksheet_write_comment*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                             col: lxw_col_t; string: cstring): lxw_error {.stdcall,
    importc: "worksheet_write_comment", dynlib: dynlibWorksheet.}
proc worksheet_write_comment_opt*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                 col: lxw_col_t; string: cstring;
                                 options: ptr lxw_comment_options): lxw_error {.
    stdcall, importc: "worksheet_write_comment_opt", dynlib: dynlibWorksheet.}
proc worksheet_set_row*(worksheet: ptr lxw_worksheet; row: lxw_row_t; height: cdouble;
                       format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_set_row", dynlib: dynlibWorksheet.}
proc worksheet_set_row_opt*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                           height: cdouble; format: ptr lxw_format;
                           options: ptr lxw_row_col_options): lxw_error {.stdcall,
    importc: "worksheet_set_row_opt", dynlib: dynlibWorksheet.}
proc worksheet_set_column*(worksheet: ptr lxw_worksheet; first_col: lxw_col_t;
                          last_col: lxw_col_t; width: cdouble;
                          format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_set_column", dynlib: dynlibWorksheet.}
proc worksheet_set_column_opt*(worksheet: ptr lxw_worksheet; first_col: lxw_col_t;
                              last_col: lxw_col_t; width: cdouble;
                              format: ptr lxw_format;
                              options: ptr lxw_row_col_options): lxw_error {.
    stdcall, importc: "worksheet_set_column_opt", dynlib: dynlibWorksheet.}
proc worksheet_insert_image*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                            col: lxw_col_t; filename: cstring): lxw_error {.stdcall,
    importc: "worksheet_insert_image", dynlib: dynlibWorksheet.}
proc worksheet_insert_image_opt*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                col: lxw_col_t; filename: cstring;
                                options: ptr lxw_image_options): lxw_error {.
    stdcall, importc: "worksheet_insert_image_opt", dynlib: dynlibWorksheet.}
proc worksheet_insert_image_buffer*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                   col: lxw_col_t; image_buffer: ptr cuchar;
                                   image_size: csize): lxw_error {.stdcall,
    importc: "worksheet_insert_image_buffer", dynlib: dynlibWorksheet.}
proc worksheet_insert_image_buffer_opt*(worksheet: ptr lxw_worksheet;
                                       row: lxw_row_t; col: lxw_col_t;
                                       image_buffer: ptr cuchar; image_size: csize;
                                       options: ptr lxw_image_options): lxw_error {.
    stdcall, importc: "worksheet_insert_image_buffer_opt", dynlib: dynlibWorksheet.}
proc worksheet_insert_chart*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                            col: lxw_col_t; chart: ptr lxw_chart): lxw_error {.
    stdcall, importc: "worksheet_insert_chart", dynlib: dynlibWorksheet.}
proc worksheet_insert_chart_opt*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                col: lxw_col_t; chart: ptr lxw_chart;
                                user_options: ptr lxw_chart_options): lxw_error {.
    stdcall, importc: "worksheet_insert_chart_opt", dynlib: dynlibWorksheet.}
proc worksheet_merge_range*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                           first_col: lxw_col_t; last_row: lxw_row_t;
                           last_col: lxw_col_t; string: cstring;
                           format: ptr lxw_format): lxw_error {.stdcall,
    importc: "worksheet_merge_range", dynlib: dynlibWorksheet.}
proc worksheet_autofilter*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                          first_col: lxw_col_t; last_row: lxw_row_t;
                          last_col: lxw_col_t): lxw_error {.stdcall,
    importc: "worksheet_autofilter", dynlib: dynlibWorksheet.}
proc worksheet_data_validation_cell*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                                    col: lxw_col_t;
                                    validation: ptr lxw_data_validation): lxw_error {.
    stdcall, importc: "worksheet_data_validation_cell", dynlib: dynlibWorksheet.}
proc worksheet_data_validation_range*(worksheet: ptr lxw_worksheet;
                                     first_row: lxw_row_t; first_col: lxw_col_t;
                                     last_row: lxw_row_t; last_col: lxw_col_t;
                                     validation: ptr lxw_data_validation): lxw_error {.
    stdcall, importc: "worksheet_data_validation_range", dynlib: dynlibWorksheet.}
proc worksheet_activate*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_activate", dynlib: dynlibWorksheet.}
proc worksheet_select*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_select", dynlib: dynlibWorksheet.}
proc worksheet_hide*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_hide", dynlib: dynlibWorksheet.}
proc worksheet_set_first_sheet*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_set_first_sheet", dynlib: dynlibWorksheet.}
proc worksheet_freeze_panes*(worksheet: ptr lxw_worksheet; row: lxw_row_t;
                            col: lxw_col_t) {.stdcall,
    importc: "worksheet_freeze_panes", dynlib: dynlibWorksheet.}
proc worksheet_split_panes*(worksheet: ptr lxw_worksheet; vertical: cdouble;
                           horizontal: cdouble) {.stdcall,
    importc: "worksheet_split_panes", dynlib: dynlibWorksheet.}
proc worksheet_freeze_panes_opt*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                                first_col: lxw_col_t; top_row: lxw_row_t;
                                left_col: lxw_col_t; `type`: uint8) {.stdcall,
    importc: "worksheet_freeze_panes_opt", dynlib: dynlibWorksheet.}
proc worksheet_split_panes_opt*(worksheet: ptr lxw_worksheet; vertical: cdouble;
                               horizontal: cdouble; top_row: lxw_row_t;
                               left_col: lxw_col_t) {.stdcall,
    importc: "worksheet_split_panes_opt", dynlib: dynlibWorksheet.}
proc worksheet_set_selection*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                             first_col: lxw_col_t; last_row: lxw_row_t;
                             last_col: lxw_col_t) {.stdcall,
    importc: "worksheet_set_selection", dynlib: dynlibWorksheet.}
proc worksheet_set_landscape*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_set_landscape", dynlib: dynlibWorksheet.}
proc worksheet_set_portrait*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_set_portrait", dynlib: dynlibWorksheet.}
proc worksheet_set_page_view*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_set_page_view", dynlib: dynlibWorksheet.}
proc worksheet_set_paper*(worksheet: ptr lxw_worksheet; paper_type: uint8) {.
    stdcall, importc: "worksheet_set_paper", dynlib: dynlibWorksheet.}
proc worksheet_set_margins*(worksheet: ptr lxw_worksheet; left: cdouble;
                           right: cdouble; top: cdouble; bottom: cdouble) {.stdcall,
    importc: "worksheet_set_margins", dynlib: dynlibWorksheet.}
proc worksheet_set_header*(worksheet: ptr lxw_worksheet; string: cstring): lxw_error {.
    stdcall, importc: "worksheet_set_header", dynlib: dynlibWorksheet.}
proc worksheet_set_footer*(worksheet: ptr lxw_worksheet; string: cstring): lxw_error {.
    stdcall, importc: "worksheet_set_footer", dynlib: dynlibWorksheet.}
proc worksheet_set_header_opt*(worksheet: ptr lxw_worksheet; string: cstring;
                              options: ptr lxw_header_footer_options): lxw_error {.
    stdcall, importc: "worksheet_set_header_opt", dynlib: dynlibWorksheet.}
proc worksheet_set_footer_opt*(worksheet: ptr lxw_worksheet; string: cstring;
                              options: ptr lxw_header_footer_options): lxw_error {.
    stdcall, importc: "worksheet_set_footer_opt", dynlib: dynlibWorksheet.}
proc worksheet_set_h_pagebreaks*(worksheet: ptr lxw_worksheet; breaks: ptr lxw_row_t): lxw_error {.
    stdcall, importc: "worksheet_set_h_pagebreaks", dynlib: dynlibWorksheet.}
proc worksheet_set_v_pagebreaks*(worksheet: ptr lxw_worksheet; breaks: ptr lxw_col_t): lxw_error {.
    stdcall, importc: "worksheet_set_v_pagebreaks", dynlib: dynlibWorksheet.}
proc worksheet_print_across*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_print_across", dynlib: dynlibWorksheet.}
proc worksheet_set_zoom*(worksheet: ptr lxw_worksheet; scale: uint16) {.stdcall,
    importc: "worksheet_set_zoom", dynlib: dynlibWorksheet.}
proc worksheet_gridlines*(worksheet: ptr lxw_worksheet; option: uint8) {.stdcall,
    importc: "worksheet_gridlines", dynlib: dynlibWorksheet.}
proc worksheet_center_horizontally*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_center_horizontally", dynlib: dynlibWorksheet.}
proc worksheet_center_vertically*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_center_vertically", dynlib: dynlibWorksheet.}
proc worksheet_print_row_col_headers*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_print_row_col_headers", dynlib: dynlibWorksheet.}
proc worksheet_repeat_rows*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                           last_row: lxw_row_t): lxw_error {.stdcall,
    importc: "worksheet_repeat_rows", dynlib: dynlibWorksheet.}
proc worksheet_repeat_columns*(worksheet: ptr lxw_worksheet; first_col: lxw_col_t;
                              last_col: lxw_col_t): lxw_error {.stdcall,
    importc: "worksheet_repeat_columns", dynlib: dynlibWorksheet.}
proc worksheet_print_area*(worksheet: ptr lxw_worksheet; first_row: lxw_row_t;
                          first_col: lxw_col_t; last_row: lxw_row_t;
                          last_col: lxw_col_t): lxw_error {.stdcall,
    importc: "worksheet_print_area", dynlib: dynlibWorksheet.}
proc worksheet_fit_to_pages*(worksheet: ptr lxw_worksheet; width: uint16;
                            height: uint16) {.stdcall,
    importc: "worksheet_fit_to_pages", dynlib: dynlibWorksheet.}
proc worksheet_set_start_page*(worksheet: ptr lxw_worksheet; start_page: uint16) {.
    stdcall, importc: "worksheet_set_start_page", dynlib: dynlibWorksheet.}
proc worksheet_set_print_scale*(worksheet: ptr lxw_worksheet; scale: uint16) {.
    stdcall, importc: "worksheet_set_print_scale", dynlib: dynlibWorksheet.}
proc worksheet_right_to_left*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_right_to_left", dynlib: dynlibWorksheet.}
proc worksheet_hide_zero*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_hide_zero", dynlib: dynlibWorksheet.}
proc worksheet_set_tab_color*(worksheet: ptr lxw_worksheet; color: lxw_color_t) {.
    stdcall, importc: "worksheet_set_tab_color", dynlib: dynlibWorksheet.}
proc worksheet_protect*(worksheet: ptr lxw_worksheet; password: cstring;
                       options: ptr lxw_protection) {.stdcall,
    importc: "worksheet_protect", dynlib: dynlibWorksheet.}
proc worksheet_outline_settings*(worksheet: ptr lxw_worksheet; visible: uint8;
                                symbols_below: uint8; symbols_right: uint8;
                                auto_style: uint8) {.stdcall,
    importc: "worksheet_outline_settings", dynlib: dynlibWorksheet.}
proc worksheet_set_default_row*(worksheet: ptr lxw_worksheet; height: cdouble;
                               hide_unused_rows: uint8) {.stdcall,
    importc: "worksheet_set_default_row", dynlib: dynlibWorksheet.}
proc worksheet_set_vba_name*(worksheet: ptr lxw_worksheet; name: cstring): lxw_error {.
    stdcall, importc: "worksheet_set_vba_name", dynlib: dynlibWorksheet.}
proc worksheet_show_comments*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "worksheet_show_comments", dynlib: dynlibWorksheet.}
proc worksheet_set_comments_author*(worksheet: ptr lxw_worksheet; author: cstring) {.
    stdcall, importc: "worksheet_set_comments_author", dynlib: dynlibWorksheet.}
proc lxw_worksheet_new*(init_data: ptr lxw_worksheet_init_data): ptr lxw_worksheet {.
    stdcall, importc: "lxw_worksheet_new", dynlib: dynlibWorksheet.}
proc lxw_worksheet_free*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_free", dynlib: dynlibWorksheet.}
proc lxw_worksheet_assemble_xml_file*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_assemble_xml_file", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_single_row*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_single_row", dynlib: dynlibWorksheet.}
proc lxw_worksheet_prepare_image*(worksheet: ptr lxw_worksheet;
                                 image_ref_id: uint32; drawing_id: uint32;
                                 object_props: ptr lxw_object_properties) {.
    stdcall, importc: "lxw_worksheet_prepare_image", dynlib: dynlibWorksheet.}
proc lxw_worksheet_prepare_chart*(worksheet: ptr lxw_worksheet;
                                 chart_ref_id: uint32; drawing_id: uint32;
                                 object_props: ptr lxw_object_properties;
                                 is_chartsheet: uint8) {.stdcall,
    importc: "lxw_worksheet_prepare_chart", dynlib: dynlibWorksheet.}
proc lxw_worksheet_prepare_vml_objects*(worksheet: ptr lxw_worksheet;
                                       vml_data_id: uint32;
                                       vml_shape_id: uint32;
                                       vml_drawing_id: uint32;
                                       comment_id: uint32): uint32 {.stdcall,
    importc: "lxw_worksheet_prepare_vml_objects", dynlib: dynlibWorksheet.}
proc lxw_worksheet_find_row*(worksheet: ptr lxw_worksheet; row_num: lxw_row_t): ptr lxw_row {.
    stdcall, importc: "lxw_worksheet_find_row", dynlib: dynlibWorksheet.}
proc lxw_worksheet_find_cell_in_row*(row: ptr lxw_row; col_num: lxw_col_t): ptr lxw_cell {.
    stdcall, importc: "lxw_worksheet_find_cell_in_row", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_sheet_views*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_sheet_views", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_page_margins*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_page_margins", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_drawings*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_drawings", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_sheet_protection*(worksheet: ptr lxw_worksheet;
    protect: ptr lxw_protection_obj) {.stdcall, importc: "lxw_worksheet_write_sheet_protection",
                                    dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_sheet_pr*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_sheet_pr", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_page_setup*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_page_setup", dynlib: dynlibWorksheet.}
proc lxw_worksheet_write_header_footer*(worksheet: ptr lxw_worksheet) {.stdcall,
    importc: "lxw_worksheet_write_header_footer", dynlib: dynlibWorksheet.}