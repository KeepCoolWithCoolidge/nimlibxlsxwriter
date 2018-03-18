#
# Example of adding an autofilter to a worksheet in Excel using
# nimlibxlsxwriter.
#
# Adapted from autofilter.c by John McNamara, Copyright 2014-2017
#
#

import nimlibxlsxwriter/xlsxwriter

proc main() =
  var workbook: ptr lxw_workbook = workbook_new("autofilter.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Simple data structure to represent the row data.
  type
    row = tuple
      region: string
      item: string
      volume: float32
      month: string
  
  var data: array[50, row] = [(region:"East", item:"Apple", volume:9_000'f32, month:"July"),
                             (region:"East", item:"Apple", volume:5_000'f32, month:"July"),
                             (region:"South", item:"Orange", volume:9_000'f32, month:"September"),
                             (region:"North", item:"Apple", volume:7_000'f32, month:"November"),
                             (region:"West", item:"Apple", volume:9_000'f32, month:"November"),
                             (region:"South", item:"Pear",   volume:  7_000'f32, month:"October" ),
                             (region:"North", item:"Pear",   volume:  9_000'f32, month:"August"  ),
                             (region:"West",  item:"Orange", volume:  1_000'f32, month:"December"),
                             (region:"West",  item:"Grape",  volume:  1_000'f32, month:"November"),
                             (region:"South", item:"Pear",   volume: 10_000'f32, month:"April"   ),
                             (region:"West",  item:"Grape",  volume:  6_000'f32, month:"January" ),
                             (region:"South", item:"Orange", volume:  3_000'f32, month:"May"     ),
                             (region:"North", item:"Apple",  volume:  3_000'f32, month:"December"),
                             (region:"South", item:"Apple",  volume:  7_000'f32, month:"February"),
                             (region:"West",  item:"Grape",  volume:  1_000'f32, month:"December"),
                             (region:"East",  item:"Grape",  volume:  8_000'f32, month:"February"),
                             (region:"South", item:"Grape",  volume: 10_000'f32, month:"June"    ),
                             (region:"West",  item:"Pear",   volume:  7_000'f32, month:"December"),
                             (region:"South", item:"Apple",  volume:  2_000'f32, month:"October" ),
                             (region:"East",  item:"Grape",  volume:  7_000'f32, month:"December"),
                             (region:"North", item:"Grape",  volume:  6_000'f32, month:"April"   ),
                             (region:"East",  item:"Pear",   volume:  8_000'f32, month:"February"),
                             (region:"North", item:"Apple",  volume:  7_000'f32, month:"August"  ),
                             (region:"North", item:"Orange", volume:  7_000'f32, month:"July"    ),
                             (region:"North", item:"Apple",  volume:  6_000'f32, month:"June"    ),
                             (region:"South", item:"Grape",  volume:  8_000'f32, month:"September"),
                             (region:"West",  item:"Apple",  volume:  3_000'f32, month:"October" ),
                             (region:"South", item:"Orange", volume: 10_000'f32, month:"November"),
                             (region:"West",  item:"Grape",  volume:  4_000'f32, month:"July"    ),
                             (region:"North", item:"Orange", volume:  5_000'f32, month:"August"  ),
                             (region:"East",  item:"Orange", volume:  1_000'f32, month:"November"),
                             (region:"East",  item:"Orange", volume:  4_000'f32, month:"October" ),
                             (region:"North", item:"Grape",  volume:  5_000'f32, month:"August"  ),
                             (region:"East",  item:"Apple",  volume:  1_000'f32, month:"December"),
                             (region:"South", item:"Apple",  volume:  10_000'f32,month: "March"  ),
                             (region:"East",  item:"Grape",  volume:  7_000'f32, month:"October" ),
                             (region:"West",  item:"Grape",  volume:  1_000'f32, month:"September"),
                             (region:"East",  item:"Grape",  volume: 10_000'f32, month:"October" ),
                             (region:"South", item:"Orange", volume:  8_000'f32, month:"March"   ),
                             (region:"North", item:"Apple",  volume:  4_000'f32, month:"July"    ),
                             (region:"South", item:"Orange", volume:  5_000'f32, month:"July"    ),
                             (region:"West",  item:"Apple",  volume:  4_000'f32, month:"June"    ),
                             (region:"East",  item:"Apple",  volume:  5_000'f32, month:"April"   ),
                             (region:"North", item:"Pear",   volume:  3_000'f32, month:"August"  ),
                             (region:"East",  item:"Grape",  volume:  9_000'f32, month:"November"),
                             (region:"North", item:"Orange", volume:  8_000'f32, month:"October" ),
                             (region:"East",  item:"Apple",  volume: 10_000'f32, month:"June"    ),
                             (region:"South", item:"Pear",   volume:  1_000'f32, month:"December"),
                             (region:"North", item:"Grape",  volume:  10_000'f32,month: "July"   ),
                             (region:"East",  item:"Grape",  volume:  6_000'f32, month:"February")]

  # Write the column headers.
  discard worksheet_write_string(worksheet, 0, 0, "Region", nil)
  discard worksheet_write_string(worksheet, 0, 1, "Item", nil)
  discard worksheet_write_string(worksheet, 0, 2, "Volume", nil)
  discard worksheet_write_string(worksheet, 0, 3, "Month", nil)

  # Write the row data.
  for i in 0'u32..<data.len:
    discard worksheet_write_string(worksheet, i + 1, 0, data[i].region, nil)
    discard worksheet_write_string(worksheet, i + 1, 1, data[i].item, nil)
    discard worksheet_write_number(worksheet, i + 1, 2, data[i].volume, nil)
    discard worksheet_write_string(worksheet, i + 1, 3, data[i].month, nil)
  
  # Add the autofilter
  discard worksheet_autofilter(worksheet, 0, 0, 50, 3)

  discard workbook_close(workbook)

main()
  
