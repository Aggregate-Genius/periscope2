# -------------------------------------
# -- Application Reset Button Module --
# -- Reload Application Sessoon      --
# -------------------------------------

# Module UI Function
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

# Module Server Function
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
