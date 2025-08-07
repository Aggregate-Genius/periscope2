# periscope2 0.3.0.9004

## New Features
- Added new module *?downloadableReactTable* based on reactable package and downloadFile module

## Enhancements
- Adding openxlsx2 support while keeping openxlsx to support legacy apps and backwards compatibility. writexl package is used as last resort.

-----

# periscope2 0.2.4

## Enhancements

- Updated `set_app_parameters` method documentation to displayed html tags correctly
- Updated package documentation to fix `docType` deprecation warning
- Updated `logger` module internal documentation
- Added loglevel filtering according to level chosen

-----

# periscope2 0.2.3

## Enhancements

- Re-factored header layout to be more flexible with menu items
- Updated modules default values
- **downloadableTable** module server parameters "filenameroot" can now support character,  reactive expression or a function to return file name
- Introduced `load_announcements` method to create announcement alert at predefined generated app ui div
- Deprecated `title` parameter in `set_app_parameters`, use `periscope2::add_ui_header(title)` instead

## Bug Fixes

- Hide download button if `downloaddatafxn` or `downloadtypes` are empty for `downloadableTable` module
- Hide download button if `downloadfxns` or `downloadtypes` are empty for `downloadablePlot` module
- Capitalized left tooltip text

-----

# periscope2 0.2.2

## New Features

- Introduced application theme configuration file generator RStudio add-in
- Enabled full usage of bootstrap4 variables customization in `periscope_style.yaml` (refer to `vignette("migrate_to_v0_2_0", package = "periscope2")`)

## Enhancements

- Allowed header to have navbar menu
- Renamed `createAlert` method to be `createPSAlert` to avoid confusion with `bs4Dash::createAlert` (refer to `vignette("migrate_to_v0_2_0", package = "periscope2")`)
- Display alert with status icon correctly when there is no alert title
- Allowed html tags inside tooltip function

-----

# periscope2 0.1.4

## New Features

- Introduced Announcements configuration file generator RStudio add-in

## Enhancements

- Used `shinyWidgets::show_alert` to display application info
- Relocated Announcements and header alerts bar to be above navbar instead of inside it
- Updated sidebars related CSS to avoid CX z-index issues
- Updated sample app default theme colors to improve accessibility

## Bug Fixes

- Fixed non working Announcements and ResetApp modules in sample application
- Fixed updating selected rows issue in downloadable table module

-----

# periscope2 0.1.3
## Enhancements
 
  - Removed operator ":::" usage from documentation examples
  - Formatted documentation examples to have less blank spaces and be human readable at the same time as much as possible

-----

# periscope2 0.1.2

## Enhancements

- Updated shiny modules examples to be executable in an interactive environment

-----

# periscope2 0.1.1

## Enhancements

- DESCRIPTION file changes:
  - Applied CRAN review notes for listed packages names in title and description fields
  - Rephrased "Description" Field and added references to mentioned APIs
- Package documentation changes:
  - Updated different functions documentations with runnable example
- Package code changes:
  - Refactored any global assignment "<<-" usage, no code is modifying the global environment
  - Refactored `installed.packages` function usage and used `find.package` function

-----

# periscope2 0.1.0

* Initial CRAN release

