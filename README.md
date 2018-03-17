Nimlibxlsxwriter is a [Nim](https://nim-lang.org/) wrapper for the [libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) library.

Nimlibxlsxwriter is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimgen](https://github.com/genotrance/nimgen) and [c2nim](https://github.com/nim-lang/c2nim/) to generate the wrappers. The libxlsxwriter source code is downloaded using Git so having ```git``` in the path is required.

__Installation__

Nimlibxlsxwriter can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install nimgen

> nimble install nimlibxlsxwriter
```

__Usage__

```nim
import xlsxwriter

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

__Credits__

Nimlibxlsxwriter wraps the libxlsxwriter source code and all licensing terms of [libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) apply to the usage of this package.

Credits go out to [c2nim](https://github.com/nim-lang/c2nim/) as well without which this package would be greatly limited in its abilities.

__Feedback__

Nimlibxlsxwriter is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/KeepCoolWithCoolidge/nimlibxlsxwriter) and issues, forks and PRs are most appreciated.
