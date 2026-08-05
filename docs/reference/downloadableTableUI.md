# downloadableTable module UI function

Creates a custom high-functionality table paired with a linked
downloadFile button. The table has search and highlight functionality,
infinite scrolling, sorting by columns and returns a reactive dataset of
selected items.

## Usage

``` r
downloadableTableUI(
  id,
  downloadtypes = NULL,
  hovertext = NULL,
  contentHeight = "200px",
  singleSelect = FALSE
)
```

## Arguments

- id:

  character id for the object

- downloadtypes:

  vector of values for data download types

- hovertext:

  download button tooltip hover text

- contentHeight:

  viewable height of the table (any valid css size value)

- singleSelect:

  whether the table should only allow a single row to be selected at a
  time (FALSE by default allows multi-select).

## Value

list of downloadFileButton UI and DT datatable

## Details

downloadFile button will be hidden if `downloadableTable` parameter
`downloaddatafxn` or `downloadableTableUI` parameter `downloadtypes` is
empty

## Table Features

- Consistent styling of the table

- downloadFile module button functionality built-in to the table (it
  will be shown only if downloadtypes is defined)

- Ability to show different data from the download data

- Table is automatically fit to the window size with infinite
  y-scrolling

- Table search functionality including highlighting built-in

- Multi-select built in, including reactive feedback on which table
  items are selected

## Example

`downloadableTableUI("mytableID", c("csv", "tsv"), "Click Here", "300px")`

## Notes

When there are no rows to download in any of the linked downloaddatafxns
the button will be hidden as there is nothing to download.

## Shiny Usage

Call this function at the place in ui.R where the table should be
placed.

Paired with a call to `downloadableTable(id, ...)` in server.R

## See also

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

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
