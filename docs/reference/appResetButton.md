# appResetButton module UI function

Creates a toggle button to reset application session. Upon pressing on
the button, its state is flipped to cancel application reload with
application and console warning messages indicating that the application
will be reloaded.

## Usage

``` r
appResetButton(id)
```

## Arguments

- id:

  character id for the object

## Value

an html div with prettyToggle button

## Details

User can either resume reloading application session or cancel reloading
process which will also generate application and console messages to
indicate reloading status and result.

## Button Features

- Initial state label is "Application Reset" with warning status

- Reloading state label is "Cancel Application Reset" with danger status

## Shiny Usage

Call this function at any place in UI section.

It is paired with a call to `appReset(id, ...)` in server

## See also

[appReset](https://aggregate-genius.github.io/periscope2/reference/appReset.md)

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

[downloadFile_ValidateTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_ValidateTypes.md)

[downloadFile_AvailableTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_AvailableTypes.md)

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)

## Examples

``` r
if (interactive()) {
   library(shiny)
   library(periscope2)
   shinyApp(
     ui = fluidPage(fluidRow(column(12, appResetButton(id = "appResetId")))),
     server = function(input, output) {
       appReset(id = "appResetId", logger = "")
   })
}

```
