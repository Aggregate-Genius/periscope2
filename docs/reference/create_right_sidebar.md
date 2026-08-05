# Add the right sidebar to an existing application

User can update an existing application that does not have a right side
bar and add a new empty one using this function.

## Usage

``` r
create_right_sidebar(location)
```

## Arguments

- location:

  path of the existing periscope2 application.

## Value

no return value, creates right sidebar related UI R file and updates
related source call in ui.R

## Details

If conversion is successful, the following message will be returned
*"Add right sidebar conversion was successful. File(s) updated: ui.R,
ui_right_sidebar.R"*

If the function called on an application with an existing right bar,
message *"Right sidebar already available, no conversion needed"* will
be returned with no conversion

If the passed location is invalid, empty, not exist or not a valid
periscope2 application, nothing will be added and a related error
message will be printed in console

## See also

[create_left_sidebar](https://aggregate-genius.github.io/periscope2/reference/create_left_sidebar.md)
