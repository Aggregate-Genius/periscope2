# -------------------------------------
# --      logViewer Module     --
# -- Display application log   --
# -------------------------------------

#' logViewer module UI function
#'
#' Creates a shiny table with table containing logged user actions. Table contents are auto updated whenever a user action is
#' logged
#'
#'
#' @param id character id for the object
#'
#' @returns shiny tableOutput instance
#'
#' @section Table columns:
#' \itemize{
#'     \item action - the action that id logged in any place in app
#'     \item time   - action time
#' }
#'
#' @section Example:
#' \code{logViewerOutput('logViewerId')}
#'
#' @section Shiny Usage:
#' Add the log viewer box to your box list
#'
#' It is paired with a call to \code{logViewer(id, logger)}
#' in server
#'
#'
#' @examples
#' # Inside ui_body add the log viewer box to your box list
#'
#' logViewerOutput('logViewerId')
#'
#'
#' @export
#' @seealso \link[periscope2]{logViewer}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
logViewerOutput <- function(id) {
    ns <- shiny::NS(id)
    shiny::tableOutput(ns("dt_userlog"))
}


#' logViewer module server function
#'
#' Server-side function for the logViewerOutput  This is box with table displaying application logs.
#' The server function is used to provide module configurations.
#'
#' @param id     - the ID of the Module's UI element
#' @param logger - action logs to be displayed
#'
#' @return Shiny table render expression containing the currently logged lines
#'
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server_local.R (or similar file) using the same id provided in \code{logViewerOutput}:
#'
#' \strong{\code{logViewer(id = "logViewerId", logger = ss_userAction.Log)}}
#'
#' @examples
#' # Inside server_local.R
#'
#' #logViewer(id = "logViewerId", logger = ss_userAction.Log)
#'
#' @export
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
#' @seealso \link[periscope2]{appResetButton}
#' @seealso \link[periscope2]{appReset}
logViewer <- function(id, logger) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            output$dt_userlog <- shiny::renderTable({
                lines <- logger()
                if (length(lines) > 0) {
                    out1 <- data.frame(orig = lines, stringsAsFactors = F)
                    loc1 <- regexpr("\\[", out1$orig)
                    loc2 <- regexpr("\\]", out1$orig)

                    out1$logname   <- substr(out1$orig, 1, loc1 - 1)

                    out1$timestamp <- substr(out1$orig, loc1 + 1, loc2 - 1)
                    out1$timestamp <- lubridate::parse_date_time(out1$timestamp, "YmdHMS")

                    out1$action <- substring(out1$orig, loc2 + 1)
                    out1$action <- trimws(out1$action, "both")

                    data.frame(action = out1$action,
                               time   = format(out1$timestamp,
                                               format = .g_opts$datetime.fmt))
                }
            })
        })
}
