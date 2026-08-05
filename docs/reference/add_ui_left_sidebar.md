# Add UI elements to dashboard left sidebar section

This function adds left sidebar configurations and UI elements. It is
called within "ui_left_sidebar.R". Check example application for
detailed example

## Usage

``` r
add_ui_left_sidebar(
  sidebar_elements = NULL,
  sidebar_menu = NULL,
  collapsed = FALSE,
  custom_area = NULL,
  elevation = 4,
  expand_on_hover = TRUE,
  fixed = TRUE,
  minified = FALSE,
  status = "primary",
  skin = "light"
)
```

## Arguments

- sidebar_elements:

  List of regular shiny UI elements (inputText, textArea, etc..)

- sidebar_menu:

  `?bs4Dash::bs4SidebarMenu()` object to created a menu inside left
  sidebar

- collapsed:

  If TRUE, the sidebar will be collapsed on app start up

- custom_area:

  List of regular shiny UI elements but for sidebar bottom space area
  only. Only works if sidebar is fixed

- elevation:

  A number between 0 and 5, which applies a shadow to the sidebar to add
  a shadow effect.

- expand_on_hover:

  When `minified` is TRUE, if this property is TRUE, the sidebar opens
  when hovering but re-collapses as soon as the focus is lost (default =
  TRUE)

- fixed:

  Whether to see all menus at once without scrolling up and
  down.(default = TRUE)

- minified:

  Whether to slightly close the sidebar but still show item icons
  (default = FALSE)

- status:

  Determines which color menu items (if exist) will have Check
  `?bs4Dash::dashboardSidebar()` for list of valid values

- skin:

  Sidebar skin. "dark" or "light" (default = "light")

## Value

list of both shiny UI elements and named left sidebar properties

## Shiny Usage

Call this function from `program/ui_left_sidebar.R` to set left sidebar
parameters

## See also

[bs4Dash:bs4DashSidebar()](https://bs4dash.rinterface.com/reference/dashboardSidebar.html)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)
  # Inside ui_left_sidebar.R
  # sidebar menu items
  sidebar_elements <- textInput("text_id", "Test", "Test Data")
  sidebar_menu     <- sidebarMenu(sidebarHeader("Main Menu"),
                                  menuItem("menu item 1",
                                           tabName = "item_1 page"),
                                  menuItem("menu item 2",
                                           tabName = "item_2 page"))
  add_ui_left_sidebar(sidebar_elements = sidebar_elements,
                      sidebar_menu     = sidebar_menu)
```
