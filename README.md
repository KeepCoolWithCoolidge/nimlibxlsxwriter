# Nimlibxlsxwriter

*This is a working fork from [KeepCoolWithCoolidge](https://github.com/KeepCoolWithCoolidge/nimlibxlsxwriter) updated to work with current versions of Nim.*

# General

Nimlibxlsxwriter is a [Nim](https://nim-lang.org/) wrapper for the
[libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) library.


# OS support

The package only supports Linux. For legacy support of Windows/Mac see [Legacy support](legacy/LEAGACY.md).


# Installation

Nimlibxlsxwriter can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
$ nimble install nimlibxlsxwriter
# or
$ git clone https://github.com/ThomasTJdev/nimlibxlsxwriter
$ cd nimlibxlsxwriter
$ nimble install
```

## Dynamic XLSX library
This is required before installing the nimble package. It might already be
available on your system.

You need to build the original C sourcecode to generate the dynamic library, see
the [how to here](http://libxlsxwriter.github.io/getting_started.html), or you
can cheat, cross your fingers and do it like Github Actions:
```
$ git clone https://github.com/ThomasTJdev/nimlibxlsxwriter
$ cd nimlibxlsxwriter
# Might need `sudo`
$ cp nimlibxlsxwriter/include/libxlsxwriter.so /usr/lib/libxlsxwriter.so
```

# Want more XLSX?

Then checkout:
- [xlsx](https://github.com/xflywind/xlsx): For reading and parsing XLSX files.
- [xlsxio](https://github.com/jiiihpeeh/xlsxio-nim): For reading and writing


# Usage

```nim
import nimlibxlsxwriter

proc main() =

  # Create a new workbook and add a worksheet
  var workbook = workbook_new("demo.xlsx")
  var worksheet = workbook_add_worksheet(workbook, nil)

  # Add a format.
  var format = workbook_add_format(workbook)

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

```nim
import nimlibxlsxwriter

proc main() =

  # Create a new workbook and add a worksheet
  var
    workbook = workbook_new("demo2.xlsx")
    worksheet = workbook_add_worksheet(workbook, nil)

  # Text formats
  var
    formatHeading = workbook_add_format(workbook)
    formatText = workbook_add_format(workbook)

  # Heading
  format_set_bold(formatHeading)
  format_set_bg_color(formatHeading, 0x171921)
  format_set_font_name(formatHeading, "Arial")
  format_set_font_size(formatHeading, 12)
  format_set_font_color(formatHeading, 0xFFFFFF)
  format_set_border(formatHeading, 1)
  format_set_border_color(formatHeading, 0x1000000)
  format_set_align(formatHeading, 10)
  format_set_align(formatHeading, 2)
  format_set_text_wrap(formatHeading)

  # Text
  format_set_bg_color(formatText, 0xFFFFFF)
  format_set_font_name(formatText, "Arial")
  format_set_font_size(formatText, 10)
  format_set_font_color(formatText, 0x1000000)
  format_set_border(formatText, 1)
  format_set_border_color(formatText, 0x1000000)
  format_set_align(formatText, 10)
  format_set_text_wrap(formatText)

  # Write heading
  discard worksheet_write_string(worksheet, 0, 0, "Nim for the win", formatHeading)

  # Write some text
  discard worksheet_set_column(worksheet, 0, 0, 15, nil) # Column width: col-A
  discard worksheet_write_string(worksheet, 1, 0, "A-2: Procedure", formatText) # Write text
  discard worksheet_set_row(worksheet, 1, 35.0, nil) # Change row height: row-2

  discard worksheet_set_column(worksheet, 1, 1, 25, nil) # Column width: col-B
  discard worksheet_write_string(worksheet, 2, 1, "B-3: Long procedure", formatText) # Write text

  # Set print area
  discard worksheet_print_area(worksheet, 0, 0, 2, 1)

  discard workbook_close(workbook)

main()
```

Refer to the ```tests``` diretory for examples on how the library can be used.

# Credits

Nimlibxlsxwriter wraps the libxlsxwriter source code and all licensing terms of
[libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) apply to the usage
of this package.