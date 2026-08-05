# Periscope2 Shiny Application Framework

Periscope2 is the next-generation package following the paradigm of the
'periscope' package to support a UI-standardized and rail-guarded
enterprise quality application environment. This package also includes a
variety of convenience functions for 'shiny' applications in a more
modernized way. Base reusable functionality as well as UI paradigms are
included to ensure a consistent user experience regardless of
application or developer.

## Details

'periscope2' differs from the 'periscope' package as follows:

- Upgraded dependency on bootstrap v4 instead of bootstrap v3

- New user modules (i.e. announcements)

- More functionality and finer control over existing modules such as
  [alert](https://aggregate-genius.github.io/periscope2/reference/createPSAlert.md)
  and
  [reset](https://aggregate-genius.github.io/periscope2/reference/appResetButton.md)

- More control over customizing different application parts (header,
  footer, left sidebar, right sidebar and body)

- Enhanced file structure to organize application UI, shiny modules, app
  configuration, .. etc

A gallery of 'periscope' and 'periscope2' example apps is hosted at
[http://periscopeapps.org](http://periscopeapps.org:3838)

## Function Overview

*Create a new framework application instance:  
*
[create_application](https://aggregate-genius.github.io/periscope2/reference/create_application.md)  

*Set application parameters in program/global.R:  
*
[set_app_parameters](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md)  

*Get any url parameters passed to the application:  
*
[get_url_parameters](https://aggregate-genius.github.io/periscope2/reference/get_url_parameters.md)  

*Update an existing application with a needed sidebar:  
*
[create_left_sidebar](https://aggregate-genius.github.io/periscope2/reference/create_left_sidebar.md)  
[create_right_sidebar](https://aggregate-genius.github.io/periscope2/reference/create_right_sidebar.md)  

*Register user-created UI objects to the requisite application
locations:  
*
[add_ui_body](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)  
[add_ui_footer](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)  
[add_ui_header](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)  
[add_ui_left_sidebar](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)  
[add_ui_right_sidebar](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)

*Included shiny modules with a customized UI:  
*
[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)  
[downloadableTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableTableUI.md)  
[downloadablePlotUI](https://aggregate-genius.github.io/periscope2/reference/downloadablePlotUI.md)  
[appResetButton](https://aggregate-genius.github.io/periscope2/reference/appResetButton.md)  
[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)  

*High-functionality standardized tooltips:  
*
[ui_tooltip](https://aggregate-genius.github.io/periscope2/reference/ui_tooltip.md)

## More Information

`browseVignettes(package = 'periscope2')`

## See also

Useful links:

- <https://github.com/Aggregate-Genius/periscope2>

- <http://periscopeapps.org:3838>

- Report bugs at <https://github.com/Aggregate-Genius/periscope2/issues>

## Author

**Maintainer**: Mohammed Ali <mohammed@aggregate-genius.com>

Other contributors:

- Constance Brett \[contributor\]

- Aggregate Genius Inc \[sponsor\]
