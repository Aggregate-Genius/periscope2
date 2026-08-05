# appReset module server function

Server-side function for the appResetButton This is a custom
high-functionality button for session reload. The server function is
used to provide module configurations.

## Usage

``` r
appReset(id, reset_wait = 5000, alert_location = "bodyAlert", logger)
```

## Arguments

- id:

  Character represents the ID of the Module's UI element (the same id
  used in `appResetButton`

- reset_wait:

  Integer represents the period to wait before session reload in
  milliseconds (default = 5000)

- alert_location:

  Character represents div ID or selector to display module related
  messages (default = "bodyAlert")

- logger:

  logger to use

## Value

nothing, function will display a warning message in the app then reload
the whole application

## Shiny Usage

This function is not called directly by consumers - it is accessed in
server_local.R (or similar file) using the same id provided in
`appResetButton`:

**`appReset(id = "appResetId", logger = ss_userAction.Log)`**

## See also

[appResetButton](https://aggregate-genius.github.io/periscope2/reference/appResetButton.md)

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
