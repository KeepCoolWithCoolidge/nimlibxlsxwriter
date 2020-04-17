#
# Example of how a simple Excel chart using the nimlibxlsxwriter 
# library
#
# Adapted from chart.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter/xlsxwriter

# Write some data to the worksheet
proc write_worksheet_data(worksheet: ptr lxw_worksheet) =
  var data: array[5, array[3, float64]] = [[1'f64,  2,  3],
                                           [2'f64,  4,  6],
                                           [3'f64,  6,  9],
                                           [4'f64,  8, 12],
                                           [5'f64, 10, 15]]
  
  for row in 0'u32..<5:
    for col in 0'u16..<3:
      discard worksheet_write_number(worksheet, row, col, data[row][col], nil)

proc main() =
  var workbook: ptr lxw_workbook = workbook_new("chart.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Write some data for the chart.
  write_worksheet_data(worksheet)

  # Create a chart object.
  var chart: ptr lxw_chart = workbook_add_chart(workbook, LXW_CHART_COLUMN.uint8)

  # Configure the chart. In simplest case we just add some value data
  # series. The nil categories will default to 1 to 5 like in Excel.
  discard chart_add_series(chart, nil, "Sheet1!$A$1:$A$5")
  discard chart_add_series(chart, nil, "Sheet1!$B$1:$B$5")
  discard chart_add_series(chart, nil, "Sheet1!$C$1:$C$5")

  # Insert the chart into the worksheet.
  discard worksheet_insert_chart(worksheet, 7, 1, chart)

  discard workbook_close(workbook)

main()