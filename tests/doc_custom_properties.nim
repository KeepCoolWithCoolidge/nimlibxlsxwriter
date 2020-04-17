#
# Example of setting custom document properties for an Excel spreadsheet
# using nimlibxlsxwriter.
#
# Adapted from doc_custom_properties.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter/xlsxwriter

proc main() =
  var workbook: ptr lxw_workbook = workbook_new("doc_custom_properties.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)
  var datetime: lxw_datetime = lxw_datetime(year: 2016, month: 12, day: 12, hour: 0, min: 0, sec: 0.0)

  # Set some custom document properties in the workbook
  discard workbook_set_custom_property_string(workbook, "Checked by", "Eve")
  discard workbook_set_custom_property_datetime(workbook, "Date completed", datetime.addr)
  discard workbook_set_custom_property_number(workbook, "Document number", 12345)
  discard workbook_set_custom_property_number(workbook, "Reference number", 1.2345)
  discard workbook_set_custom_property_boolean(workbook, "Has Review", 1)
  discard workbook_set_Custom_property_boolean(workbook, "Signed off", 0)

  # Add some text to the file.
  discard worksheet_set_column(worksheet, 0, 0, 50, nil)
  discard worksheet_write_string(worksheet, 0, 0, "Select 'Workbook Properties' to see properties.", nil)

  discard workbook_close(workbook)

main()

