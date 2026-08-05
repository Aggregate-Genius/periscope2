# Display alert panel at specified location

Create an alert panel in server code to be displayed in the specified UI
selector location

## Usage

``` r
createPSAlert(
  session = shiny::getDefaultReactiveDomain(),
  id = NULL,
  selector = NULL,
  options
)
```

## Arguments

- session:

  Shiny session object

- id:

  Anchor id (either id or selector only should be set)

- selector:

  Character vector represents jQuery selector to add the alert to is
  (i.e ".alertClass", div.badge-danger.navbar-badge). If 'id' is
  specified, this parameter will be neglected

- options:

  List of options to pass to the alert

## Value

html div and inserts it in the app DOM

## Shiny Usage

Call this function from `program/server_local.R` or any other server
file to setup the needed alert

## See also

[bs4Dash:closeAlert()](https://bs4dash.rinterface.com/reference/alert.html)

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)

  # Inside server_local.R
  createPSAlert(id       = "sidebarRightAlert",
                options  = list(title    = "Right Side",
                                status   = "success",
                                closable = TRUE,
                                content  = "Example Basic Sidebar Alert"))
  # Test se
  ## a div with class "badge-danger.navbar-badge" must be exist in UI to display alert
  selector <- "div.badge-danger.navbar-badge"
  createPSAlert(selector = selector,
                options  = list(title    = "Selector Title",
                                status   = "danger",
                                closable = TRUE,
                                content  = "Selector Alert"))

```
