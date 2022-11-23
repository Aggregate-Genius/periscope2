# ----------------------------------------
# --          PROGRAM global.R          --
# ----------------------------------------
# USE: Global variables and functions
#
# NOTEs:
#   - All variables/functions here are
#     globally scoped and will be available
#     to server, UI and session scopes
# ----------------------------------------
library(DT)
library(shiny)
library(periscope2)
library(shinyalert)
library(waiter)
library(shinyjs)
library(canvasXpress)


# -- Setup your Application --
set_app_parameters(title              = "periscope Example Application",
                   app_info           = HTML("Demonstrat periscope features and generated application layout"),
                   log_level          = "DEBUG",
                   app_version        = "1.0.0",
                   loading_indicator  = list(html = tagList(spin_1(), "Loading ...")),
                   announcements_file = "./program/config/announce.yaml")

# -- PROGRAM --

