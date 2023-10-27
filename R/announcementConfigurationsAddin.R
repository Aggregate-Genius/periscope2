#' Build Announcement Module Configuration YAML File
#'
#' Call this as an addin to build valid yaml file that is needed for running
#' announcements module. The generated file can be used in periscope2 app using \link[periscope2]{set_app_parameters}.
#'
#' The method can be called directly via `R` console or via RStudio addins menu
#'
#' @return lunches gadget window
#'
#' @examples
#' if (interactive()) {
#'    periscope2:::announcementConfigurationsAddin()
#' }
#'
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#'
#' @export
announcementConfigurationsAddin <- function() {
    shiny::runGadget(app    = announcement_addin_UI(),
                     server = function(input, output, session){
                         announcement_addin_server()
                     },
                     viewer = shiny::dialogViewer("Announcement Configuration YAML File Builder", width = 1000, height = 400))
}


announcement_addin_UI <- function() {
    miniUI::miniPage(
        shinyFeedback::useShinyFeedback(),
        shinyjs::useShinyjs(),
        miniUI::gadgetTitleBar("Announcement Configuration YAML File Builder"),
        miniUI::miniContentPanel(
            stableColumnLayout(
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "startPicker",
                    label   = periscope2::ui_tooltip(id        = "startPickerTip",
                                                     label     = "Start Date",
                                                     text      = paste("First date the announcement will be shown in the application.",
                                                                       "Missing or blank value indicates that the announcement will show immediately.",
                                                                       "Both missing or blank start and end values indicates that the announcement will be always be on."),
                                                     placement = "bottom"),
                    minDate = Sys.Date()),
                shinyWidgets::airDatepickerInput(
                    width   = "100%",
                    inputId = "endPicker",
                    label   = periscope2::ui_tooltip(id        = "endPickerTip",
                                                     label     = "End Date",
                                                     text      = paste("Last date the announcement will be shown in the application.",
                                                                       "Missing or blank value indicates that the announcement will be shown indefinitely",
                                                                       "Both missing or blank start and end values indicates that the announcement will be always be on."),
                                                     placement = "bottom"),
                    minDate = Sys.Date())),
            stableColumnLayout(
                shiny::numericInput(
                    inputId = "auto_close",
                    width   = "100%",
                    label   = periscope2::ui_tooltip(id        = "autoCloseTip",
                                                     label     = "Close after (sec)",
                                                     text      = paste("Time, in seconds, to auto close announcement banner after that time elapsed",
                                                                       "Leave value blank or zero to leave announcement bar open until user closes it manually."),
                                                     placement = "bottom"),
                    value   = 30,
                    min     = 0,
                    max     = 100),
                shiny::selectInput(
                    inputId = "style",
                    width   = "100%",
                    selectize  = FALSE,
                    choices = c("primary", "success", "warning", "danger", "info"),
                    label   = periscope2::ui_tooltip(id        = "styleTip",
                                                     label     = "Style",
                                                     text      = paste("Color for the announcement banner, possible values are {'primary', 'success', 'warning', 'danger' or 'info'}.",
                                                                       "It is a mandatory value."),
                                                     placement = "bottom"))),
            stableColumnLayout(
                shiny::textInput(
                    inputId     = "title",
                    label       = periscope2::ui_tooltip(id        = "styleTip",
                                                         label     = "Title",
                                                         text      = "Optional banner title. Leave it empty to disable it",
                                                         placement = "bottom"),
                    width       = "100%",
                    placeholder = "Announcement Banner Title"
                ),
                shiny::textAreaInput(
                    inputId     = "announcement_text",
                    label       = periscope2::ui_tooltip(id        = "textTip",
                                                         label     = "Announcement Text",
                                                         text      = "The announcement text. Text can contain html tags and is a mandatory value",
                                                         placement = "bottom"),
                    width       = "100%",
                    height      = "100%",
                    placeholder = "Announcement Text")
            ),
            stableColumnLayout(
                shiny::downloadButton(outputId = "downloadConfig",
                                      disabled = TRUE,
                                      label     = periscope2::ui_tooltip(id        = "downloadTip",
                                                                         label     = "Download",
                                                                         text      = "Download announcement configuration file"))
            )
        )
    )
}


announcement_addin_server <- function(id = NULL) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            shiny::observeEvent(input$startPicker, {
                if (!is.null(input$startPicker)) {
                    shinyWidgets::updateAirDateInput(session = session,
                                                     inputId = "endPicker",
                                                     options = list(minDate = input$startPicker))
                }
            })

            shiny::observeEvent(c(input$auto_close,
                                  input$announcement_text), {
                                      auto_close <- as.integer(input$auto_close)
                                      text       <- input$announcement_text
                                      valid      <- TRUE

                                      shinyFeedback::hideFeedback("auto_close")
                                      shinyFeedback::hideFeedback("announcement_text")

                                      if (!is.na(auto_close) && (auto_close < 0)) {
                                          shinyFeedback::showFeedbackDanger(inputId = "auto_close", text = "'auto_close' must be 0, positive or blank")
                                          valid <- FALSE
                                      }

                                      if (is.na(text) || (nchar(text) == 0)) {
                                          shinyFeedback::showFeedbackDanger(inputId = "announcement_text", text = "announcement text is a mandatory value")
                                          valid <- FALSE
                                      }

                                      if (valid) {
                                          shinyjs::enable("downloadConfig")
                                      } else {
                                          shinyjs::disable("downloadConfig")
                                      }

                                  }, ignoreInit = TRUE)

            output$downloadConfig <- shiny::downloadHandler(
                filename = function() {
                    "announce.yaml"
                },
                content = function(announcements_file) {
                    start_date <- ""
                    end_date   <- ""
                    title      <- ""
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
                               paste0("start_date: ", start_date, "\n"),

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
                               paste0("end_date: ", end_date, "\n"),

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
                               paste0("auto_close: ", input$auto_close, "\n"),

                               "### style",
                               "# Color for the announcement banner, possible values are { \"primary\", \"success\", \"warning\", \"danger\" or \"info\"}.",
                               "# It is a mandatory value",
                               paste0("style: \"", input$style, "\"\n"),

                               "### title",
                               "# Optional banner title. Leave it empty to disable it.",
                               paste0("title: \"", input$title, "\"\n"),

                               "### text",
                               "# The announcement text. Text can contain html tags and is a mandatory value",
                               paste0("text: \"", input$announcement_text, "\"\n"))

                    writeLines(lines, announcements_file)
                }
            )

            shiny::observeEvent(input$done, {
                invisible(shiny::stopApp())
            })

        })
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
