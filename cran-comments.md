# Round 2
12.08.2023

## Reviewer comments

- Please always write package names, software names and API (application
programming interface) names in single quotes in title and description.
e.g: --> 'BS4Dash', 'shuiny'

- Please note that package names are case sensitive.

- Please do not start the description with "This package", package name,
title or similar.

- Please proof-read your description text.
There should probably be a comma after "... additional and enhanced
shiny modules"

- Please write references in the description of the DESCRIPTION file in
the form <br/>
`authors (year) <doi:...>`<br/>
`authors (year) <arXiv:...>`<br/>
`authors (year, ISBN:...)`<br/>

  - or if those are not available: authors (year) <[https:...]https:...>
with no space after 'doi:', 'arXiv:', 'https:' and angle brackets for
auto-linking.
(If you want to add a title as well please put it in quotes: "Title")

- Please add \value to .Rd files regarding exported methods and explain
the functions results in the documentation. Please write about the
structure of the output (class) and also what the output means. (If a
function does not return a value, please document that too, e.g.
\value{No return value, called for side effects} or similar)
  Missing Rd-tags in up to 17 .Rd files, e.g.:<br/>
      `add_ui_body.Rd: \value`<br/>
      `add_ui_footer.Rd: \value`<br/>
      `add_ui_header.Rd: \value`<br/>
      `add_ui_left_sidebar.Rd: \value`<br/>
      `add_ui_right_sidebar.Rd: \value`<br/>
      `create_application.Rd: \value`<br/>

- Some code lines in examples are commented out.
Please never do that. Ideally find toy examples that can be regularly
executed and checked. Lengthy examples (> 5 sec), can be wrapped in
\donttest{}.
Examples in comments in:
       appReset.Rd

- Please do not modify the global environment (e.g. by using <<-) in your
functions. This is not allowed by the CRAN policies. e.g.: R/logger.R

- You are using installed.packages() in your code. As mentioned in the
notes of installed.packages() help page, this can be very slow.
Therefore do not use installed.packages().  e.g.: R/downloadFile.R

## Comments from Maintainer

- DESCRIPTION file changes:
  - Updated packages names in title and description fields and placed them inside single quotes
  - Rephrased "Description" Field to avoid previous phrasing issues
  - Added references to APIs in "Description" Field
- Package documentation changes:
  - Added `return` value tag to functions that were missing that tag
  - Uncommitted code in functions examples and used `\dontrun` macro whenever is needed
- Package code changes:
  - Refactored any global assignment "<<-" usage, no code is modifying the global environment
  - Refactored `installed.packages` function usage and used `find.package` function

## Test Environments
    

RStudio Server Pro (Ubuntu 20.04.6 LTS)  

* R 4.2.3
* R 4.3.1

RStudio 2023.06.1+524 (Windows 11 x64 (build 22621))

* R 4.3.0

CircleCI

* R 4.0.5
* R 4.3.1

devtools

* devtools::check(remote = TRUE, manual = TRUE)

WinBuilder

* devtools::check_win_devel()  
* devtools::check_win_release()

RHub

* devtools::check_rhub(interactive = F, env_vars = c("R_CHECK_FORCE_SUGGESTS" = "false"))
* rhub::check_for_cran()

---  
    
## R CMD check results
    
    
```
devtools::check()  

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```

----

# Round 1
07.08.2023

## Comments from Maintainer

This is the initial release for this package to CRAN, and due to this there is a package build NOTE on rhub and win-builder builds about this being a new package release. Beside the following rhub note about possibly misspelled words in DESCRIPTION file (but they are not):
  customizable (13:48)
  scalable (12:5)
  UI (12:18, 13:61)

---  
    
## Test Environments
    

RStudio Server Pro (Ubuntu 20.04.6 LTS)  

* R 4.2.3
* R 4.3.1

RStudio 2023.06.1+524 (Windows 11 x64 (build 22621))

* R 4.3.0

CircleCI

* R 4.0.5
* R 4.3.1

devtools

* devtools::check(remote = TRUE, manual = TRUE)

WinBuilder

* devtools::check_win_devel()  
* devtools::check_win_release()

RHub

* devtools::check_rhub(interactive = F, env_vars = c("R_CHECK_FORCE_SUGGESTS" = "false"))
* rhub::check_for_cran()

---  
    
## R CMD check results
    
    
```
devtools::check()  

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
