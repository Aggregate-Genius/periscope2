# ----------------------------------------
# --          PROGRAM global.R          --
# ----------------------------------------
# USE: Global variables and functions
#
# NOTES:
#   - All variables/functions here are
#     globally scoped and will be available
#     to server, UI and session scopes
# ----------------------------------------
library(DT)
library(shiny)
library(periscope2)
library(waiter)
library(shinyjs)
library(canvasXpress)


# -- Setup your Application --
set_app_parameters(app_info          = HTML("Demonstrate periscope features and generated application layout"),
                   log_level         = "DEBUG",
                   app_version       = "1.0.0",
                   loading_indicator = list(html = spin_1(), color = 'rgba(22, 65, 124, 0.3)'))

# -- PROGRAM --

