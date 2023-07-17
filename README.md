---
title:  "periscope2 Shiny Application Framework"
output: 
    html_document:
        self_contained: yes
---

<!-- badges: start -->
  [![R-CMD-check](https://github.com/Aggregate-Genius/periscope2/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Aggregate-Genius/periscope2/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

***periscope2*** is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience functions with the goal of both streamlining robust application development and assisting in creating a consistent user experience regardless of application or developer.


***periscope2*** is rich of developer-friendly features as:

* A predefined but flexible templates for new Shiny applications with a default [bs4Dash](https://bs4dash.rinterface.com/) layout
* Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local
* Generated applications are organised in an easy to follow and maintain folder structure based on files functionality
* Off shelf and ready to be used modules ('Table Downloader', 'Plot Downloader', 'File Downloader' and 'Reset Application'
  * More modules are introduced in each new version
* Different methods and tools to alert users and add useful information about application UI and server operations
* Application logger with different levels and a UI tool to display and review recorded application logs
* Application look and feel can be customized easily via 'www/periscope_style.yaml' or more advanced via 'www/css/custom.css'
* Application can make use of JS power by customizing 'www/js/custom.js'

Create and run sample app for full features demo

```{r}
periscope2::create_application(name = "demo_app", location = ".", sample_app = T, right_sidebar = T)
shiny::runApp("./demo_app/", launch.browser = T)
```

### Installation

periscope2 is available for installation from the
latest version of ***periscope2*** from GitHub as follows:

```r
devtools::install_github('cb4ds/periscope2')
```

<br/>

---

### Examples

These are included to get you started. You can either start with an empty application or an application that includes samples of the components that you can use within your application.  There is extensive package documentation and full Vignettes are also available to help you with all the options.

<br/>

#### Empty application

```r
library(periscope2)
create_application('emptyapp', location = tempdir())
runApp('emptyapp')
```


#### Sample application - no right sidebar

```r
library(periscope2)
create_application("sampleapp1", location = tempdir(), sample_app = TRUE)
runApp('sampleapp1')

```

#### Sample application - including a right sidebar

```r
library(periscope2)
create_application("sampleapp2", location = tempdir(), sample_app = TRUE, rightsidebar = TRUE)
runApp('sampleapp2')

```
