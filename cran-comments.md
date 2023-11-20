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
