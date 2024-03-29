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

library(shiny)
library(periscope2)
library(waiter)
library(shinyWidgets)
library(shinyjs)


# -- Setup your Application --
set_app_parameters(app_info          = NULL,
                   log_level         = "DEBUG",
                   app_version       = "1.0.0",
                   loading_indicator = list(html = tagList(spin_1(), "Loading ..."), color = "rgba(22, 65, 124, 0.3)"))

# -- PROGRAM --

