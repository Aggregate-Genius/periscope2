# Add the left sidebar to an existing application

User can update an existing application that does not have a left side
bar and add a new empty one using this function.

## Usage

``` r
create_left_sidebar(location)
```

## Arguments

- location:

  path of the existing periscope2 application

## Value

no return value, creates left sidebar related UI R file and updates
related source call in ui.R

## Details

If conversion is successful, the following message will be returned
*"Add left sidebar conversion was successful. File(s) updated: ui.R,
ui_left_sidebar.R"*

If the function called on an application with an existing left bar,
message *"Left sidebar already available, no conversion needed"* will be
returned with no conversion

If the passed location is invalid, empty, not exist or not a valid
periscope2 application, nothing will be added and a related error
message will be printed in console

## See also

[create_right_sidebar](https://aggregate-genius.github.io/periscope2/reference/create_right_sidebar.md)
