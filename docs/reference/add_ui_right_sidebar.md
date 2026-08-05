# Add UI elements to dashboard right sidebar section

Builds application right sidebar with given configurations and elements.
It is called within "ui_right_sidebar.R". Check example application for
detailed example

## Usage

``` r
add_ui_right_sidebar(
  sidebar_elements = NULL,
  sidebar_menu = NULL,
  collapsed = TRUE,
  overlay = TRUE,
  pinned = FALSE,
  skin = "light"
)
```

## Arguments

- sidebar_elements:

  List of regular shiny UI elements (inputText, textArea, etc..)

- sidebar_menu:

  `?bs4Dash::controlbarMenu()` object to created a menu inside right
  sidebar

- collapsed:

  If TRUE, the sidebar will be collapsed on app startup (default = TRUE)

- overlay:

  Whether the sidebar covers the content when expanded (default = TRUE)

- pinned:

  If TRUE, allows right sidebar to remain open even after a click
  outside (default = FALSE)

- skin:

  Sidebar skin. "dark" or "light" (default = "light")

## Value

list of both shiny UI elements and named right sidebar properties

## Shiny Usage

Call this function from `program/ui_right_sidebar.R` to set right
sidebar parameters

## See also

[bs4Dash:bs4DashControlbar()](https://bs4dash.rinterface.com/reference/dashboardControlbar.html)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)

  # Inside ui_right_sidebar.R
  sidebar_elements <- list(div(checkboxInput("checkMe", "Example Check")))
  sidebar_menu     <- controlbarMenu(id = "controlbarmenu",
                                     controlbarItem("Item 2", "Simple text"))
 # -- Register Right Sidebar Elements in the ORDER SHOWN in the UI
  add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                       sidebar_menu     = sidebar_menu)
```
