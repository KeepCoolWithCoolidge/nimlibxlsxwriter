#
# Example of writing a dates and time in Excel using a number with date
# formatting. This demonstrates that dates and times in Excel are just
# formatted real numbers.
#
# Adapted from date_and_times.c by John McNamara, Copyright 2014-2017
#
#

import xlsxwriter

proc main() =
  # A number to display as a date
  var number: float64 = 41333.5

  #  Create a new workbook and add a worksheet
  var workbook: ptr lxw_workbook = new_workbook("date_and_times.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  #  Add a format with date formatting.
  var format: ptr lxw_format = workbook_add_format(workbook)
  format_set_num_format(format, "mmm d yyyy hh:mm AM/PM")

  # Widen the first column to make the text clearer.
  discard worksheet_set_column(worksheet, 0, 0, 20, nil)

  # Write the number without formatting.
  discard worksheet_write_number(worksheet, 0, 0, number, nil) # 41_333.5

  # Write the number with formatting. Note: the worksheet_write_datetime()
  # function is preferable for writing dates and times. This is for
  # demonstration purposes only.
  #
  discard worksheet_write_number(worksheet, 1, 0, number, format) # Feb 28 2013 12:00 PM

  discard workbook_close(workbook)

main()