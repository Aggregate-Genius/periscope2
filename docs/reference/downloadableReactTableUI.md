# downloadableReactTable module UI function

downloadableReactTable module is extending
[`?reactable`](https://glin.github.io/reactable/reference/reactable.html)
package table functions by creating a custom high-functionality table
paired with
[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)
button. The table has the following default functionality:search,
highlight functionality, infinite scrolling, sorting by columns and
returns a reactive dataset of selected items and table current state.

## Usage

``` r
downloadableReactTableUI(id, downloadtypes = NULL, hovertext = NULL)
```

## Arguments

- id:

  character id for the object

- downloadtypes:

  vector of values for data download types

- hovertext:

  download button tooltip hover text

## Value

list of downloadFileButton UI and reactable table and hidden inputs for
contentHeight option

## Details

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)
button will be hidden if `downloadableReactTableUI` parameter
`downloadtypes` is empty

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

`downloadableReactTableUI("mytableID", c("csv", "tsv"), "Click Here")`

## Notes

When there are no rows to download in any of the linked downloaddatafxns
the button will be hidden as there is nothing to download.

## Shiny Usage

Call this function at the place in ui.R where the table should be
placed.

Paired with a call to `downloadableReactTable(id, ...)` in server.R

## See also

[downloadableReactTable](https://aggregate-genius.github.io/periscope2/reference/downloadableReactTable.md)

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

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
 library(reactable)

 shinyApp(
     ui = fluidPage(fluidRow(column(
         width = 12,
         downloadableReactTableUI(
             id            = "object_id1",
             downloadtypes = c("csv", "tsv"),
             hovertext     = "Download the data here!")))),
     server = function(input, output) {
         table_state <- downloadableReactTable(
             id                 = "object_id1",
             table_data         = reactiveVal(iris),
             download_data_fxns = list(csv = reactiveVal(iris), tsv = reactiveVal(iris)),
             selection_mode     = "multiple",
             pre_selected_rows  = function() {c(1, 3, 5)},
             table_options      = list(columns = list(
                 Sepal.Length = colDef(name = "Sepal Length"),
                 Sepal.Width  = colDef(filterable = TRUE),
                 Petal.Length = colDef(show = FALSE),
                 Petal.Width  = colDef(defaultSortOrder = "desc")),
                 showSortable = TRUE,
                 theme = reactableTheme(
                     borderColor = "#dfe2e5",
                     stripedColor = "#f6f8fa",
                     highlightColor = "#f0f5f9",
                     cellPadding = "8px 12px")))

        observeEvent(table_state(), { print(table_state()) })
    })
}
```
