# Parse application passed URL parameters

This function returns any url parameters passed to the application as a
named list. Keep in mind url parameters are always user-session scoped

## Usage

``` r
get_url_parameters(session)
```

## Arguments

- session:

  shiny session object

## Value

named list of url parameters and values. List may be empty if no URL
parameters were passed when the application instance was launched

## Shiny Usage

Call this function from `program/server_local.R` or any other server
file

## See also

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:ui_tooltip()](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

## Examples

``` r
  library(shiny)
  library(periscope2)

  # Display application info
  observeEvent(input$app_info, {
               url_params <- get_url_parameters(session)
               show_alert(html                = TRUE,
                          showCloseButton     = FALSE,
                          animation           = "slide-from-top",
                          closeOnClickOutside = TRUE,
                          text                = url_params[["passed_paramter"]],
                          title               = "alert title")
  })

```
