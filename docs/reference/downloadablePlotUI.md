# downloadablePlot module UI function

Creates a custom plot output that is paired with a linked downloadFile
button. This module is compatible with ggplot2, grob and lattice
produced graphics.

## Usage

``` r
downloadablePlotUI(
  id,
  downloadtypes = c("png"),
  download_hovertext = NULL,
  width = "100%",
  height = "400px",
  btn_halign = "right",
  btn_valign = "bottom",
  btn_overlap = TRUE,
  clickOpts = NULL,
  hoverOpts = NULL,
  brushOpts = NULL
)
```

## Arguments

- id:

  character id for the object

- downloadtypes:

  vector of values for download types

- download_hovertext:

  download button tooltip hover text

- width:

  plot width (any valid css size value)

- height:

  plot height (any valid css size value)

- btn_halign:

  horizontal position of the download button ("left", "center", "right")

- btn_valign:

  vertical position of the download button ("top", "bottom")

- btn_overlap:

  whether the button should appear on top of the bottom of the plot area
  to save on vertical space *(there is often a blank area where a button
  can be overlayed instead of utilizing an entire horizontal row for the
  button below the plot area)*

- clickOpts:

  NULL or an object created by the
  [clickOpts](https://rdrr.io/pkg/shiny/man/clickOpts.html) function

- hoverOpts:

  NULL or an object created by the
  [hoverOpts](https://rdrr.io/pkg/shiny/man/clickOpts.html) function

- brushOpts:

  NULL or an object created by the
  [brushOpts](https://rdrr.io/pkg/shiny/man/brushOpts.html) function

## Value

list of downloadFileButton UI and plot object

## Details

downloadFile button will be hidden if `downloadablePlot` parameter
`downloadfxns` or `downloadablePlotUI` parameter `downloadtypes` is
empty

## Example

`downloadablePlotUI("myplotID", c("png", "csv"), "Download Plot or Data", "300px")`

## Notes

When there is nothing to download in any of the linked downloadfxns the
button will be hidden as there is nothing to download.

This module is NOT compatible with the built-in (base) graphics *(such
as basic plot, etc.)* because they cannot be saved into an object and
are directly output by the system at the time of creation.

## Shiny Usage

Call this function at the place in ui.R where the plot should be placed.

Paired with a call to `downloadablePlot(id, ...)` in server.R

## See also

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[clickOpts](https://rdrr.io/pkg/shiny/man/clickOpts.html)

[hoverOpts](https://rdrr.io/pkg/shiny/man/clickOpts.html)

[brushOpts](https://rdrr.io/pkg/shiny/man/brushOpts.html)

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
