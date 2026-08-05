# Add tooltip icon and text to UI elements labels

This function inserts a standardized tooltip image, label (optional),
and hovertext into the application UI

## Usage

``` r
ui_tooltip(id, label = "", text = "", placement = "top")
```

## Arguments

- id:

  The id for the tooltip object

- label:

  Text label to appear to the left of the tooltip image

- text:

  Tooltip text shown when the user hovers over the image

- placement:

  Where to display tooltip label. Available places are "top", "bottom",
  "left", "right" (default is "top")

## Value

html span with the label, tooltip image and tooltip text

## Shiny Usage

Call this function from `program/ui_body.R` to set tooltip parameters

## See also

[periscope2:add_ui_footer()](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)

[periscope2:add_ui_left_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)

[periscope2:add_ui_header()](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)

[periscope2:add_ui_body()](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)

[periscope2:add_ui_right_sidebar()](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

[periscope2:set_app_parameters()](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)

periscope2:ui_tooltip()

[periscope2:get_url_parameters()](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)

## Examples

``` r
  library(shiny)
  library(periscope2)

  # Inside ui_body.R or similar UI file
   ui_tooltip(id   = "top_tip",
             label = "Top Tooltips",
             text  = "Top tooltip")
#> <span class="periscope-input-label-with-tt">
#>   Top Tooltips
#>   <img id="top_tip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="top" title="Top tooltip" data-html="true"/>
#> </span>
```
