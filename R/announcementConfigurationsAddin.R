#' Build Announcement Module Configuration YAML File
#'
#' Call this as an addin to build valid yaml file that is needed for running
#' announcements file
#'
#' @export
announcementConfigurationsAddin <- function() {
    ui <- miniPage(
        gadgetTitleBar("Announcement Configuration YAML File Builder"),
        miniContentPanel(
            stableColumnLayout(
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "startPicker",
                    label   = periscope2::ui_tooltip(id    = "startPickerTip",
                                                     label = "Start Date",
                                                     text  = "Top tooltip",
                                                     placement = "right"),
                    minDate = Sys.Date()),
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "endPicker",
                    label   = periscope2::ui_tooltip(id    = "endPickerTip",
                                                     label = "End Date",
                                                     text  = "Top tooltip",
                                                     placement = "bottom"),
                    minDate = Sys.Date())),
            stableColumnLayout(
                shiny::numericInput(inputId = "auto_close",
                                    width   = "100%",
                                    label   = "Close after (sec):",
                                    value   = 30,
                                    min     = 0,
                                    max     = 100),
                shiny::selectizeInput(inputId = "style_id",
                                      width   = "100%",
                                      choices = c("primary", "success", "warning", "danger", "info"),
                                      label   = "Style"))
        )
    )

    server <- function(input, output, session) {
        observeEvent(input$done, {
            invisible(stopApp())
        })

    }

    viewer <- dialogViewer("Announcement Configuration YAML File Builder", width = 1000, height = 800)
    runGadget(ui, server, viewer = viewer)
}

stableColumnLayout <- function(...) {
    dots <- list(...)
    n <- length(dots)
    width <- 12 / n
    class <- sprintf("col-xs-%s col-md-%s", width, width)
    fluidRow(
        lapply(dots, function(el) {
            div(class = class, el)
        })
    )
}
