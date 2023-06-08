#' Periscope2 Shiny Application Framework
#'
#' Periscope2 is the next-generation package following the paradigm of the 'periscope' package to
#' support a UI-standardized and rail-guarded enterprise quality application environment.  This package
#' also includes a variety of convenience functions for 'shiny' applications in a more modernized way. Base
#' reusable functionality as well as UI paradigms are included to ensure a consistent user experience
#' regardless of application or developer.
#'
#' 'periscope2' differs from the 'periscope' package as follows:
#' \itemize{
#'  \item Upgraded dependency on bootstrap v4 instead of bootstrap v3
#'  \item New user modules (i.e. announcements)
#'  \item More functionality and finer control over existing modules such as
#'  \link[periscope2:createAlert]{alert} and \link[periscope2:appResetButton]{reset}
#'  \item More control over customizing different application parts (header, footer, left sidebar, right sidebar and body)
#'  \item Enhanced file structure to organize application UI, shiny modules, app configuration, .. etc
#' }
#'
#'
#' A gallery of 'periscope' and 'periscope2' example apps is hosted at \href{http://periscopeapps.org:3838}{http://periscopeapps.org}
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
#' \emph{Update an existing application with a needed sidebar:\cr}
#' \link[periscope2]{create_left_sidebar}\cr
#' \link[periscope2]{create_right_sidebar}\cr
#'
#' \emph{Register user-created UI objects to the requisite application locations:\cr}
#' \link[periscope2]{add_ui_body}\cr
#' \link[periscope2]{add_ui_footer}\cr
#' \link[periscope2]{add_ui_header}\cr
#' \link[periscope2]{add_ui_left_sidebar}\cr
#' \link[periscope2]{add_ui_right_sidebar}
#'
#' \emph{Included shiny modules with a customized UI:\cr}
#' \link[periscope2]{downloadFileButton}\cr
#' \link[periscope2]{downloadableTableUI}\cr
#' \link[periscope2]{downloadablePlotUI}\cr
#' \link[periscope2]{appResetButton}\cr
#' \link[periscope2]{logViewerOutput}\cr
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
