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
                    inputId = "style",
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
        output$downloadConfig <- shiny::downloadHandler(
            filename = function() {
                "announce.yaml"
            },
            content = function(announcements_file) {
                start_date <- ""
                end_date   <- ""
                style      <- "Info"
                title      <- ""
                text       <- ""
                auto_close <- ""

                if (!is.null(input$startPicker)) {
                    start_date <- as.character(input$startPicker)
                }

                if (!is.null(input$endPicker)) {
                    end_date <- as.character(input$endPicker)
                }

                lines <- c("### start_date",
                           "# First date the announcement will be shown in the application",
                           "# Missing or blank value indicates that the announcement will show immediately.",
                           "# Both missing or blank start and end values indicates that the announcement will be always be on.",
                           paste("start_date: ", start_date, "\n"),

                           "### start_date_format",
                           "# Format symbols are:",
                           "#                    %Y: for year (1999),",
                           "#                    %y: for year format (99),",
                           "#                    %m: for month (1-12),",
                           "#                    %d: for day (1-31)",
                           "# All formats must be inside double quotation.",
                           "# Leave this field blank to use default format which is \"%Y-%m-%d\"",
                           "start_date_format:\n",

                           "### end_date",
                           "# Last date the announcement will be shown in the application.",
                           "# Missing or blank value indicates that the announcement will be shown indefinitely",
                           "# Both missing or blank start and end values indicates that the announcement will be always be on.",
                           paste("end_date: ", end_date, "\n"),

                           "### end_date_format",
                           "# Format symbols are:",
                           "#                    %Y: for year (1999),",
                           "#                    %y: for year format (99),",
                           "#                    %m: for month (1-12),",
                           "#                    %d: for day (1-31)",
                           "# All formats must be inside double quotation.",
                           "# Leave this field blank to use default format which is \"%Y-%m-%d\"",
                           "end_date_format:\n",

                           "### auto_close",
                           "# Time, in seconds, to auto close announcement banner after that time elapsed",
                           "# Leave value blank or zero to leave announcement bar open until user closes it manually.",
                           paste("auto_close: ", input$auto_close, "\n"),

                           "### style",
                           "# Color for the announcement banner, possible values are { \"primary\", \"success\", \"warning\", \"danger\" or \"info\"}.",
                           "# It is a mandatory value",
                           paste("style: ", input$style, "\n"),

                           "### title",
                           "# Optional banner title. Leave it empty to disable it.",
                           paste("title: \"", input$title, "\"\n"),

                           "### text",
                           "# The announcement text. Text can contain html tags and is a mandatory value",
                           paste("text: \"", input$text, "\"\n"))

                writeLines(lines, announcements_file)
            }
        )
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
