# -------------------------------------
# -- Application Reset Button Module --
# -- Reload Application Session      --
# -------------------------------------

#' appResetButton
#'
#' Creates a toggle button to reset application session. Upon pressing on the
#'  button, its state is flipped to cancel application reload with application
#'  and console warning messages indicating that the application will be
#'  reloaded.
#'
#'  User can either resume reloading application session or cancel reloading
#'  process which will also generate application and console messages to
#'  indicate reloading status and result.
#'
#'
#' @param id character id for the object
#'
#' @section Button Features:
#' \itemize{
#'     \item Initial state label is "Application Reset" with warning status
#'     \item Reloading state label is "Cancel Application Reset" with danger
#'           status
#' }
#'
#' @section Example:
#' \code{appReset(id = 'appResetId', logger = logger)}
#'
#' @section Shiny Usage:
#' Call this function at any place in UI section.
#'
#' It is paired with a call to \code{appResetButton(id, ...)}
#' in server
#'
#'
#' @examples
#' # Inside ui_body.R or ui_left_sidebar.R
#'
#' #appReset(id = 'appResetId', logger = logger)
#'
#'
#' @export
appResetButton <- function(id) {
    ns <- shiny::NS(id)

    shiny::div(shinyWidgets::prettyToggle(ns("resetButton"),
                                          label_off  = "Reset Application",
                                          label_on   = "Cancel Application Reset",
                                          shape      = "round",
                                          value      = FALSE,
                                          status_off = "warning",
                                          status_on  = "danger",
                                          width      = "90%",
                                          fill       = TRUE),
               shiny::span(class = "invisible",
                           shinyWidgets::prettyToggle(ns("resetPending"),
                                                      value      = FALSE,
                                                      label_off  = NULL,
                                                      label_on   = NULL))
    )
}


#' appReset Module Server Function
#'
#' Server-side function for the appResetButton  This is a custom
#' high-functionality button for session reload. The server function is used to
#'  provide module configurations.
#'
#' @param id             - the ID of the Module's UI element
#' @param reset_wait     - period to wait before session reload (in milliseconds)
#' @param alert_location - where to display module related messages
#'       (default = "bodyAlert")
#' @param logger         - logger to use
#'
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server_local.R (or similar file) using the same id provided in \code{appResetButton}:
#'
#' \strong{\code{appReset(id = "appResetId", logger = ss_userAction.Log)}}
#'
#' @examples
#' # Inside server_local.R
#'
#' #appReset(id = "appResetId", logger = ss_userAction.Log)
#'
#' @export
appReset <- function(id,
                     reset_wait     = 5000,
                     alert_location = "bodyAlert",
                     logger) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            shiny::observe({
                if (!(alert_location %in% c("bodyAlert", "headerAlert", "footerAlert", "leftAlert", "rightAlert"))) {
                    logwarn("Alert location must be one of standard alert values: 'bodyAlert', 'headerAlert', 'footerAlert', 'leftAlert', 'rightAlert'", logger = logger)
                    logwarn("Setting alert location to 'bodyAlert'")
                }

                pending  <- shiny::isolate(input$resetPending)
                waittime <- reset_wait

                if (!is.null(pending)) {
                    closeResetAlert(alert_location)
                    if (input$resetButton && !(pending)) {
                        # reset initially requested
                        logwarn(paste("Application Reset requested by user. ",
                                      "Resetting in ", (waittime / 1000),
                                      "seconds."),
                                logger = logger)
                        createAlert(
                            selector = paste0("#", alert_location),
                            options  = list(status   = "danger",
                                            title    = "Reset Application",
                                            closable = TRUE,
                                            content  = paste("The application will be reset in",
                                                             (waittime / 1000),
                                                             "seconds if you do not cancel below.")))
                        shinyWidgets::updatePrettyToggle(session,
                                                         "resetPending",
                                                         value = TRUE)
                        shiny::invalidateLater(waittime, session)
                    } else if (!input$resetButton && pending) {
                        # reset cancelled by pushing the button again
                        loginfo("Application Reset cancelled by user.",
                                logger = logger)
                        createAlert(
                            selector = paste0("#", alert_location),
                            options  = list(status   = "success",
                                            title    = "Reset Application",
                                            closable = TRUE,
                                            content  = "The application reset was canceled."))

                        shinyWidgets::updatePrettyToggle(session,
                                                         "resetPending",
                                                         value = FALSE)
                    } else if (pending) {
                        # reset timed out
                        logwarn("Application Reset", logger = logger)
                        session$reload()
                    }
                }
            })
        })
}
