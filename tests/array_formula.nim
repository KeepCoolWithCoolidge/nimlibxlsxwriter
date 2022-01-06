#
# Example of how to use the libxlsxwriter library to write simple
# array formulas.
#
# Adapted from anatomy.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter

proc main() =

  # Create a new workbook and add a worksheet
  var workbook: ptr lxw_workbook = workbook_new("array_formula.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Write some data for the formulas.
  discard worksheet_write_number(worksheet, 0, 1, 500, nil)
  discard worksheet_write_number(worksheet, 1, 1, 10, nil)
  discard worksheet_write_number(worksheet, 4, 1, 1, nil)
  discard worksheet_write_number(worksheet, 5, 1, 2, nil)
  discard worksheet_write_number(worksheet, 6, 1, 3, nil)

  discard worksheet_write_number(worksheet, 0, 2, 300, nil)
  discard worksheet_write_number(worksheet, 1, 2, 15, nil)
  discard worksheet_write_number(worksheet, 4, 2, 20_234, nil)
  discard worksheet_write_number(worksheet, 5, 2, 21_003, nil)
  discard worksheet_write_number(worksheet, 6, 2, 10_000, nil)

  # Write an array formula that returns a single value.
  discard worksheet_write_array_formula(worksheet, 0, 0, 0, 0, "{=SUM(B1:C1*B2:C5)}", nil)

  # Write an array formula that returns a range of values.
  discard worksheet_write_array_formula(worksheet, 4, 0, 6, 0, "{=TREND(C5:C7,B5:B7)}", nil)

  discard workbook_close(workbook)

main()