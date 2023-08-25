# -------------------------------------
# --      logViewer Module     --
# -- Display application log   --
# -------------------------------------

#' Display app logs
#'
#' Creates a shiny table with table containing logged user actions. Table contents are auto updated whenever a user action is
#' logged. The id must match the same id configured in \bold{server.R} file upon calling \code{fw_server_setup} method
#'
#'
#' @param id - character id for the object(default = "logViewer")
#'
#' @return shiny tableOutput instance
#'
#' @section Table columns:
#' \itemize{
#'     \item action - the action that id logged in any place in app
#'     \item time   - action time
#' }
#'
#' @section Example:
#' \code{logViewerOutput('logViewer')}
#'
#' @section Shiny Usage:
#' Add the log viewer box to your box list
#'
#' It is paired with a call to \code{fw_server_setup} method in \bold{server.R} file
#'
#'
#' @examples
#' # Inside ui_body add the log viewer box to your box list
#'
#' logViewerOutput('logViewerId')
#'
#'
#' @export
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
logViewerOutput <- function(id = "logViewer") {
    ns <- shiny::NS(id)
    shiny::tableOutput(ns(id))
}


#' logViewer module server function
#'
#' Server-side function for the logViewerOutput  This is box with table displaying application logs.
#' The server function is used to provide module configurations.
#' The function is used internally only by \code{fw_server_setup} method
#'
#' @param id     - the ID of the Module's UI element
#' @param logger - action logs to be displayed
#'
#' @return Shiny table render expression containing the currently logged lines
#'
#'
#' @section Shiny Usage:
#' This function is private and called by \code{fw_server_setup} method only
#'
#' @noRd
logViewer <- function(id = "logViewer", logger) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            output[[id]] <- shiny::renderTable({
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
