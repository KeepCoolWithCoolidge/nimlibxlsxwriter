#
# An example of a clustered category chart using the libxlsxwriter library.
#
# Adapted from chart_clustered.c by John McNamara, Copyright 2014-2018
#
#
import nimlibxlsxwriter/xlsxwriter

#
# Write some data to the worksheet.
#
proc write_worksheet_data(worksheet: ptr lxw_worksheet, bold: ptr lxw_format) =
  discard worksheet_write_string(worksheet, 0, 0, "Types",     bold)
  discard worksheet_write_string(worksheet, 1, 0, "Type 1",     nil)
  discard worksheet_write_string(worksheet, 4, 0, "Type 2",     nil)
  
  discard worksheet_write_string(worksheet, 0, 1, "Sub Type",  bold)
  discard worksheet_write_string(worksheet, 1, 1, "Sub Type A", nil)
  discard worksheet_write_string(worksheet, 2, 1, "Sub Type B", nil)
  discard worksheet_write_string(worksheet, 3, 1, "Sub Type C", nil)
  discard worksheet_write_string(worksheet, 4, 1, "Sub Type D", nil)
  discard worksheet_write_string(worksheet, 5, 1, "Sub Type E", nil)

  discard worksheet_write_string(worksheet, 0, 2, "Value 1", bold)
  discard worksheet_write_number(worksheet, 1, 2, 5000,       nil)
  discard worksheet_write_number(worksheet, 2, 2, 2000,       nil)
  discard worksheet_write_number(worksheet, 3, 2, 250,        nil)
  discard worksheet_write_number(worksheet, 4, 2, 6000,       nil)
  discard worksheet_write_number(worksheet, 5, 2, 500,        nil)

  discard worksheet_write_string(worksheet, 0, 3, "Value 2", bold)
  discard worksheet_write_number(worksheet, 1, 3, 8000,       nil)
  discard worksheet_write_number(worksheet, 2, 3, 3000,       nil)
  discard worksheet_write_number(worksheet, 3, 3, 1000,       nil)
  discard worksheet_write_number(worksheet, 4, 3, 300,        nil)
  discard worksheet_write_number(worksheet, 5, 3, 300,        nil)

  discard worksheet_write_string(worksheet, 0, 4, "Value 3", bold)
  discard worksheet_write_number(worksheet, 1, 4, 6000,       nil)
  discard worksheet_write_number(worksheet, 2, 4, 4000,       nil)
  discard worksheet_write_number(worksheet, 3, 4, 2000,       nil)
  discard worksheet_write_number(worksheet, 4, 4, 6500,       nil)
  discard worksheet_write_number(worksheet, 5, 4, 200,        nil)
#
# Create a worksheet with examples charts.
#
proc main() =
  var workbook: ptr lxw_workbook = new_workbook("chart_clustered2.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)
  var chart: ptr lxw_chart = workbook_add_chart(workbook, LXW_CHART_COLUMN.uint8)
  var series: ptr lxw_chart_series

  # Add a bold format to use to highlight the header cells.
  let bold: ptr lxw_format = workbook_add_format(workbook)
  format_set_bold(bold)
  
  # Write some data for the chart.
  write_worksheet_data(worksheet, bold)

  # 
  # Configure the series. Note, that the categories are 2D ranges (from
  # column A to column B). This creates the clusters. The series are shown
  # as formula strings for clarity but you can also use variables with the
  # chart_series_set_categories() and chart_series_set_values()
  # procedures. See the docs.
  #
  series = chart_add_series(chart, "=Sheet1!$A$2:$B$6", "=Sheet1!$C$2:$C$6")
  series = chart_add_series(chart, "=Sheet1!$A$2:$B$6", "=Sheet1!$D$2:$D$6")
  series = chart_add_series(chart, "=Sheet1!$A$2:$B$6", "=Sheet1!$E$2:$E$6")
  
  # Set an Excel chart style.
  chart_set_style(chart, 37)

  # Turn off the legend
  chart_legend_set_position(chart, LXW_CHART_LEGEND_NONE.uint8)

  # Insert the chart into the worksheet
  discard worksheet_insert_chart(worksheet, lxw_name_to_row("G3"), lxw_name_to_col("G3"), chart)
  discard workbook_close(workbook)

main()