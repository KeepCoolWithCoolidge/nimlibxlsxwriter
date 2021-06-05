#
# A demo of an various Excel chart data tools that are available via a 
# nimlibxlsxwriter chart
#
# These include Drop Lines and High-Low Lines
#
# Adapted from chart_data_tools.c by John McNamara, Copyright 2014-2018
#
#

import nimlibxlsxwriter/xlsxwriter

# Write some data to the worksheet
proc write_worksheet_data(worksheet: ptr lxw_worksheet, bold: ptr lxw_format) =
  var data: array[6, array[3, float64]] = [[2'f64,  40,  30],
                                           [3'f64,  40,  25],
                                           [4'f64,  50,  30],
                                           [5'f64,  30,  10],
                                           [6'f64,  25,   5],
                                           [7'f64,  50,  10]]
 
  discard worksheet_write_string(worksheet, 0, 0, "Number", bold)
  discard worksheet_write_string(worksheet, 0, 1, "Batch 1", bold)
  discard worksheet_write_string(worksheet, 0, 2, "Batch 2", bold)

  for row in 0'u32..<6:
    for col in 0'u16..<3:
      discard worksheet_write_number(worksheet, row + 1, col, data[row][col], nil)

# Create a worksheet with examples charts
proc main() =
  var workbook: ptr lxw_workbook = workbook_new("chart_data_tools.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)
  var series: ptr lxw_chart_series

  # Add a bold format to use to highlight the header cells.
  let bold: ptr lxw_format = workbook_add_format(workbook)
  format_set_bold(bold)

  # Write some data for the chart
  write_worksheet_data(worksheet, bold)

  #
  # Chart 1. Example with High Low Lines
  #
  var chart: ptr lxw_chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title
  chart_title_set_name(chart, "Chart with High-low Lines")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$C$7")

  # Add high-low lines to the chart
  chart_set_high_low_lines(chart, nil)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E2"), lxw_name_to_col("E2"), chart)

  #
  # Chart 2. Example with Drop Lines
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title.
  chart_title_set_name(chart, "Chart with Drop Lines")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$B$7")

  # Add drop lines to the chart
  chart_set_drop_lines(chart, nil)

  # Insert the chart into the worksheet.
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E18"), lxw_name_to_col("E18"), chart)

  #
  # Chart 3. Example with Up-Down bars
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart chart_title_set_name
  chart_title_set_name(chart, "Chart with Up-Down bars")

  # Add the first series to the chart.
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$C$7")

  # Add Up-Down bars to the chart.
  chart_set_up_down_bars(chart)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E34"), lxw_name_to_col("E34"), chart)

  #
  # Chart 4. Example with Up-Dow bars with formatting.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title
  chart_title_set_name(chart, "Chart with Up-Down bars")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$B$7")

  var line: lxw_chart_line = lxw_chart_line(color: LXW_COLOR_BLACK.lxw_color_t)
  var up_fill: lxw_chart_fill = lxw_chart_fill(color: 0x00B050)
  var down_fill: lxw_chart_fill = lxw_chart_fill(color: LXW_COLOR_RED.lxw_color_t)

  chart_set_up_down_bars_format(chart, line.addr, up_fill.addr, line.addr, down_fill.addr)

  # Insert the chart into the worksheeet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E50"), lxw_name_to_col("E50"), chart)

  #
  # Chart 5. Example with Markers and data labels.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title
  chart_title_set_name(chart, "Chart with Data Labels and Markers")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$B$7")

  # Add series markers.
  chart_series_set_marker_type(series, LXW_CHART_MARKER_CIRCLE.uint8)

  # Add series data labels.
  chart_series_set_labels(series)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E66"), lxw_name_to_col("E66"), chart)

  #
  # Chart 6. Example with Error Bars.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title
  chart_title_set_name(chart, "Chart with Error Bars")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$B$7")

  # Add error bars to show Standard Error.
  #chart_series_set_error_bars(series.y_error_bars, 
  #                            LXW_CHART_ERROR_BAR_TYPE_STD_ERROR.uint8, 0)
                              
  # Add series data labels.
  chart_series_set_labels(series)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E82"), lxw_name_to_col("E82"), chart)

  #
  # Chart 7. Example with a trendline.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_LINE.uint8)

  # Add a chart title
  chart_title_set_name(chart, "Chart with a Trendline")

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$B$7")

  # Add a polynomial trendline.
  var poly_line: lxw_chart_line = lxw_chart_line(color: LXW_COLOR_GRAY.lxw_color_t,
                                                 dash_type: LXW_CHART_LINE_DASH_LONG_DASH.uint8)
                      
  chart_series_set_trendline(series, LXW_CHART_TRENDLINE_TYPE_POLY.uint8, 3)
  chart_series_set_trendline_line(series, poly_line.addr)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E66"), lxw_name_to_col("E66"), chart)

  discard workbook_close(workbook)

main()