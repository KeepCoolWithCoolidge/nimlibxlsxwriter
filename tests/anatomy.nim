#
# Anatomy of a simple libxlsxwriter program.
#
# Adapted from anatomy.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter/xlsxwriter
import strutils

proc main() =

  # Create a new workbook.
  var workbook: ptr lxw_workbook = workbook_new("anatomy.xlsx")

  # Add a worksheet with a user defined sheet name.
  var worksheet1: ptr lxw_worksheet = workbook_add_worksheet(workbook, "Demo")

  # Add a worksheet with Excel's default sheet name: Sheet2.
  var worksheet2: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Add some cell formats
  var myformat1: ptr lxw_format = workbook_add_format(workbook)
  var myformat2: ptr lxw_format = workbook_add_format(workbook)

  # Set the bold property for the first format.
  format_set_bold(myformat1)

  # Set a number format for the second format.
  format_set_num_format(myformat2, "$#,##0.00")

  # Widen the first column to make the text clearer.
  discard worksheet_set_column(worksheet1, 0, 0, 20, nil)

  # Write some unformatted data.
  discard worksheet_write_string(worksheet1, 0, 0, "Peach", nil)
  discard worksheet_write_string(worksheet1, 1, 0, "Plum", nil)

  # Write formatted data.
  discard worksheet_write_string(worksheet1, 3, 0, "Persimmon", myformat1)

  # Write some numbers.
  discard worksheet_write_number(worksheet1, 5, 0, 123, nil)
  discard worksheet_write_number(worksheet1, 6, 0, 4567.555, myformat2)

  # Write to the second worksheet.
  discard worksheet_write_string(worksheet2, 0, 0, "Some text", myformat1)

  # Close the workbook, save the file and free any memory.
  var error = workbook_close(workbook)

  # Check if there was any error creating the xlsx file.
  if error.int != 0:
    echo "Error in workbook_close()\n"
    echo "Error $1 = $2" % [$error, $lxw_strerror(error)]

main()
