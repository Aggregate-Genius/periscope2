# Create a new templated framework application

Creates ready-to-use templated application files using the periscope2
framework. The application can be created either empty (default) or with
a sample/documented example application.  
  

## Usage

``` r
create_application(
  name,
  location,
  sample_app = FALSE,
  left_sidebar = TRUE,
  right_sidebar = FALSE
)
```

## Arguments

- name:

  name for the new application and directory

- location:

  base path for creation of `name`

- sample_app:

  whether to create a sample shiny application

- left_sidebar:

  whether the left sidebar should be enabled. It can be TRUE/FALSE

- right_sidebar:

  parameter to set the right sidebar. It can be TRUE/FALSE

## Value

no return value, creates application folder structure and files

## Name

The `name` directory must not exist in `location`. If the code detects
that this directory exists it will abort the creation process with a
warning and will not create an application template.

Use only filesystem-compatible characters in the name (ideally w/o
spaces)

## Directory Structure

    name
     -- log (log files)
     -- program (user application)
     -- -- config   (application configuration files)
     -- -- data     (user application data)
     -- -- fxn      (user application function)
     -- -- modules  (application modules files)
     -- www (supporting shiny files)
     -- -- css  (application css files)
     -- -- img  (application image files)
     -- -- js   (application js files)

## File Information

All user application creation and modifications will be done in the
**program** directory. The names & locations of the framework-provided
.R files should not be changed or the framework will fail to work as
expected.  
  
***name/program/config*** directory :  
Use this location for configuration files.  
  
***name/program/data*** directory :  
Use this location for data files. There is a **.gitignore** file
included in this directory to prevent accidental versioning of data  
  
***name/program/fxn*** directory :  
Use this location for supporting and helper R files.  
  
***name/program/modules*** directory :  
Use this location for application new modules files.  
  
***name/program*/global.R** :  
Use this location for code that would have previously resided in
global.R and for setting application parameters using
[set_app_parameters](https://aggregate-genius.github.io/periscope2/reference/set_app_parameters.md).
Anything placed in this file will be accessible across all user sessions
as well as within the UI context.  
  
***name/program*/server_global.R** :  
Use this location for code that would have previously resided in
server.R above (i.e. outside of) the call to `shinyServer(...)`.
Anything placed in this file will be accessible across all user
sessions.  
  
***name/program*/server_local.R** :  
Use this location for code that would have previously resided in
server.R inside of the call to `shinyServer(...)`. Anything placed in
this file will be accessible only within a single user session.  
  
***name/program*/ui_body.R** :  
Create body UI elements in this file and register them with the
framework using a call to
[add_ui_body](https://aggregate-genius.github.io/periscope2/reference/add_ui_body.md)  
  
***name/program*/ui_footer.R** :  
Create footer UI elements in this file and register them with the
framework using a call to
[add_ui_footer](https://aggregate-genius.github.io/periscope2/reference/add_ui_footer.md)  
  
***name/program*/ui_header.R** :  
Create header UI elements in this file and register them with the
framework using a call to
[add_ui_header](https://aggregate-genius.github.io/periscope2/reference/add_ui_header.md)  
  
***name/program*/ui_left_sidebar.R** :  
Create sidebar UI elements in this file and register them with the
framework using a call to
[add_ui_left_sidebar](https://aggregate-genius.github.io/periscope2/reference/add_ui_left_sidebar.md)  
  
***name/program*/ui_right_sidebar.R** :  
Create right sidebar UI elements in this file and register them with the
framework using a call to
[add_ui_right_sidebar](https://aggregate-genius.github.io/periscope2/reference/add_ui_right_sidebar.md)  
  
***name*/www/css/custom.css** :  
This is the application custom styling css file. User can update
application different parts style using this file.  
  
***name*/www/js/custom.js** :  
This is the application custom javascript file.  
  
***name*/www/periscope_style.yaml** :  
This is the application custom styling yaml file. User can update
application different parts style using this file.  
  
  
**Do not modify the following files**:  

    name\global.R
    name\server.R
    name\ui.R
    name\www\img\loader.gif
    name\www\img\tooltip.png

## See also

[bs4Dash:dashboardPage()](https://bs4dash.rinterface.com/reference/dashboardPage.html)

[waiter:waiter_show()](https://rdrr.io/pkg/waiter/man/waiter.html)

## Examples

``` r
# sample app named 'mytestapp' created in a temp dir
location <- tempdir()
create_application(name = 'mytestapp', location = location, sample_app = TRUE)
#> periscope2 application mytestapp was created successfully at /tmp/RtmpSnL8Yy
unlink(paste0(location,'/mytestapp'), TRUE)

# sample app named 'mytestapp' with a right sidebar using a custom icon created in a temp dir
location <- tempdir()
create_application(name = 'mytestapp', location = location, sample_app = TRUE, right_sidebar = TRUE)
#> periscope2 application mytestapp was created successfully at /tmp/RtmpSnL8Yy
unlink(paste0(location,'/mytestapp'), TRUE)

# blank app named 'myblankapp' created in a temp dir
location <- tempdir()
create_application(name = 'myblankapp', location = location)
#> periscope2 application myblankapp was created successfully at /tmp/RtmpSnL8Yy
unlink(paste0(location,'/myblankapp'), TRUE)

# blank app named 'myblankapp' without a left sidebar created in a temp dir
location <- tempdir()
create_application(name = 'myblankapp', location = location, left_sidebar = FALSE)
#> periscope2 application myblankapp was created successfully at /tmp/RtmpSnL8Yy
unlink(paste0(location,'/myblankapp'), TRUE)
```
