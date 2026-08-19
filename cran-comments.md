## Test Environments
    

RStudio Server Pro (Ubuntu 20.04.6 LTS)  

* R 4.5.2

RStudio 2023.06.1+524 (Windows 11 x64 (build 22621))

* R 4.5.1

CircleCI

* R 4.2.0
* R 4.6.1

devtools

* devtools::check(remote = TRUE, manual = TRUE)
* devtools::check(document = TRUE)

WinBuilder

* devtools::check_win_devel()  
* devtools::check_win_release()

RHub

* rhub::rc_submit() # multiple environments are used for testing

---  
    
## R CMD check results
    
    
```
devtools::check()  

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
