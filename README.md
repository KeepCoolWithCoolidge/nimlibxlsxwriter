# Nimlibxlsxwriter

*This is a working fork from [KeepCoolWithCoolidge](https://github.com/KeepCoolWithCoolidge/nimlibxlsxwriter) updated to work with current versions of Nim.*

# General

Nimlibxlsxwriter is a [Nim](https://nim-lang.org/) wrapper for the [libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) library.

Nimlibxlsxwriter is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and includes the libxlsxwriter source code.

# Installation

Nimlibxlsxwriter can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
$ nimble install nimlibxlsxwriter
# or
$ git clone https://github.com/ThomasTJdev/nimlibxlsxwriter
$ cd nimlibxlsxwriter
$ nimble install
```

# Usage

```nim
import nimlibxlsxwriter/xlsxwriter

proc main() =

  # Create a new workbook and add a worksheet
  var workbook: ptr lxw_workbook = workbook_new("demo.xlsx")
  var worksheet: ptr lxw_worksheet = workbook_add_worksheet(workbook, nil)

  # Add a format.
  var format: ptr lxw_format = workbook_add_format(workbook)

  # Set the bold property for the format
  format_set_bold(format)

  # Change the column width for clarity.
  discard worksheet_set_column(worksheet, 0, 0, 20, nil)

  # Write some simple text.
  discard worksheet_write_string(worksheet, 0, 0, "Hello", nil)

  # Text with formatting.
  discard worksheet_write_string(worksheet, 1, 0, "World", format)

  # Write some numbers.
  discard worksheet_write_number(worksheet, 2, 0, 123, nil)
  discard worksheet_write_number(worksheet, 3, 0, 123.456, nil)

  # Insert an image.
  discard worksheet_insert_image(worksheet, 1, 2, "logo.png");

  discard workbook_close(workbook)

main()
```

Refer to the ```tests``` diretory for examples on how the library can be used.

# Credits

Nimlibxlsxwriter wraps the libxlsxwriter source code and all licensing terms of [libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) apply to the usage of this package.