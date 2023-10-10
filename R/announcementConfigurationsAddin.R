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
            fillCol(fillRow(shinyWidgets::airDatepickerInput(
                inputId = "startPicker",
                label   = periscope2::ui_tooltip(id    = "startPickerTip",
                                                 label = "Start Date",
                                                 text  = "Top tooltip",
                                                 placement = "right"),
                minDate = Sys.Date()),
                shinyWidgets::airDatepickerInput(
                    inputId = "endPicker",
                    label   = periscope2::ui_tooltip(id    = "endPickerTip",
                                                     label = "End Date",
                                                     text  = "Top tooltip",
                                                     placement = "bottom"),
                    minDate = Sys.Date())),
                fillRow(shiny::selectizeInput(inputId = "style_id",
                                              choices = c("primary", "success", "warning", "danger", "info"),
                                              label   = "Style")))
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
