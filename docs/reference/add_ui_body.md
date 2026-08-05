# Add UI elements to dashboard body section

Builds application body with given configurations and elements. It is
called within "ui_body.R". Check example application for detailed
example

## Usage

``` r
add_ui_body(body_elements = NULL, append = FALSE)
```

## Arguments

- body_elements:

  List of UI elements to be displayed in application body

- append:

  Add elements to current body elements or remove previous body elements
  (default = FALSE)

## Value

list of both shiny UI elements and html div tags for alert and linking
app JS and CSS files

## Shiny Usage

Call this function from `program/ui_body.R` to set body parameters

## See also

[bs4Dash:bs4DashBody()](https://bs4dash.rinterface.com/reference/dashboardBody.html)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)
#> 
#> Attaching package: ‘bs4Dash’
#> The following objects are masked from ‘package:shiny’:
#> 
#>     actionButton, column, insertTab, navbarMenu, tabsetPanel
#> The following object is masked from ‘package:graphics’:
#> 
#>     box
  # Inside ui_body.R
  about_box <- jumbotron(title  = "periscope2: Test Example",
                         lead   = p("periscope2 is a scalable and UI-standardized 'shiny' framework
                                  including a variety of developer convenience functions"),
                         status = "info",
                         href   = "https://periscopeapps.org/")
  # -- Register Elements in the ORDER SHOWN in the UI
  add_ui_body(list(about_box))
```
