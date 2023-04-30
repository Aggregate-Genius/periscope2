#' Periscope2 Shiny Application Framework
#'
#' Periscope2 follows Periscope package on supporting a UI-standardized environment as well as
#' a variety of convenience functions for shiny applications in a more modernized way. Base
#' reusable functionality as well as UI paradigms are included to ensure a
#' consistent user experience regardless of application or developer.
#'
#' Periscope2 is different than Periscope as follow:
#' \itemize{
#'  \item Periscope2 depends on bootstrap v4 while Periscope depends on bootstrap v3
#'  \item Periscope2 has new user modules as \link[periscope2:load_announcements]{announcements} module
#'  \item Periscope2 also updated some of Periscope modules usage to give user more functionality and more control as
#'    \link[periscope2:createAlert]{aler}t and \link[periscope2:appResetButton]{reset} modules
#'  \item Periscope2 gives the user more control on customizing different application parts (header, footer, left sidebar, right sidebar and body)
#'  \item Periscope2 generated application has an updated files structure to organize application UI, shiny modules, app configuration, .. etc
#' }
#'
#'
#' A gallery of example apps is hosted at \href{http://periscopeapps.org:3838}{http://periscopeapps.org}
#'
#' @section Function Overview:
#'
#' \emph{Create a new framework application instance:\cr}
#' \link[periscope2]{create_application}\cr
#'
#' \emph{Set application parameters in program/global.R:\cr}
#' \link[periscope2]{set_app_parameters}\cr
#'
#' \emph{Get any url parameters passed to the application:\cr}
#' \link[periscope2]{get_url_parameters}\cr
#'
#' \emph{Register user-created UI objects to the requisite application locations:\cr}
#' \link[periscope2]{create_left_sidebar}\cr
#' \link[periscope2]{create_right_sidebar}\cr
#' \link[periscope2]{add_ui_header}\cr
#' \link[periscope2]{add_ui_body}\cr
#' \link[periscope2]{add_ui_footer}
#'
#' \emph{Included shiny modules with a customized UI:\cr}
#' \link[periscope2]{downloadFileButton}\cr
#' \link[periscope2]{downloadableTableUI}\cr
#' \link[periscope2]{downloadablePlotUI}
#'
#' \emph{High-functionality standardized tooltips:\cr}
#' \link[periscope2]{ui_tooltip}
#'
#' @section More Information:
#' \code{browseVignettes(package = 'periscope2')}
#'
#' @docType package
#'
#' @name periscope2
NULL


.onAttach <- function(libname, pkgname) {
    current_location <- getwd()
    server_filename  <- "server.R"
    if (interactive() && file.exists(file.path(current_location, c(server_filename)))) {
        server_file    <- file(paste(current_location, server_filename, sep = .Platform$file.sep))
        server_content <- readLines(con = server_file)
        close(server_file)
        if (any(grepl("library\\(logging\\)", server_content))) {
            packageStartupMessage(paste("The logging package is not supported anymore. Please remove the line 'library(logging)' in", server_filename))
        }
    }
}
