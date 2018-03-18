#
# Example of writing a dates and time in Excel using different date formats.
#
# Adapted from date_and_times03.c by John McNamara, Copyright 2014-2017
#
#

import xlsxwriter

proc main() =
  # A datetime to display
  var datetime: lxw_datetime = lxw_datetime(year: 2013, month: 1, day: 23, hour: 12, min: 30, sec: 5.123)
  var row: uint32 = 0
  var col: uint16 = 0

  # Examples date and time formats. In the output file compare how changing
  # the format strings changes the apperance of the date.
  var date_formats: seq[string] = @["dd/mm/yy",
                                    "mm/dd/yy",
                                    "dd m yy",
                                    "d mm yy",
                                    "d mmm yy",
                                    "d mmmm yy",
                                    "d mmmm yyyy",
                                    "dd/mm/yy hh:mm",
                                    "dd/mm/yy hh:mm:ss",
                                    "dd/mm/yy hh:mm:ss.000",
                                    "hh:mm",
                                    "hh:mm:ss",
                                    "hh:mm:ss.000"]
  
  # Create a workbook and add a worksheet
  var workbook: ptr lxw_workbook = new_workbook("date_and_times_3.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Add a bold format.
  var bold: ptr lxw_format = workbook_add_format(workbook)
  format_set_bold(bold)

  # Write the column headers.
  discard worksheet_write_string(worksheet, row, col, "Formatted date", bold)
  discard worksheet_write_string(worksheet, row, col + 1, "Format", bold)

  # Widen the first column to make the text clearer.
  discard worksheet_set_column(worksheet, 0, 1, 20, nil)

  # Write the same date and time using each of the above formats.
  for i in 0..<date_formats.len:
    inc(row)

    # Create a format for the date or time.
    var format: ptr lxw_format = workbook_add_format(workbook)
    format_set_num_format(format, date_formats[i])
    format_set_align(format, LXW_ALIGN_LEFT.uint8)

    # Write the datetime with each format.
    discard worksheet_write_datetime(worksheet, row, col, datetime.addr, format)

    # Also write the format string for comparison.
    discard worksheet_write_string(worksheet, row, col + 1, date_formats[i], nil)

  discard workbook_close(workbook)

main()