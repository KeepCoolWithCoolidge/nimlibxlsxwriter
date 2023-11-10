import common
import format
when defined(Windows):
  const dynlibChart = "libxlsxwriter.dll"

when defined(Linux):
  const dynlibChart = "libxlsxwriter.so"

when defined(MacOSX):
  const dynlibChart = "libxlsxwriter.dylib"

# nimlibxlsxwriter/include/xlsxwriter/chart.h --> nimlibxlsxwriter/chart.nim
import os, strutils
# import std/time_t  # To use C "time_t" uncomment this line and use time_t.Time

const sourcePath = currentSourcePath().splitPath.head
{.passC: "-I\"" & sourcePath & "\"".}
{.passC: "-I\"" & sourcePath & "/include\"".}
{.passC: "-I\"" & sourcePath & "/include/xlsxwriter\"".}
const
  LXW_CHART_NUM_FORMAT_LEN* = 128
  LXW_CHART_DEFAULT_GAP* = 501

type

  lxw_chart_type* {.size: sizeof(cint).} = enum
    LXW_CHART_NONE = 0, LXW_CHART_AREA, LXW_CHART_AREA_STACKED,
    LXW_CHART_AREA_STACKED_PERCENT, LXW_CHART_BAR, LXW_CHART_BAR_STACKED,
    LXW_CHART_BAR_STACKED_PERCENT, LXW_CHART_COLUMN, LXW_CHART_COLUMN_STACKED,
    LXW_CHART_COLUMN_STACKED_PERCENT, LXW_CHART_DOUGHNUT, LXW_CHART_LINE,
    LXW_CHART_PIE, LXW_CHART_SCATTER, LXW_CHART_SCATTER_STRAIGHT,
    LXW_CHART_SCATTER_STRAIGHT_WITH_MARKERS, LXW_CHART_SCATTER_SMOOTH,
    LXW_CHART_SCATTER_SMOOTH_WITH_MARKERS, LXW_CHART_RADAR,
    LXW_CHART_RADAR_WITH_MARKERS, LXW_CHART_RADAR_FILLED
  lxw_chart_legend_position* {.size: sizeof(cint).} = enum
    LXW_CHART_LEGEND_NONE = 0, LXW_CHART_LEGEND_RIGHT, LXW_CHART_LEGEND_LEFT,
    LXW_CHART_LEGEND_TOP, LXW_CHART_LEGEND_BOTTOM, LXW_CHART_LEGEND_TOP_RIGHT,
    LXW_CHART_LEGEND_OVERLAY_RIGHT, LXW_CHART_LEGEND_OVERLAY_LEFT,
    LXW_CHART_LEGEND_OVERLAY_TOP_RIGHT
  lxw_chart_line_dash_type* {.size: sizeof(cint).} = enum
    LXW_CHART_LINE_DASH_SOLID = 0, LXW_CHART_LINE_DASH_ROUND_DOT,
    LXW_CHART_LINE_DASH_SQUARE_DOT, LXW_CHART_LINE_DASH_DASH,
    LXW_CHART_LINE_DASH_DASH_DOT, LXW_CHART_LINE_DASH_LONG_DASH,
    LXW_CHART_LINE_DASH_LONG_DASH_DOT, LXW_CHART_LINE_DASH_LONG_DASH_DOT_DOT,
    LXW_CHART_LINE_DASH_DOT, LXW_CHART_LINE_DASH_SYSTEM_DASH_DOT,
    LXW_CHART_LINE_DASH_SYSTEM_DASH_DOT_DOT
  lxw_chart_marker_type* {.size: sizeof(cint).} = enum
    LXW_CHART_MARKER_AUTOMATIC, LXW_CHART_MARKER_NONE, LXW_CHART_MARKER_SQUARE,
    LXW_CHART_MARKER_DIAMOND, LXW_CHART_MARKER_TRIANGLE, LXW_CHART_MARKER_X,
    LXW_CHART_MARKER_STAR, LXW_CHART_MARKER_SHORT_DASH,
    LXW_CHART_MARKER_LONG_DASH, LXW_CHART_MARKER_CIRCLE, LXW_CHART_MARKER_PLUS
  lxw_chart_pattern_type* {.size: sizeof(cint).} = enum
    LXW_CHART_PATTERN_NONE, LXW_CHART_PATTERN_PERCENT_5,
    LXW_CHART_PATTERN_PERCENT_10, LXW_CHART_PATTERN_PERCENT_20,
    LXW_CHART_PATTERN_PERCENT_25, LXW_CHART_PATTERN_PERCENT_30,
    LXW_CHART_PATTERN_PERCENT_40, LXW_CHART_PATTERN_PERCENT_50,
    LXW_CHART_PATTERN_PERCENT_60, LXW_CHART_PATTERN_PERCENT_70,
    LXW_CHART_PATTERN_PERCENT_75, LXW_CHART_PATTERN_PERCENT_80,
    LXW_CHART_PATTERN_PERCENT_90, LXW_CHART_PATTERN_LIGHT_DOWNWARD_DIAGONAL,
    LXW_CHART_PATTERN_LIGHT_UPWARD_DIAGONAL,
    LXW_CHART_PATTERN_DARK_DOWNWARD_DIAGONAL,
    LXW_CHART_PATTERN_DARK_UPWARD_DIAGONAL,
    LXW_CHART_PATTERN_WIDE_DOWNWARD_DIAGONAL,
    LXW_CHART_PATTERN_WIDE_UPWARD_DIAGONAL, LXW_CHART_PATTERN_LIGHT_VERTICAL,
    LXW_CHART_PATTERN_LIGHT_HORIZONTAL, LXW_CHART_PATTERN_NARROW_VERTICAL,
    LXW_CHART_PATTERN_NARROW_HORIZONTAL, LXW_CHART_PATTERN_DARK_VERTICAL,
    LXW_CHART_PATTERN_DARK_HORIZONTAL,
    LXW_CHART_PATTERN_DASHED_DOWNWARD_DIAGONAL,
    LXW_CHART_PATTERN_DASHED_UPWARD_DIAGONAL,
    LXW_CHART_PATTERN_DASHED_HORIZONTAL, LXW_CHART_PATTERN_DASHED_VERTICAL,
    LXW_CHART_PATTERN_SMALL_CONFETTI, LXW_CHART_PATTERN_LARGE_CONFETTI,
    LXW_CHART_PATTERN_ZIGZAG, LXW_CHART_PATTERN_WAVE,
    LXW_CHART_PATTERN_DIAGONAL_BRICK, LXW_CHART_PATTERN_HORIZONTAL_BRICK,
    LXW_CHART_PATTERN_WEAVE, LXW_CHART_PATTERN_PLAID, LXW_CHART_PATTERN_DIVOT,
    LXW_CHART_PATTERN_DOTTED_GRID, LXW_CHART_PATTERN_DOTTED_DIAMOND,
    LXW_CHART_PATTERN_SHINGLE, LXW_CHART_PATTERN_TRELLIS,
    LXW_CHART_PATTERN_SPHERE, LXW_CHART_PATTERN_SMALL_GRID,
    LXW_CHART_PATTERN_LARGE_GRID, LXW_CHART_PATTERN_SMALL_CHECK,
    LXW_CHART_PATTERN_LARGE_CHECK, LXW_CHART_PATTERN_OUTLINED_DIAMOND,
    LXW_CHART_PATTERN_SOLID_DIAMOND
  lxw_chart_label_position* {.size: sizeof(cint).} = enum
    LXW_CHART_LABEL_POSITION_DEFAULT, LXW_CHART_LABEL_POSITION_CENTER,
    LXW_CHART_LABEL_POSITION_RIGHT, LXW_CHART_LABEL_POSITION_LEFT,
    LXW_CHART_LABEL_POSITION_ABOVE, LXW_CHART_LABEL_POSITION_BELOW,
    LXW_CHART_LABEL_POSITION_INSIDE_BASE, LXW_CHART_LABEL_POSITION_INSIDE_END,
    LXW_CHART_LABEL_POSITION_OUTSIDE_END, LXW_CHART_LABEL_POSITION_BEST_FIT
  lxw_chart_label_separator* {.size: sizeof(cint).} = enum
    LXW_CHART_LABEL_SEPARATOR_COMMA, LXW_CHART_LABEL_SEPARATOR_SEMICOLON,
    LXW_CHART_LABEL_SEPARATOR_PERIOD, LXW_CHART_LABEL_SEPARATOR_NEWLINE,
    LXW_CHART_LABEL_SEPARATOR_SPACE
  lxw_chart_axis_type* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_TYPE_X, LXW_CHART_AXIS_TYPE_Y









type
  lxw_chart_subtype* {.size: sizeof(cint).} = enum
    LXW_CHART_SUBTYPE_NONE = 0, LXW_CHART_SUBTYPE_STACKED,
    LXW_CHART_SUBTYPE_STACKED_PERCENT


type
  lxw_chart_grouping* {.size: sizeof(cint).} = enum
    LXW_GROUPING_CLUSTERED, LXW_GROUPING_STANDARD, LXW_GROUPING_PERCENTSTACKED,
    LXW_GROUPING_STACKED


type
  INNER_C_STRUCT_temp_203* {.bycopy.} = object
    stqe_next*: ptr lxw_series_data_point

  lxw_chart_axis_tick_position* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_POSITION_DEFAULT, LXW_CHART_AXIS_POSITION_ON_TICK,
    LXW_CHART_AXIS_POSITION_BETWEEN
  lxw_chart_axis_label_position* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_LABEL_POSITION_NEXT_TO, LXW_CHART_AXIS_LABEL_POSITION_HIGH,
    LXW_CHART_AXIS_LABEL_POSITION_LOW, LXW_CHART_AXIS_LABEL_POSITION_NONE
  lxw_chart_axis_label_alignment* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_LABEL_ALIGN_CENTER, LXW_CHART_AXIS_LABEL_ALIGN_LEFT,
    LXW_CHART_AXIS_LABEL_ALIGN_RIGHT
  lxw_chart_axis_display_unit* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_UNITS_NONE, LXW_CHART_AXIS_UNITS_HUNDREDS,
    LXW_CHART_AXIS_UNITS_THOUSANDS, LXW_CHART_AXIS_UNITS_TEN_THOUSANDS,
    LXW_CHART_AXIS_UNITS_HUNDRED_THOUSANDS, LXW_CHART_AXIS_UNITS_MILLIONS,
    LXW_CHART_AXIS_UNITS_TEN_MILLIONS, LXW_CHART_AXIS_UNITS_HUNDRED_MILLIONS,
    LXW_CHART_AXIS_UNITS_BILLIONS, LXW_CHART_AXIS_UNITS_TRILLIONS
  lxw_chart_tick_mark* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_TICK_MARK_DEFAULT, LXW_CHART_AXIS_TICK_MARK_NONE,
    LXW_CHART_AXIS_TICK_MARK_INSIDE, LXW_CHART_AXIS_TICK_MARK_OUTSIDE,
    LXW_CHART_AXIS_TICK_MARK_CROSSING
  lxw_series_data_points* {.bycopy.} = object
    stqh_first*: ptr lxw_series_data_point
    stqh_last*: ptr ptr lxw_series_data_point
  lxw_series_range* {.bycopy.} = object
    formula*: cstring
    sheetname*: cstring
    first_row*: lxw_row_t
    last_row*: lxw_row_t
    first_col*: lxw_col_t
    last_col*: lxw_col_t
    ignore_cache*: uint8
    has_string_cache*: uint8
    num_data_points*: uint16
    data_cache*: ptr lxw_series_data_points

  lxw_series_data_point* {.bycopy.} = object
    is_string*: uint8
    number*: cdouble
    string*: cstring
    no_data*: uint8
    list_pointers*: INNER_C_STRUCT_temp_203

  lxw_chart_line* {.bycopy.} = object
    color*: lxw_color_t
    none*: uint8
    width*: cfloat
    dash_type*: uint8
    transparency*: uint8

  lxw_chart_fill* {.bycopy.} = object
    color*: lxw_color_t
    none*: uint8
    transparency*: uint8

  lxw_chart_pattern* {.bycopy.} = object
    fg_color*: lxw_color_t
    bg_color*: lxw_color_t
    `type`*: uint8

  lxw_chart_font* {.bycopy.} = object
    name*: cstring
    size*: cdouble
    bold*: uint8
    italic*: uint8
    underline*: uint8
    rotation*: int32
    color*: lxw_color_t
    pitch_family*: uint8
    charset*: uint8
    baseline*: int8

  lxw_chart_marker* {.bycopy.} = object
    `type`*: uint8
    size*: uint8
    line*: ptr lxw_chart_line
    fill*: ptr lxw_chart_fill
    pattern*: ptr lxw_chart_pattern

  lxw_chart_legend* {.bycopy.} = object
    font*: ptr lxw_chart_font
    position*: uint8

  lxw_chart_title* {.bycopy.} = object
    name*: cstring
    row*: lxw_row_t
    col*: lxw_col_t
    font*: ptr lxw_chart_font
    off*: uint8
    is_horizontal*: uint8
    ignore_cache*: uint8
    range*: ptr lxw_series_range
    data_point*: lxw_series_data_point

  lxw_chart_point* {.bycopy.} = object
    line*: ptr lxw_chart_line
    fill*: ptr lxw_chart_fill
    pattern*: ptr lxw_chart_pattern

  lxw_chart_blank* {.size: sizeof(cint).} = enum
    LXW_CHART_BLANKS_AS_GAP, LXW_CHART_BLANKS_AS_ZERO,
    LXW_CHART_BLANKS_AS_CONNECTED







type
  lxw_chart_position* {.size: sizeof(cint).} = enum
    LXW_CHART_AXIS_RIGHT, LXW_CHART_AXIS_LEFT, LXW_CHART_AXIS_TOP,
    LXW_CHART_AXIS_BOTTOM


type
  INNER_C_STRUCT_temp_349* {.bycopy.} = object
    stqe_next*: ptr lxw_chart_series

  INNER_C_STRUCT_temp_457* {.bycopy.} = object
    stqe_next*: ptr lxw_chart

  INNER_C_STRUCT_temp_458* {.bycopy.} = object
    stqe_next*: ptr lxw_chart

  lxw_chart_error_bar_type* {.size: sizeof(cint).} = enum
    LXW_CHART_ERROR_BAR_TYPE_STD_ERROR, LXW_CHART_ERROR_BAR_TYPE_FIXED,
    LXW_CHART_ERROR_BAR_TYPE_PERCENTAGE, LXW_CHART_ERROR_BAR_TYPE_STD_DEV
  lxw_chart_error_bar_direction* {.size: sizeof(cint).} = enum
    LXW_CHART_ERROR_BAR_DIR_BOTH, LXW_CHART_ERROR_BAR_DIR_PLUS,
    LXW_CHART_ERROR_BAR_DIR_MINUS
  lxw_chart_error_bar_axis* {.size: sizeof(cint).} = enum
    LXW_CHART_ERROR_BAR_AXIS_X, LXW_CHART_ERROR_BAR_AXIS_Y
  lxw_chart_error_bar_cap* {.size: sizeof(cint).} = enum
    LXW_CHART_ERROR_BAR_END_CAP, LXW_CHART_ERROR_BAR_NO_CAP
  lxw_series_error_bars* {.bycopy.} = object
    `type`*: uint8
    direction*: uint8
    endcap*: uint8
    has_value*: uint8
    is_set*: uint8
    is_x*: uint8
    chart_group*: uint8
    value*: cdouble
    line*: ptr lxw_chart_line

  lxw_chart_trendline_type* {.size: sizeof(cint).} = enum
    LXW_CHART_TRENDLINE_TYPE_LINEAR, LXW_CHART_TRENDLINE_TYPE_LOG,
    LXW_CHART_TRENDLINE_TYPE_POLY, LXW_CHART_TRENDLINE_TYPE_POWER,
    LXW_CHART_TRENDLINE_TYPE_EXP, LXW_CHART_TRENDLINE_TYPE_AVERAGE
  lxw_chart_series* {.bycopy.} = object
    categories*: ptr lxw_series_range
    values*: ptr lxw_series_range
    title*: lxw_chart_title
    line*: ptr lxw_chart_line
    fill*: ptr lxw_chart_fill
    pattern*: ptr lxw_chart_pattern
    marker*: ptr lxw_chart_marker
    points*: ptr lxw_chart_point
    point_count*: uint16
    smooth*: uint8
    invert_if_negative*: uint8
    has_labels*: uint8
    show_labels_value*: uint8
    show_labels_category*: uint8
    show_labels_name*: uint8
    show_labels_leader*: uint8
    show_labels_legend*: uint8
    show_labels_percent*: uint8
    label_position*: uint8
    label_separator*: uint8
    default_label_position*: uint8
    label_num_format*: cstring
    label_font*: ptr lxw_chart_font
    x_error_bars*: ptr lxw_series_error_bars
    y_error_bars*: ptr lxw_series_error_bars
    has_trendline*: uint8
    has_trendline_forecast*: uint8
    has_trendline_equation*: uint8
    has_trendline_r_squared*: uint8
    has_trendline_intercept*: uint8
    trendline_type*: uint8
    trendline_value*: uint8
    trendline_forward*: cdouble
    trendline_backward*: cdouble
    trendline_value_type*: uint8
    trendline_name*: cstring
    trendline_line*: ptr lxw_chart_line
    trendline_intercept*: cdouble
    list_pointers*: INNER_C_STRUCT_temp_349

  lxw_chart_gridline* {.bycopy.} = object
    visible*: uint8
    line*: ptr lxw_chart_line

  lxw_chart_axis* {.bycopy.} = object
    title*: lxw_chart_title
    num_format*: cstring
    default_num_format*: cstring
    source_linked*: uint8
    major_tick_mark*: uint8
    minor_tick_mark*: uint8
    is_horizontal*: uint8
    major_gridlines*: lxw_chart_gridline
    minor_gridlines*: lxw_chart_gridline
    num_font*: ptr lxw_chart_font
    line*: ptr lxw_chart_line
    fill*: ptr lxw_chart_fill
    pattern*: ptr lxw_chart_pattern
    is_category*: uint8
    is_date*: uint8
    is_value*: uint8
    axis_position*: uint8
    position_axis*: uint8
    label_position*: uint8
    label_align*: uint8
    hidden*: uint8
    reverse*: uint8
    has_min*: uint8
    min*: cdouble
    has_max*: uint8
    max*: cdouble
    has_major_unit*: uint8
    major_unit*: cdouble
    has_minor_unit*: uint8
    minor_unit*: cdouble
    interval_unit*: uint16
    interval_tick*: uint16
    log_base*: uint16
    display_units*: uint8
    display_units_visible*: uint8
    has_crossing*: uint8
    crossing_max*: uint8
    crossing*: cdouble

  lxw_chart_series_list* {.bycopy.} = object
    stqh_first*: ptr lxw_chart_series
    stqh_last*: ptr ptr lxw_chart_series

  lxw_chart* {.bycopy.} = object
    file*: ptr FILE
    `type`*: uint8
    subtype*: uint8
    series_index*: uint16
    write_chart_type*: proc (a1: ptr lxw_chart) {.stdcall.}
    write_plot_area*: proc (a1: ptr lxw_chart) {.stdcall.}
    x_axis*: ptr lxw_chart_axis
    y_axis*: ptr lxw_chart_axis
    title*: lxw_chart_title
    id*: uint32
    axis_id_1*: uint32
    axis_id_2*: uint32
    axis_id_3*: uint32
    axis_id_4*: uint32
    in_use*: uint8
    chart_group*: uint8
    cat_has_num_fmt*: uint8
    is_chartsheet*: uint8
    has_horiz_cat_axis*: uint8
    has_horiz_val_axis*: uint8
    style_id*: uint8
    rotation*: uint16
    hole_size*: uint16
    no_title*: uint8
    has_overlap*: uint8
    overlap_y1*: int8
    overlap_y2*: int8
    gap_y1*: uint16
    gap_y2*: uint16
    grouping*: uint8
    default_cross_between*: uint8
    legend*: lxw_chart_legend
    delete_series*: ptr int16
    delete_series_count*: uint16
    default_marker*: ptr lxw_chart_marker
    chartarea_line*: ptr lxw_chart_line
    chartarea_fill*: ptr lxw_chart_fill
    chartarea_pattern*: ptr lxw_chart_pattern
    plotarea_line*: ptr lxw_chart_line
    plotarea_fill*: ptr lxw_chart_fill
    plotarea_pattern*: ptr lxw_chart_pattern
    has_drop_lines*: uint8
    drop_lines_line*: ptr lxw_chart_line
    has_high_low_lines*: uint8
    high_low_lines_line*: ptr lxw_chart_line
    series_list*: ptr lxw_chart_series_list
    has_table*: uint8
    has_table_vertical*: uint8
    has_table_horizontal*: uint8
    has_table_outline*: uint8
    has_table_legend_keys*: uint8
    table_font*: ptr lxw_chart_font
    show_blanks_as*: uint8
    show_hidden_data*: uint8
    has_up_down_bars*: uint8
    up_bar_line*: ptr lxw_chart_line
    down_bar_line*: ptr lxw_chart_line
    up_bar_fill*: ptr lxw_chart_fill
    down_bar_fill*: ptr lxw_chart_fill
    default_label_position*: uint8
    is_protected*: uint8
    ordered_list_pointers*: INNER_C_STRUCT_temp_457
    list_pointers*: INNER_C_STRUCT_temp_458







proc lxw_chart_new*(`type`: uint8): ptr lxw_chart {.stdcall,
    importc: "lxw_chart_new", dynlib: dynlibChart.}
proc lxw_chart_free*(chart: ptr lxw_chart) {.stdcall, importc: "lxw_chart_free",
    dynlib: dynlibChart.}
proc lxw_chart_assemble_xml_file*(chart: ptr lxw_chart) {.stdcall,
    importc: "lxw_chart_assemble_xml_file", dynlib: dynlibChart.}
proc chart_add_series*(chart: ptr lxw_chart; categories: cstring; values: cstring): ptr lxw_chart_series {.
    stdcall, importc: "chart_add_series", dynlib: dynlibChart.}
proc chart_series_set_categories*(series: ptr lxw_chart_series; sheetname: cstring;
                                 first_row: lxw_row_t; first_col: lxw_col_t;
                                 last_row: lxw_row_t; last_col: lxw_col_t) {.
    stdcall, importc: "chart_series_set_categories", dynlib: dynlibChart.}
proc chart_series_set_values*(series: ptr lxw_chart_series; sheetname: cstring;
                             first_row: lxw_row_t; first_col: lxw_col_t;
                             last_row: lxw_row_t; last_col: lxw_col_t) {.stdcall,
    importc: "chart_series_set_values", dynlib: dynlibChart.}
proc chart_series_set_name*(series: ptr lxw_chart_series; name: cstring) {.stdcall,
    importc: "chart_series_set_name", dynlib: dynlibChart.}
proc chart_series_set_name_range*(series: ptr lxw_chart_series; sheetname: cstring;
                                 row: lxw_row_t; col: lxw_col_t) {.stdcall,
    importc: "chart_series_set_name_range", dynlib: dynlibChart.}
proc chart_series_set_line*(series: ptr lxw_chart_series; line: ptr lxw_chart_line) {.
    stdcall, importc: "chart_series_set_line", dynlib: dynlibChart.}
proc chart_series_set_fill*(series: ptr lxw_chart_series; fill: ptr lxw_chart_fill) {.
    stdcall, importc: "chart_series_set_fill", dynlib: dynlibChart.}
proc chart_series_set_invert_if_negative*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_invert_if_negative", dynlib: dynlibChart.}
proc chart_series_set_pattern*(series: ptr lxw_chart_series;
                              pattern: ptr lxw_chart_pattern) {.stdcall,
    importc: "chart_series_set_pattern", dynlib: dynlibChart.}
proc chart_series_set_marker_type*(series: ptr lxw_chart_series; `type`: uint8) {.
    stdcall, importc: "chart_series_set_marker_type", dynlib: dynlibChart.}
proc chart_series_set_marker_size*(series: ptr lxw_chart_series; size: uint8) {.
    stdcall, importc: "chart_series_set_marker_size", dynlib: dynlibChart.}
proc chart_series_set_marker_line*(series: ptr lxw_chart_series;
                                  line: ptr lxw_chart_line) {.stdcall,
    importc: "chart_series_set_marker_line", dynlib: dynlibChart.}
proc chart_series_set_marker_fill*(series: ptr lxw_chart_series;
                                  fill: ptr lxw_chart_fill) {.stdcall,
    importc: "chart_series_set_marker_fill", dynlib: dynlibChart.}
proc chart_series_set_marker_pattern*(series: ptr lxw_chart_series;
                                     pattern: ptr lxw_chart_pattern) {.stdcall,
    importc: "chart_series_set_marker_pattern", dynlib: dynlibChart.}
proc chart_series_set_points*(series: ptr lxw_chart_series;
                             points: ptr ptr lxw_chart_point): lxw_error {.stdcall,
    importc: "chart_series_set_points", dynlib: dynlibChart.}
proc chart_series_set_smooth*(series: ptr lxw_chart_series; smooth: uint8) {.
    stdcall, importc: "chart_series_set_smooth", dynlib: dynlibChart.}
proc chart_series_set_labels*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_labels", dynlib: dynlibChart.}
proc chart_series_set_labels_options*(series: ptr lxw_chart_series;
                                     show_name: uint8; show_category: uint8;
                                     show_value: uint8) {.stdcall,
    importc: "chart_series_set_labels_options", dynlib: dynlibChart.}
proc chart_series_set_labels_separator*(series: ptr lxw_chart_series;
                                       separator: uint8) {.stdcall,
    importc: "chart_series_set_labels_separator", dynlib: dynlibChart.}
proc chart_series_set_labels_position*(series: ptr lxw_chart_series;
                                      position: uint8) {.stdcall,
    importc: "chart_series_set_labels_position", dynlib: dynlibChart.}
proc chart_series_set_labels_leader_line*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_labels_leader_line", dynlib: dynlibChart.}
proc chart_series_set_labels_legend*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_labels_legend", dynlib: dynlibChart.}
proc chart_series_set_labels_percentage*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_labels_percentage", dynlib: dynlibChart.}
proc chart_series_set_labels_num_format*(series: ptr lxw_chart_series;
                                        num_format: cstring) {.stdcall,
    importc: "chart_series_set_labels_num_format", dynlib: dynlibChart.}
proc chart_series_set_labels_font*(series: ptr lxw_chart_series;
                                  font: ptr lxw_chart_font) {.stdcall,
    importc: "chart_series_set_labels_font", dynlib: dynlibChart.}
proc chart_series_set_trendline*(series: ptr lxw_chart_series; `type`: uint8;
                                value: uint8) {.stdcall,
    importc: "chart_series_set_trendline", dynlib: dynlibChart.}
proc chart_series_set_trendline_forecast*(series: ptr lxw_chart_series;
    forward: cdouble; backward: cdouble) {.stdcall, importc: "chart_series_set_trendline_forecast",
                                       dynlib: dynlibChart.}
proc chart_series_set_trendline_equation*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_trendline_equation", dynlib: dynlibChart.}
proc chart_series_set_trendline_r_squared*(series: ptr lxw_chart_series) {.stdcall,
    importc: "chart_series_set_trendline_r_squared", dynlib: dynlibChart.}
proc chart_series_set_trendline_intercept*(series: ptr lxw_chart_series;
    intercept: cdouble) {.stdcall, importc: "chart_series_set_trendline_intercept",
                        dynlib: dynlibChart.}
proc chart_series_set_trendline_name*(series: ptr lxw_chart_series; name: cstring) {.
    stdcall, importc: "chart_series_set_trendline_name", dynlib: dynlibChart.}
proc chart_series_set_trendline_line*(series: ptr lxw_chart_series;
                                     line: ptr lxw_chart_line) {.stdcall,
    importc: "chart_series_set_trendline_line", dynlib: dynlibChart.}
proc chart_series_get_error_bars*(series: ptr lxw_chart_series;
                                 axis_type: lxw_chart_error_bar_axis): ptr lxw_series_error_bars {.
    stdcall, importc: "chart_series_get_error_bars", dynlib: dynlibChart.}
proc chart_series_set_error_bars*(error_bars: ptr lxw_series_error_bars;
                                 `type`: uint8; value: cdouble) {.stdcall,
    importc: "chart_series_set_error_bars", dynlib: dynlibChart.}
proc chart_series_set_error_bars_direction*(
    error_bars: ptr lxw_series_error_bars; direction: uint8) {.stdcall,
    importc: "chart_series_set_error_bars_direction", dynlib: dynlibChart.}
proc chart_series_set_error_bars_endcap*(error_bars: ptr lxw_series_error_bars;
                                        endcap: uint8) {.stdcall,
    importc: "chart_series_set_error_bars_endcap", dynlib: dynlibChart.}
proc chart_series_set_error_bars_line*(error_bars: ptr lxw_series_error_bars;
                                      line: ptr lxw_chart_line) {.stdcall,
    importc: "chart_series_set_error_bars_line", dynlib: dynlibChart.}
proc chart_axis_get*(chart: ptr lxw_chart; axis_type: lxw_chart_axis_type): ptr lxw_chart_axis {.
    stdcall, importc: "chart_axis_get", dynlib: dynlibChart.}
proc chart_axis_set_name*(axis: ptr lxw_chart_axis; name: cstring) {.stdcall,
    importc: "chart_axis_set_name", dynlib: dynlibChart.}
proc chart_axis_set_name_range*(axis: ptr lxw_chart_axis; sheetname: cstring;
                               row: lxw_row_t; col: lxw_col_t) {.stdcall,
    importc: "chart_axis_set_name_range", dynlib: dynlibChart.}
proc chart_axis_set_name_font*(axis: ptr lxw_chart_axis; font: ptr lxw_chart_font) {.
    stdcall, importc: "chart_axis_set_name_font", dynlib: dynlibChart.}
proc chart_axis_set_num_font*(axis: ptr lxw_chart_axis; font: ptr lxw_chart_font) {.
    stdcall, importc: "chart_axis_set_num_font", dynlib: dynlibChart.}
proc chart_axis_set_num_format*(axis: ptr lxw_chart_axis; num_format: cstring) {.
    stdcall, importc: "chart_axis_set_num_format", dynlib: dynlibChart.}
proc chart_axis_set_line*(axis: ptr lxw_chart_axis; line: ptr lxw_chart_line) {.
    stdcall, importc: "chart_axis_set_line", dynlib: dynlibChart.}
proc chart_axis_set_fill*(axis: ptr lxw_chart_axis; fill: ptr lxw_chart_fill) {.
    stdcall, importc: "chart_axis_set_fill", dynlib: dynlibChart.}
proc chart_axis_set_pattern*(axis: ptr lxw_chart_axis;
                            pattern: ptr lxw_chart_pattern) {.stdcall,
    importc: "chart_axis_set_pattern", dynlib: dynlibChart.}
proc chart_axis_set_reverse*(axis: ptr lxw_chart_axis) {.stdcall,
    importc: "chart_axis_set_reverse", dynlib: dynlibChart.}
proc chart_axis_set_crossing*(axis: ptr lxw_chart_axis; value: cdouble) {.stdcall,
    importc: "chart_axis_set_crossing", dynlib: dynlibChart.}
proc chart_axis_set_crossing_max*(axis: ptr lxw_chart_axis) {.stdcall,
    importc: "chart_axis_set_crossing_max", dynlib: dynlibChart.}
proc chart_axis_off*(axis: ptr lxw_chart_axis) {.stdcall, importc: "chart_axis_off",
    dynlib: dynlibChart.}
proc chart_axis_set_position*(axis: ptr lxw_chart_axis; position: uint8) {.stdcall,
    importc: "chart_axis_set_position", dynlib: dynlibChart.}
proc chart_axis_set_label_position*(axis: ptr lxw_chart_axis; position: uint8) {.
    stdcall, importc: "chart_axis_set_label_position", dynlib: dynlibChart.}
proc chart_axis_set_label_align*(axis: ptr lxw_chart_axis; align: uint8) {.stdcall,
    importc: "chart_axis_set_label_align", dynlib: dynlibChart.}
proc chart_axis_set_min*(axis: ptr lxw_chart_axis; min: cdouble) {.stdcall,
    importc: "chart_axis_set_min", dynlib: dynlibChart.}
proc chart_axis_set_max*(axis: ptr lxw_chart_axis; max: cdouble) {.stdcall,
    importc: "chart_axis_set_max", dynlib: dynlibChart.}
proc chart_axis_set_log_base*(axis: ptr lxw_chart_axis; log_base: uint16) {.stdcall,
    importc: "chart_axis_set_log_base", dynlib: dynlibChart.}
proc chart_axis_set_major_tick_mark*(axis: ptr lxw_chart_axis; `type`: uint8) {.
    stdcall, importc: "chart_axis_set_major_tick_mark", dynlib: dynlibChart.}
proc chart_axis_set_minor_tick_mark*(axis: ptr lxw_chart_axis; `type`: uint8) {.
    stdcall, importc: "chart_axis_set_minor_tick_mark", dynlib: dynlibChart.}
proc chart_axis_set_interval_unit*(axis: ptr lxw_chart_axis; unit: uint16) {.
    stdcall, importc: "chart_axis_set_interval_unit", dynlib: dynlibChart.}
proc chart_axis_set_interval_tick*(axis: ptr lxw_chart_axis; unit: uint16) {.
    stdcall, importc: "chart_axis_set_interval_tick", dynlib: dynlibChart.}
proc chart_axis_set_major_unit*(axis: ptr lxw_chart_axis; unit: cdouble) {.stdcall,
    importc: "chart_axis_set_major_unit", dynlib: dynlibChart.}
proc chart_axis_set_minor_unit*(axis: ptr lxw_chart_axis; unit: cdouble) {.stdcall,
    importc: "chart_axis_set_minor_unit", dynlib: dynlibChart.}
proc chart_axis_set_display_units*(axis: ptr lxw_chart_axis; units: uint8) {.
    stdcall, importc: "chart_axis_set_display_units", dynlib: dynlibChart.}
proc chart_axis_set_display_units_visible*(axis: ptr lxw_chart_axis;
    visible: uint8) {.stdcall, importc: "chart_axis_set_display_units_visible",
                      dynlib: dynlibChart.}
proc chart_axis_major_gridlines_set_visible*(axis: ptr lxw_chart_axis;
    visible: uint8) {.stdcall, importc: "chart_axis_major_gridlines_set_visible",
                      dynlib: dynlibChart.}
proc chart_axis_minor_gridlines_set_visible*(axis: ptr lxw_chart_axis;
    visible: uint8) {.stdcall, importc: "chart_axis_minor_gridlines_set_visible",
                      dynlib: dynlibChart.}
proc chart_axis_major_gridlines_set_line*(axis: ptr lxw_chart_axis;
    line: ptr lxw_chart_line) {.stdcall,
                             importc: "chart_axis_major_gridlines_set_line",
                             dynlib: dynlibChart.}
proc chart_axis_minor_gridlines_set_line*(axis: ptr lxw_chart_axis;
    line: ptr lxw_chart_line) {.stdcall,
                             importc: "chart_axis_minor_gridlines_set_line",
                             dynlib: dynlibChart.}
proc chart_title_set_name*(chart: ptr lxw_chart; name: cstring) {.stdcall,
    importc: "chart_title_set_name", dynlib: dynlibChart.}
proc chart_title_set_name_range*(chart: ptr lxw_chart; sheetname: cstring;
                                row: lxw_row_t; col: lxw_col_t) {.stdcall,
    importc: "chart_title_set_name_range", dynlib: dynlibChart.}
proc chart_title_set_name_font*(chart: ptr lxw_chart; font: ptr lxw_chart_font) {.
    stdcall, importc: "chart_title_set_name_font", dynlib: dynlibChart.}
proc chart_title_off*(chart: ptr lxw_chart) {.stdcall, importc: "chart_title_off",
    dynlib: dynlibChart.}
proc chart_legend_set_position*(chart: ptr lxw_chart; position: uint8) {.stdcall,
    importc: "chart_legend_set_position", dynlib: dynlibChart.}
proc chart_legend_set_font*(chart: ptr lxw_chart; font: ptr lxw_chart_font) {.stdcall,
    importc: "chart_legend_set_font", dynlib: dynlibChart.}
proc chart_legend_delete_series*(chart: ptr lxw_chart; delete_series: ptr int16): lxw_error {.
    stdcall, importc: "chart_legend_delete_series", dynlib: dynlibChart.}
proc chart_chartarea_set_line*(chart: ptr lxw_chart; line: ptr lxw_chart_line) {.
    stdcall, importc: "chart_chartarea_set_line", dynlib: dynlibChart.}
proc chart_chartarea_set_fill*(chart: ptr lxw_chart; fill: ptr lxw_chart_fill) {.
    stdcall, importc: "chart_chartarea_set_fill", dynlib: dynlibChart.}
proc chart_chartarea_set_pattern*(chart: ptr lxw_chart;
                                 pattern: ptr lxw_chart_pattern) {.stdcall,
    importc: "chart_chartarea_set_pattern", dynlib: dynlibChart.}
proc chart_plotarea_set_line*(chart: ptr lxw_chart; line: ptr lxw_chart_line) {.
    stdcall, importc: "chart_plotarea_set_line", dynlib: dynlibChart.}
proc chart_plotarea_set_fill*(chart: ptr lxw_chart; fill: ptr lxw_chart_fill) {.
    stdcall, importc: "chart_plotarea_set_fill", dynlib: dynlibChart.}
proc chart_plotarea_set_pattern*(chart: ptr lxw_chart;
                                pattern: ptr lxw_chart_pattern) {.stdcall,
    importc: "chart_plotarea_set_pattern", dynlib: dynlibChart.}
proc chart_set_style*(chart: ptr lxw_chart; style_id: uint8) {.stdcall,
    importc: "chart_set_style", dynlib: dynlibChart.}
proc chart_set_table*(chart: ptr lxw_chart) {.stdcall, importc: "chart_set_table",
    dynlib: dynlibChart.}
proc chart_set_table_grid*(chart: ptr lxw_chart; horizontal: uint8;
                          vertical: uint8; outline: uint8; legend_keys: uint8) {.
    stdcall, importc: "chart_set_table_grid", dynlib: dynlibChart.}
proc chart_set_table_font*(chart: ptr lxw_chart; font: ptr lxw_chart_font) {.stdcall,
    importc: "chart_set_table_font", dynlib: dynlibChart.}
proc chart_set_up_down_bars*(chart: ptr lxw_chart) {.stdcall,
    importc: "chart_set_up_down_bars", dynlib: dynlibChart.}
proc chart_set_up_down_bars_format*(chart: ptr lxw_chart;
                                   up_bar_line: ptr lxw_chart_line;
                                   up_bar_fill: ptr lxw_chart_fill;
                                   down_bar_line: ptr lxw_chart_line;
                                   down_bar_fill: ptr lxw_chart_fill) {.stdcall,
    importc: "chart_set_up_down_bars_format", dynlib: dynlibChart.}
proc chart_set_drop_lines*(chart: ptr lxw_chart; line: ptr lxw_chart_line) {.stdcall,
    importc: "chart_set_drop_lines", dynlib: dynlibChart.}
proc chart_set_high_low_lines*(chart: ptr lxw_chart; line: ptr lxw_chart_line) {.
    stdcall, importc: "chart_set_high_low_lines", dynlib: dynlibChart.}
proc chart_set_series_overlap*(chart: ptr lxw_chart; overlap: int8) {.stdcall,
    importc: "chart_set_series_overlap", dynlib: dynlibChart.}
proc chart_set_series_gap*(chart: ptr lxw_chart; gap: uint16) {.stdcall,
    importc: "chart_set_series_gap", dynlib: dynlibChart.}
proc chart_show_blanks_as*(chart: ptr lxw_chart; option: uint8) {.stdcall,
    importc: "chart_show_blanks_as", dynlib: dynlibChart.}
proc chart_show_hidden_data*(chart: ptr lxw_chart) {.stdcall,
    importc: "chart_show_hidden_data", dynlib: dynlibChart.}
proc chart_set_rotation*(chart: ptr lxw_chart; rotation: uint16) {.stdcall,
    importc: "chart_set_rotation", dynlib: dynlibChart.}
proc chart_set_hole_size*(chart: ptr lxw_chart; size: uint8) {.stdcall,
    importc: "chart_set_hole_size", dynlib: dynlibChart.}
proc lxw_chart_add_data_cache*(range: ptr lxw_series_range; data: ptr uint8;
                              rows: uint16; cols: uint8; col: uint8): lxw_error {.
    stdcall, importc: "lxw_chart_add_data_cache", dynlib: dynlibChart.}