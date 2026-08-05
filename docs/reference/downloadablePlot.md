# downloadablePlot module server function

Server-side function for the downloadablePlotUI. This is a custom plot
output paired with a linked downloadFile button.

## Usage

``` r
downloadablePlot(
  id,
  logger = NULL,
  filenameroot = "download",
  aspectratio = 1,
  downloadfxns = NULL,
  visibleplot
)
```

## Arguments

- id:

  the ID of the Module's UI element

- logger:

  logger to use

- filenameroot:

  the base text used for user-downloaded file - can be either a
  character string or a reactive expression returning a character string

- aspectratio:

  the downloaded chart image width:height ratio (ex: 1 = square, 1.3 =
  4:3, 0.5 = 1:2). Where not applicable for a download type it is
  ignored (e.g. data, html downloads)

- downloadfxns:

  a **named** list of functions providing download images or data tables
  as return values. The names for the list should be the same names that
  were used when the plot UI was created.

- visibleplot:

  function or reactive expression providing the plot to display as a
  return value. This function should require no input parameters.

## Value

Reactive expression containing the currently selected plot to be
available for display and download

## Details

downloadFile button will be hidden if `downloadablePlot` parameter
`downloadfxns` or `downloadablePlotUI` parameter `downloadtypes` is
empty

## Notes

When there are no values to download in any of the linked downloadfxns
the button will be hidden as there is nothing to download.

## Shiny Usage

This function is not called directly by consumers - it is accessed in
server.R using the same id provided in `downloadablePlotUI`:

**`downloadablePlot(id, logger, filenameroot, downloadfxns, visibleplot)`**

## See also

[downloadablePlotUI](https://aggregate-genius.github.io/periscope2/reference/downloadablePlotUI.md)

[appResetButton](https://aggregate-genius.github.io/periscope2/reference/appResetButton.md)

[appReset](https://aggregate-genius.github.io/periscope2/reference/appReset.md)

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

[downloadFile_ValidateTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_ValidateTypes.md)

[downloadFile_AvailableTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_AvailableTypes.md)

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(ggplot2)
  library(periscope2)
  shinyApp(ui = fluidPage(fluidRow(column(width = 12,
     downloadablePlotUI("object_id1",
                        downloadtypes      = c("png", "csv"),
                        download_hovertext = "Download plot and data",
                        height             = "500px",
                        btn_halign         = "left")))),
    server = function(input, output) {
      download_plot <- function() {
        ggplot(data = mtcars, aes(x = wt, y = mpg)) +
        geom_point(aes(color = cyl)) +
        theme(legend.justification   = c(1, 1),
              legend.position.inside = c(1, 1),
              legend.title           = element_blank()) +
        ggtitle("GGPlot Example ") +
        xlab("wt") +
        ylab("mpg")
      }
      downloadablePlot(id           = "object_id1",
                       logger       = "",
                       filenameroot = "mydownload1",
                       downloadfxns = list(png = download_plot, csv = reactiveVal(mtcars)),
                       aspectratio  = 1.33,
                       visibleplot  = download_plot)
  })
}
```
