# Add UI elements to dashboard footer section

Builds application footer with given configurations and elements. It is
called within "ui_footer.R". Check example application for detailed
example

## Usage

``` r
add_ui_footer(left = NULL, right = NULL, fixed = FALSE)
```

## Arguments

- left:

  Left side UI elements

- right:

  Right side UI elements

- fixed:

  Always show footer at page bottom regardless page scroll location
  (default = FALSE).

## Value

list of both shiny UI elements and named footer properties

## Shiny Usage

Call this function from `program/ui_footer.R` to set footer parameters

## See also

[bs4Dash:bs4DashFooter()](https://bs4dash.rinterface.com/reference/dashboardFooter.html)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)

  # Inside ui_footer.R
  # Left text
  left <- a(href   = "https://periscopeapps.org/",
            target = "_blank",
            "periscope2")
  # Right text
  right <- "2022"

  # -- Register Elements in the ORDER SHOWN in the UI
  add_ui_footer(left, right)
```
