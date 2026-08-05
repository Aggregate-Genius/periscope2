# Set Application Parameters

This function sets global parameters customizing the shiny application.

## Usage

``` r
set_app_parameters(
  title = NULL,
  app_info = NULL,
  log_level = "DEBUG",
  app_version = "1.0.0",
  loading_indicator = NULL,
  announcements_file = NULL
)
```

## Arguments

- title:

  **\[deprecated\]** Use
  [add_ui_header](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)
  to configure application title text

- app_info:

  Application detailed information. It can be character string, HTML
  value or NULL

  - A **character** string will be used to set a link target. This means
    the user will be able to click on the application title and be
    redirected in a new window to whatever value is given in the string.
    Any valid URL, File, or other script functionality that would
    normally be accepted in an `<a href=...></a>` tag is allowed.

  - An **HTML** value will be used to as the HTML content for a modal
    pop-up window that will appear on-top of the application when the
    user clicks on the application title.

  - Supplying **NULL** will disable the title link functionality.

- log_level:

  Designating the log level to use for the user log as 'DEBUG','INFO',
  'WARNING' or 'ERROR' (default = 'DEBUG')

- app_version:

  Character string designating the application version (default =
  '1.0.0')

- loading_indicator:

  It uses waiter (see https://waiter.john-coene.com/#/).  
  Pass a list like list(html = spin_1(), color = "#333e48") to  
  configure waiterShowOnLoad (refer to the package help for all styles).

- announcements_file:

  **\[deprecated\]**. Use
  [load_announcements](https://aggregate-genius.github.io/periscope2/reference/load_announcements.md)
  to configure announcement.

## Value

no return value, called for setting new application global properties

## Shiny Usage

Call this function from `program/global.R` to set the application
parameters.

## See also

[periscope2:announcementConfigurationsAddin()](https://aggregate-genius.github.io/periscope2/reference/announcementConfigurationsAddin.md)

[periscope2:load_announcements()](https://aggregate-genius.github.io/periscope2/reference/load_announcements.md)

[waiter:waiter_show()](https://rdrr.io/pkg/waiter/man/waiter.html)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(waiter)
  library(periscope2)

  # Inside program/global.R
  set_app_parameters(app_info          = HTML("Example info"),
                     log_level         = "DEBUG",
                     app_version       = "1.0.0",
                     loading_indicator = list(html = tagList(spin_1(), "Loading ...")))

```
