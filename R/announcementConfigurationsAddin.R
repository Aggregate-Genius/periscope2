#' Build Announcement Module Configuration YAML File
#'
#' Call this as an addin to build valid yaml file that is needed for running
#' announcements file
#'
#' @export
announcementConfigurationsAddin <- function() {
    ui <- miniUI::miniPage(
        miniUI::gadgetTitleBar("Announcement Configuration YAML File Builder"),
        miniUI::miniContentPanel(
            stableColumnLayout(
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "startPicker",
                    label   = periscope2::ui_tooltip(id        = "startPickerTip",
                                                     label     = "Start Date",
                                                     text      = paste("<p>First date the announcement will be shown in the application.<br/>",
                                                                       "Missing or blank value indicates that the announcement will show immediately.<br/>",
                                                                       "Both missing or blank start and end values indicates that the announcement will be always be on.</p>"),
                                                     placement = "bottom"),
                    minDate = Sys.Date()),
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "endPicker",
                    label   = periscope2::ui_tooltip(id        = "endPickerTip",
                                                     label     = "End Date",
                                                     text      = "Top tooltip",
                                                     placement = "bottom"),
                    minDate = Sys.Date())),
            stableColumnLayout(
                shiny::numericInput(
                    inputId = "auto_close",
                    width   = "100%",
                    label   = "Close after (sec):",
                    value   = 30,
                    min     = 0,
                    max     = 100),
                shiny::selectizeInput(
                    inputId = "style_id",
                    width   = "100%",
                    choices = c("primary", "success", "warning", "danger", "info"),
                    label   = "Style")),
            stableColumnLayout(
                shiny::textInput(
                    inputId     = "title",
                    label       = "Title",
                    width       = "100%",
                    placeholder = "Announcement Banner Title"
                ),
                shiny::textAreaInput(
                    inputId     = "announcement_text",
                    label       = "Text",
                    width       = "100%",
                    height      = "100%",
                    placeholder = "Announcement Text")
            ),
            stableColumnLayout(
                shiny::downloadButton(outputId = "downloadConfig",
                                      label     = periscope2::ui_tooltip(id        = "downloadTip",
                                                                         label     = "Download",
                                                                         text      = "Download announcement configuration file"))
            )
        )
    )

    server <- function(input, output, session) {
        shiny::observeEvent(input$done, {
            invisible(stopApp())
        })

    }

    viewer <- shiny::dialogViewer("Announcement Configuration YAML File Builder", width = 1000, height = 800)
    shiny::runGadget(ui, server, viewer = viewer)
}

stableColumnLayout <- function(...) {
    dots  <- list(...)
    n     <- length(dots)
    width <- 12 / n
    class <- sprintf("col-xs-%s col-md-%s", width, width)
    shiny::fluidRow(
        lapply(dots, function(el) {
            shiny::tags$div(class = class, el)
        })
    )
}
