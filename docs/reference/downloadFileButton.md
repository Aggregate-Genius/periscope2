# downloadFileButton module UI function

Creates a custom high-functionality button for file downloads with two
states - single download type or multiple-download types. The button
image and pop-up menu (if needed) are set accordingly. A tooltip can
also be set for the button.

## Usage

``` r
downloadFileButton(id, downloadtypes = c("csv"), hovertext = NULL)
```

## Arguments

- id:

  character id for the object

- downloadtypes:

  vector of values for data download types

- hovertext:

  tooltip hover text

## Value

html span with tooltip and either shiny downloadButton in case of single
download or shiny actionButton otherwise

## Button Features

- Consistent styling of the button, including a hover tooltip

- Single or multiple types of downloads

- Ability to download different data for each type of download

## Example

`downloadFileUI("mybuttonID1", c("csv", "tsv"), "Click Here")`
`downloadFileUI("mybuttonID2", "csv", "Click to download")`

## Shiny Usage

Call this function at the place in ui.R where the button should be
placed.

It is paired with a call to `downloadFile(id, ...)` in server.R

## See also

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

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
