# downloadFile module server function

Server-side function for the downloadFileButton. This is a custom
high-functionality button for file downloads supporting single or
multiple download types. The server function is used to provide the data
for download.

## Usage

``` r
downloadFile(
  id,
  logger = NULL,
  filenameroot = "download",
  datafxns = NULL,
  aspectratio = 1,
  row_names = TRUE
)
```

## Arguments

- id:

  ID of the Module's UI element

- logger:

  logger to use

- filenameroot:

  the base text used for user-downloaded file - can be either a
  character string or a reactive expression that returns a character
  string

- datafxns:

  a **named** list of functions providing the data as return values. The
  names for the list should be the same names that were used when the
  button UI was created.

- aspectratio:

  the downloaded chart image width:height ratio (ex: 1 = square, 1.3 =
  4:3, 0.5 = 1:2). Where not applicable for a download type it is
  ignored (e.g. data downloads).

- row_names:

  logical value indicating whether row names are to be written for
  tabular data. Where not applicable for a download type it is ignored.

## Value

no return value, called for downloading selected file type

## Shiny Usage

This function is not called directly by consumers - it is accessed in
server.R using the same id provided in `downloadFileButton`:

**`downloadFile(id, logger, filenameroot, datafxns)`**

## See also

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[downloadFile_ValidateTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_ValidateTypes.md)

[downloadFile_AvailableTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_AvailableTypes.md)

[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

[downloadableTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableTableUI.md)

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

## Examples

``` r
if (interactive()) {
   library(shiny)
   library(periscope2)
   shinyApp(ui = fluidPage(fluidRow(column(width = 6,
     # single download type
     downloadFileButton("object_id1",
                        downloadtypes = c("csv"),
                        hovertext     = "Button 1 Tooltip")),
      column(width = 6,
      # multiple download types
      downloadFileButton("object_id2",
                         downloadtypes = c("csv", "tsv"),
                         hovertext     = "Button 2 Tooltip")))),
     server = function(input, output) {
       # single download type
       downloadFile(id           = "object_id1",
                    logger       = "",
                    filenameroot = "mydownload1",
                    datafxns     = list(csv = reactiveVal(iris)),
                    row_names    = FALSE)
       # multiple download types
       downloadFile(id           = "object_id2",
                    logger       = "",
                    filenameroot = "mydownload2",
                    datafxns     = list(csv = reactiveVal(mtcars),
                    tsv = reactiveVal(mtcars)))
   })
}
```
