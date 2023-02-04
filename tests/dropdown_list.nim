import nimlibxlsxwriter


proc main() =

  # Create a new workbook and add a worksheet
  var workbook: ptr lxw_workbook = workbook_new("dropdown.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  var data_validation = new(lxw_data_validation)
  data_validation.validate = 5 #lxw_validation_types.LXW_VALIDATION_TYPE_LIST
  data_validation.value_list = allocCStringArray(@["open", "closed"])
  discard worksheet_data_validation_cell(worksheet, 0, 0, cast[ptr lxw_data_validation](data_validation))

  discard workbook_close(workbook)

main()
