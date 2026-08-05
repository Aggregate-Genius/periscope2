# Add UI elements to dashboard header section

Builds application header with given configurations and elements. It is
called within "ui_header.R". These elements will be displayed in the
header beside application title and application busy indicator.

## Usage

``` r
add_ui_header(
  ui_elements = NULL,
  ui_position = "right",
  title = NULL,
  title_position = "center",
  left_menu = NULL,
  right_menu = NULL,
  border = TRUE,
  compact = FALSE,
  right_sidebar_icon = shiny::icon("bars"),
  fixed = FALSE,
  left_sidebar_icon = shiny::icon("th"),
  skin = "light",
  status = "white"
)
```

## Arguments

- ui_elements:

  It can be any UI element but mostly used for navbarMenu. NULL by
  default. Check `?bs4Dash::navbarMenu()`

- ui_position:

  Location of UI elements in the header. Must be either of 'center',
  'left' or 'right' Default value is 'right'.

- title:

  Sets application title. If it is not NULL, it will override "title"
  value that is set in `?periscope2::set_app_parameters()` (default =
  NULL)

- title_position:

  Location of the title in the header. Must be either of 'center',
  'left' or 'right' Default value is 'Center'. If there are no UI
  elements, this param will be ignored.

- left_menu:

  Left menu. bs4DropdownMenu object (or similar dropdown menu). Check
  `?bs4Dash::bs4DropdownMenu()`

- right_menu:

  Right menu. bs4DropdownMenu object (or similar dropdown menu). Check
  `?bs4Dash::bs4DropdownMenu()`

- border:

  Whether to separate the navbar and body by a border. TRUE by default

- compact:

  Whether items should be compacted. FALSE by default

- right_sidebar_icon:

  Right sidebar toggle icon

- fixed:

  Whether to fix the navbar to the top. FALSE by default

- left_sidebar_icon:

  Left sidebar toggle icon

- skin:

  Sidebar skin. "dark" or "light"

- status:

  Sidebar status. Check `?bs4Dash::bs4DashNavbar()` for list of valid
  values

## Value

list of both shiny UI elements and named header properties

## Details

### Application header consists of three elements:

- busy indicator:

  An automatic wait indicator that are shown when the shiny server
  session is busy

- application title:

  Display application title

- heade menu:

  Optional header menu to switch between application different tabs

Header elements can be arranged via `ui_position` and `title_position`
parameters.  
Header elements look and feel can also be configured in
**"www\css\custom.css"** file under **"Application Header"** section.  
Check example application for detailed example

## Shiny Usage

Call this function from `program/ui_header.R` to set header parameters

## See also

[bs4Dash:bs4DashNavbar()](https://bs4dash.rinterface.com/reference/dashboardHeader.html)

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(bs4Dash)

  # Inside ui_header.R
  # Custom left UI menu
  left_menu <- tagList(dropdownMenu(badgeStatus = "info",
                                  type        = "notifications",
                                   notificationItem(inputId = "triggerAction2",
                                                    text    = "Error!",
                                                    status  = "danger")),
                      dropdownMenu(badgeStatus = "info",
                                   type        = "tasks",
                                   taskItem(inputId = "triggerAction3",
                                            text    = "My progress",
                                            color   = "orange",
                                            value   = 10)))

  # Custom right UI menu
  right_menu <- dropdownMenu(badgeStatus = "danger",
                          type        = "messages",
                          messageItem(inputId = "triggerAction1",
                                      message = "message 1",
                                      from    = "Divad Nojnarg",
                                      time    = "today",
                                      color   = "lime"))
  # -- Register Header Elements in the ORDER SHOWN in the UI
  add_ui_header(left_menu = left_menu, right_menu = right_menu)
```
