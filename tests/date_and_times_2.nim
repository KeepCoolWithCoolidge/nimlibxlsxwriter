#
# Example of writing a dates and time in Excel using the lxw_datetime
# type and date formatting.
#
# Adapted from date_and_times02.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter/xlsxwriter

proc main() =
  # A datetime to display
  var datetime: lxw_datetime = lxw_datetime(year: 2013, month: 2, day: 28, hour: 12, min: 0, sec: 0.0)

  #  Create a new workbook and add a worksheet
  var workbook: ptr lxw_workbook = new_workbook("date_and_times_2.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  #  Add a format with date formatting.
  var format: ptr lxw_format = workbook_add_format(workbook)
  format_set_num_format(format, "mmm d yyyy hh:mm AM/PM")

  # Widen the first column to make the text clearer.
  discard worksheet_set_column(worksheet, 0, 0, 20, nil)

  # Write the datetime without formatting.
  discard worksheet_write_datetime(worksheet, 0, 0, datetime.addr, nil) # 41_333.5

  # Write the datetime with formatting.
  discard worksheet_write_datetime(worksheet, 1, 0, datetime.addr, format) # Feb 28 2013 12:00 PM

  discard workbook_close(workbook)

main()