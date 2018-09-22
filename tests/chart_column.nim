#
# Example of creating Excel column charts using the nimlibxlsxwriter 
# library
#
# Adapted from chart.c by John McNamara, Copyright 2014-2018
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
  var workbook: ptr lxw_workbook = new_workbook("chart_column.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)
  var series: ptr lxw_chart_series

  # Add a bold format to use to highlight the header cells.
  let bold: ptr lxw_format = workbook_add_format(workbook)
  format_set_bold(bold)

  # Write some data for the chart
  write_worksheet_data(worksheet, bold)

  #
  # Chart 1. Create a column chart.
  #
  var chart: ptr lxw_chart = workbook_add_chart(workbook, LXW_CHART_COLUMN.uint8)

  # Add the first series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")

  # Set the name for the series instead of the default "Series 1".
  chart_series_set_name(series, "=Sheet1!$B1$1")

  # Add a second series but leave the categories and values undefined. They
  # can be defined later using the alternative syntax shown below.
  series = chart_add_series(chart, nil, nil)

  # Configure the series using a syntax that is easier to define programmatically
  chart_series_set_categories(series, "Sheet1", 1, 0, 6, 0) # "=Sheet1!$A$2:$A$7"
  chart_series_set_values(series,     "Sheet1", 1, 2, 6, 2) # "=Sheet1!$C$2:$C$7"
  chart_series_set_name_range(series, "Sheet1", 0, 2)       # "=Sheet1!$C$1"

  # Add a chart title and some axis labels.
  chart_title_set_name(chart, "Results of sample analysis")
  chart_axis_set_name(chart.x_axis, "Test number")
  chart_axis_set_name(chart.y_axis, "Sample length (mm)")

  # Set an Excel chart style
  chart_set_style(chart, 11)

  # Insert the chart into the worksheet.
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E2"), lxw_name_to_col("E2"), chart)

  #
  # Chart 2. Create a stacked column chart.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_COLUMN_STACKED.uint8)

  # Add the first series to the chart.
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")

  # Set the anme for the series instead of the default "Series 1".
  chart_series_set_name(series, "=Sheet1!$B$1")

  # Add the second series to the chart.
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$C$7")

  # Set the name for the series instead of the default "Series 2"
  chart_series_set_name(series, "=Sheet1!$C1$1")

  # Add a chart title and some axis labels.
  chart_title_set_name(chart, "Results of sample analysis")
  chart_axis_set_name(chart.x_axis, "Test number")
  chart_axis_set_name(chart.y_axis, "Sample length (mm)")

  # Set and Excel chart style
  chart_set_style(chart, 12)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E18"), lxw_name_to_col("E18"), chart)

  #
  # Chart 3. Create a percent stacked column chart.
  #
  chart = workbook_add_chart(workbook, LXW_CHART_COLUMN_STACKED_PERCENT.uint8)

  # Add the first series to the chart.
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$B$2:$B$7")

  # Set the name for the series instead of the default "Series 1".
  chart_series_set_name(series, "=Sheet1!$B1$1")

  # Add the second series to the chart
  series = chart_add_series(chart, "=Sheet1!$A$2:$A$7", "=Sheet1!$C$2:$C$7")

  # Set the name for the series instead of the default "Series 2".
  chart_series_set_name(series, "=Sheet1$C1$1")

  # Add a chart title and some axis labels.
  chart_title_set_name(chart, "Results of sample analysis")
  chart_axis_set_name(chart.x_axis, "Test number")
  chart_axis_set_name(chart.y_axis, "Sample length (mm)")

  # Set an Excelchart style
  chart_Set_style(chart, 13)

  # Insert the chart into the worksheet.
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("E34"), lxw_name_to_col("E34"), chart)

  discard workbook_close(workbook)

main()