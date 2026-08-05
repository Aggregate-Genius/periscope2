# downloadableReactTable module server function

Server-side function for the downloadableReactTableUI.

## Usage

``` r
downloadableReactTable(
  id,
  table_data,
  selection_mode = NULL,
  pre_selected_rows = NULL,
  file_name_root = "data_file",
  download_data_fxns = NULL,
  pagination = FALSE,
  table_height = 600,
  show_rownames = FALSE,
  columns_filter = FALSE,
  global_search = TRUE,
  row_highlight = TRUE,
  row_striping = TRUE,
  table_options = list(),
  logger = NULL
)
```

## Arguments

- id:

  the ID of the Module's UI element

- table_data:

  reactive expression (or parameter-less function) that acts as table
  data source

- selection_mode:

  to enable row selection, set `selection_mode` value to either "single"
  for single row selection or "multiple" for multiple rows selection,
  case insensitive. Any other value will disable row selection. Row
  selection will be enabled by radio buttons in "single" selection and
  checkboxes in "multiple" selection (default = NULL)

- pre_selected_rows:

  reactive expression (or parameter-less function) provides the rows
  indices of the rows to be selected when the table is rendered. If
  selection_mode is disabled, this parameter will have no effect. If
  selection_mode is "single" only the first row index will be used
  (default = NULL)

- file_name_root:

  the base name used for user-downloaded file. It can be either a
  character string a reactive expression or a function returning a
  character string (default = 'data_file')

- download_data_fxns:

  a **named** list of functions providing the data as return values. The
  names for the list should be the same names as the ones used in the
  downloadableReactTableUI (default = NULL)

- pagination:

  to enable table pagination (default = FALSE)

- table_height:

  max table height in pixels. Vertical scroll will be shown after that
  height value

- show_rownames:

  enable displaying rownames as a separate column (default = FALSE)

- columns_filter:

  enable the filtering input on each column in the table (default =
  FALSE)

- global_search:

  enable table global searching input to search and filter in all
  columns at once (default = TRUE)

- row_highlight:

  enable highlighting rows upon mouse hover (default = TRUE)

- row_striping:

  add zebra-striped style to table rows (default = TRUE)

- table_options:

  optional table formatting parameters check
  [`?reactable::reactable`](https://glin.github.io/reactable/reference/reactable.html)
  for options full list. Also see example below to see how to pass
  options (default = list())

- logger:

  logger to use (default = NULL)

## Value

A named list of two elements:

- selected_rows: data.frame of current selected rows

- table_state: a list of the current table state. The list keys are
  ("page", "pageSize", "pages", "sorted" and "selected"). Review
  [`?reactable::getReactableState`](https://glin.github.io/reactable/reference/getReactableState.html)
  for more info.

## Shiny Usage

This function is not called directly by consumers - it is accessed in
server.R using the same id provided in `downloadableReactTableUI`:

**`downloadableReactTable(id)`**

## See also

[downloadableReactTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableReactTableUI.md)

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
                 theme = reactableTheme(
                     borderColor = "#dfe2e5",
                     stripedColor = "#f6f8fa",
                     highlightColor = "#f0f5f9",
                     cellPadding = "8px 12px")))

        observeEvent(table_state(), { print(table_state()) })
    })
}
```
