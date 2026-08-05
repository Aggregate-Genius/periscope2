# downloadableTable module server function

Server-side function for the downloadableTableUI. This is a custom
high-functionality table paired with a linked downloadFile button.

## Usage

``` r
downloadableTable(
  id,
  logger = NULL,
  filenameroot = "download",
  downloaddatafxns = NULL,
  tabledata,
  selection = NULL,
  table_options = list()
)
```

## Arguments

- id:

  the ID of the Module's UI element

- logger:

  logger to use

- filenameroot:

  the text used for user-downloaded file - can be either a character
  string, a reactive expression or a function returning a character
  string

- downloaddatafxns:

  a **named** list of functions providing the data as return values. The
  names for the list should be the same names that were used when the
  table UI was created.

- tabledata:

  function or reactive expression providing the table display data as a
  return value. This function should require no input parameters.

- selection:

  function or reactive expression providing the row_ids of the rows that
  should be selected

- table_options:

  optional table formatting parameters check
  [`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) for
  options full list. Also see example below to see how to pass options

## Value

Reactive expression containing the currently selected rows in the
display table

## Details

downloadFile button will be hidden if `downloadableTable` parameter
`downloaddatafxn` or `downloadableTableUI` parameter `downloadtypes` is
empty

Generated table can highly customized using function
[`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) same
arguments except for `options` and `selection` parameters.

For `options` user can pass the same
[`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) options
using the same names and values one by one separated by comma.

For `selection` parameter it can be either a function or reactive
expression providing the row_ids of the rows that should be selected.

Also, user can apply the same provided
[`?DT::formatCurrency`](https://rdrr.io/pkg/DT/man/formatCurrency.html)
columns formats on passed dataset using format functions names as keys
and their options as a list.

## Notes

- When there are no rows to download in any of the linked
  downloaddatafxns the button will be hidden as there is nothing to
  download.

- `selection` parameter has different usage than DT::datatable
  `selection` option. See parameters usage section.

- DT::datatable options `editable`, `width` and `height` are not
  supported

## Shiny Usage

This function is not called directly by consumers - it is accessed in
server.R using the same id provided in `downloadableTableUI`:

**`downloadableTable(id, logger, filenameroot, downloaddatafxns, tabledata, rownames, caption, selection)`**

*Note*: calling module server returns the reactive expression containing
the currently selected rows in the display table.

## See also

[downloadableTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableTableUI.md)

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

[downloadFile_ValidateTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_ValidateTypes.md)

[downloadFile_AvailableTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_AvailableTypes.md)

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

## Examples

``` r
if (interactive()) {
 library(shiny)
 library(periscope2)
 shinyApp(ui = fluidPage(fluidRow(column(width = 12,
   downloadableTableUI("object_id1",
                       downloadtypes = c("csv", "tsv"),
                       hovertext     = "Download the data here!",
                       contentHeight = "300px",
                       singleSelect  = FALSE)))),
   server = function(input, output) {
     mydataRowIds <- function(){
       rownames(head(mtcars))[c(2, 5)]
     }
     selectedrows <- downloadableTable(
       id               = "object_id1",
       logger           = "",
       filenameroot     = "mydownload1",
       downloaddatafxns = list(csv = reactiveVal(mtcars), tsv = reactiveVal(mtcars)),
       tabledata        = reactiveVal(mtcars),
       selection        = mydataRowIds,
       table_options    = list(rownames = TRUE,
                            caption  = "This is a great table!"))
     observeEvent(selectedrows(), {
       print(selectedrows())
     })})
}
```
