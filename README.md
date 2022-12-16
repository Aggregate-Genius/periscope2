---
title:  "periscope2 Shiny Application Framework"
output: 
    html_document:
        self_contained: yes
---


***periscope2*** is an extension of [periscope](https://cran.rstudio.com/web/packages/periscope/index.html) package. It provides a predefined but flexible template for new Shiny applications with a default dashboard layout, three locations for user alerts, a nice busy indicator and logging features. 

One of the most important features of the shiny applications created with this framework is the separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local. The framework forces application developers to consciously consider scoping in Shiny applications by making scoping distinctions very clear without interfering with normal application development. Scoping consideration is important for performance and scaling, which is critical when working with large datasets and/or across many users.  In addition to creating a consistent UI experience this framework reduces development time for new applications by removing some of the boilerplate aspects of new applications such as alerting, logging, etc.

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
