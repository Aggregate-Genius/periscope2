#' Build application theme configuration YAML file
#'
#' Call this as an addin to build valid yaml file that is needed for creating/updating application
#' periscope_style.yaml file. The generated file can be used in periscope2 app using \link[periscope2]{set_app_parameters}.
#'
#' The method can be called directly via `R` console or via RStudio addins menu
#'
#' @return launch gadget window
#'
#' @examples
#' if (interactive()) {
#'    periscope2:::themeConfigurationsAddin()
#' }
#'
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#'
#' @export
themeConfigurationsAddin <- function() {
    shiny::runGadget(app    = themeBuilder_addin_UI(),
                     server = function(input, output, session){
                         themeBuilder_addin_server()
                     },
                     viewer = shiny::browserViewer())
}


themeBuilder_addin_UI <- function() {
    shiny::addResourcePath(prefix        = "img",
                           directoryPath = system.file("fw_templ/www", package = "periscope2"))
    miniUI::miniPage(
        miniUI::gadgetTitleBar("Theme Configuration YAML File Builder"),
        miniUI::miniTabstripPanel(
            miniUI::miniTabPanel(
                "Status Colors",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("periscope2 main theme colors are defined with the following status colors,
                             you can use those status in infoBox, valueBox, cards"),
                    stableColumnLayout(
                        colourpicker::colourInput(inputId    = "primary",
                                                  label      = "Primary",
                                                  showColour = "both",
                                                  value      = "#B221DD"),
                        colourpicker::colourInput(inputId    = "secondary",
                                                  label      = "Secondary",
                                                  showColour = "both",
                                                  value      = "#6c757d")),
                    stableColumnLayout(
                        colourpicker::colourInput(inputId    = "success",
                                                  label      = "Success",
                                                  showColour = "both",
                                                  value      = "#2ED610"),
                        colourpicker::colourInput(inputId    = "info",
                                                  label      = "Info",
                                                  showColour = "both",
                                                  value      = "#7BDFF2")),
                    stableColumnLayout(
                        colourpicker::colourInput(inputId    = "warning",
                                                  label      = "Warning",
                                                  showColour = "both",
                                                  value      = "#FFF200"),
                        colourpicker::colourInput(inputId    = "danger",
                                                  label      = "Danger",
                                                  showColour = "both",
                                                  value      = "#CE0900")),
                    stableColumnLayout(
                        colourpicker::colourInput(inputId    = "light",
                                                  label      = "Light",
                                                  showColour = "both",
                                                  value      = "#f8f9fa"),
                        colourpicker::colourInput(inputId    = "dark",
                                                  label      = "Dark",
                                                  showColour = "both",
                                                  value      = "#343a40"))
               )
           ),
            miniUI::miniTabPanel(
                "Sidebars Colors",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("Sidebar colors variables allow you to change sidebars (left and right) related colors"),
                    shiny::tags$i("Use value \"#00000000\" to reset back to original theme default color"),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "bg",
                                                                 label      = "Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "hover_bg",
                                                                 label      = "Hover Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "color",
                                                                 label      = "Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "hover_color",
                                                                 label      = "Hover Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "active_color",
                                                                 label      = "Active Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "submenu_bg",
                                                                 label      = "Submenu Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "submenu_color",
                                                                 label      = "Submenu Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "submenu_hover_color",
                                                                 label      = "Submenu Hover Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "submenu_hover_bg",
                                                                 label      = "Submenu Hover Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "submenu_active_color",
                                                                 label      = "Submenu Active Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "submenu_active_bg",
                                                                 label      = "Submenu Active Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "header_color",
                                                                 label      = "Header Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"))
               )
           ),
            miniUI::miniTabPanel(
                "Sidebars Layout",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("Sidebar layout variables allow you to change sidebars (left and right) width, padding, ...",
                             shiny::tags$i("All units are in pixels")),
                    stableColumnLayout(shiny::numericInput(inputId = "sidebar_width",
                                                           label   = "Left Sidebar Width",
                                                           value   = NA),
                                       shiny::numericInput(inputId = "control_sidebar_width",
                                                           label   = "Right Sidebar Width",
                                                           value   = NA)),
                    stableColumnLayout(shiny::numericInput(inputId = "sidebar_padding_x",
                                                           label   = "Sidebar Horizontal Padding",
                                                           value   = NA),
                                       shiny::numericInput(inputId = "sidebar_padding_y",
                                                           label   = "Sidebar Vertical Padding",
                                                           value   = NA)),
                    stableColumnLayout(shiny::numericInput(inputId = "sidebar_mini_width",
                                                           label   = "Width for mini sidebar",
                                                           value   = NA))
               )
           ),
            miniUI::miniTabPanel(
                "Main Colors",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("Templates main colors definition"),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "blue",
                                                                 label      = "Blue",
                                                                 showColour = "both",
                                                                 value      = "#007bff"),
                                       colourpicker::colourInput(inputId    = "lightblue",
                                                                 label      = "Light Blue",
                                                                 showColour = "both",
                                                                 value      = "#3c8dbc"),
                                       colourpicker::colourInput(inputId    = "navy",
                                                                 label      = "Navy",
                                                                 showColour = "both",
                                                                 value      = "#001f3f")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "cyan",
                                                                 label      = "Cyan",
                                                                 showColour = "both",
                                                                 value      = "#17a2b8"),
                                       colourpicker::colourInput(inputId    = "teal",
                                                                 label      = "Teal",
                                                                 showColour = "both",
                                                                 value      = "#39cccc"),
                                       colourpicker::colourInput(inputId    = "olive",
                                                                 label      = "Olive",
                                                                 showColour = "both",
                                                                 value      = "#3d9970")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "green",
                                                                 label      = "Green",
                                                                 showColour = "both",
                                                                 value      = "#28a745"),
                                       colourpicker::colourInput(inputId    = "lime",
                                                                 label      = "Lime",
                                                                 showColour = "both",
                                                                 value      = "#01ff70"),
                                       colourpicker::colourInput(inputId    = "orange",
                                                                 label      = "Orange",
                                                                 showColour = "both",
                                                                 value      = "#ff851b")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "yellow",
                                                                 label      = "Yellow",
                                                                 showColour = "both",
                                                                 value      = "#ffc107"),
                                       colourpicker::colourInput(inputId    = "fuchsia",
                                                                 label      = "Fuchsia",
                                                                 showColour = "both",
                                                                 value      = "#f012be"),
                                       colourpicker::colourInput(inputId    = "purple",
                                                                 label      = "Purple",
                                                                 showColour = "both",
                                                                 value      = "#605ca8")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "maroon",
                                                                 label      = "Maroon",
                                                                 showColour = "both",
                                                                 value      = "#d81b60"),
                                       colourpicker::colourInput(inputId    = "red",
                                                                 label      = "Red",
                                                                 showColour = "both",
                                                                 value      = "#dc3545"),
                                       colourpicker::colourInput(inputId    = "black",
                                                                 label      = "Black",
                                                                 showColour = "both",
                                                                 value      = "#111")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "gray_x_light",
                                                                 label      = "Gray X Light",
                                                                 showColour = "both",
                                                                 value      = "#d2d6de"),
                                       colourpicker::colourInput(inputId    = "gray_600",
                                                                 label      = "Gray 600",
                                                                 showColour = "both",
                                                                 value      = "#6c757d"),
                                       colourpicker::colourInput(inputId    = "white",
                                                                 label      = "White",
                                                                 showColour = "both",
                                                                 value      = "#ffffff")),

               )
           ),
            miniUI::miniTabPanel(
                "Color Contrast",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    miniUI::miniContentPanel(
                        shiny::p("These variables allow to customize color",
                                 " used if contrast between a color and its background is",
                                 " under threshold. For example, it's used to choose text color ",
                                 " written in bs4ValueBox with background defined by a status."),
                        stableColumnLayout(
                            shiny::numericInput(inputId = "contrasted_threshold",
                                                label   = periscope2::ui_tooltip(id    = "contrasted_thresholdTip",
                                                                                 label = "Contrasted Threshold",
                                                                                 text  = paste0("The yiq lightness value",
                                                                                                " that determines when the",
                                                                                                " lightness of color changes",
                                                                                                " from \"dark\" to \"light\"",
                                                                                                " Acceptable values are between 0 and
                                                                                                  255.")),
                                                value   = NA,
                                                min     = 0,
                                                max     = 255),
                            colourpicker::colourInput(inputId    = "text_dark",
                                                      label      = periscope2::ui_tooltip(id    = "text_darkTip",
                                                                                          label = "Text Dark",
                                                                                          text  = "Dark text color"),
                                                      showColour = "both",
                                                      value      = "#00000000"),
                            colourpicker::colourInput(inputId    = "text_light",
                                                      label      = periscope2::ui_tooltip(id    = "light_darkTip",
                                                                                          label = "Text Light",
                                                                                          text  = "Light text color"),
                                                      showColour = "both",
                                                      value      = "#00000000")
                       )
                   )
               )
           ),
            miniUI::miniTabPanel(
                "Other Variables",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("This is an advanced method to add customize any more AdminLTE",
                             " or Bootstrap 4 variable in periscope2 generated application theme."),
                    shiny::tags$i("Please refer to ",
                                  shiny::tags$a(href   = "https://adminlte.io/docs/3.2/",
                                                target = "_blank",
                                                "AdminLTE"),
                                  " or ",
                                  shiny::tags$a(href   = "https://getbootstrap.com/docs/4.0/getting-started/theming/",
                                                target = "_blank",
                                                "Bootstrap"),
                                  " documentation for variables details info",
                                  shiny::tags$br(),
                                  shiny::tags$br()),
                    stableColumnLayout(shiny::tags$div(style = "margin-bottom: 30px;",
                                                       shiny::actionButton(inputId = "addVariable",
                                                           label   = "Add Variable"))),
                    stableColumnLayout(shiny::tags$div(id = "variablesPlaceholder"))
               )
           )
       ),
        stableColumnLayout(
            shiny::downloadButton(outputId = "downloadConfig",
                                  label    = periscope2::ui_tooltip(id    = "downloadTip",
                                                                    label = "Download periscope2 theme",
                                                                    text  = "Download theme configuration file"))
       )
   )
}


themeBuilder_addin_server <- function(id = NULL) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            variables       <- fresh::search_vars_bs4dash()
            added_variables <- shiny::reactiveVal(c())
            ids             <- shiny::reactiveVal(c(sample(NROW(variables))))

            observeEvent(input$addVariable, {
                variable_id      <- ids()[1]
                variable_row_id  <- paste0(variable_id,"-variableRow")
                variable_name_id <- paste0(variable_id,"-variableName")
                variable_val_id  <- paste0(variable_id,"-variableValue")
                remove_btn_id    <- paste0(variable_id,"-removeVariableBtn")

                btn <- input$insertBtn
                id <- paste0('txt', btn)
                shiny::insertUI(
                    selector = "#variablesPlaceholder",
                    ui       = shiny::tags$div(id = variable_row_id,
                                              stableColumnLayout(
                                                  shiny::selectizeInput(inputId = variable_name_id,
                                                                        label   = "Select Variable",
                                                                        choices = unique(variables$variable)),
                                                  shiny::textInput(inputId = variable_val_id,
                                                                   label   = "Value"),
                                                  shiny::actionButton(inputId = remove_btn_id,
                                                                      label   = NULL,
                                                                      icon    = shiny::icon("xmark"),
                                                                      style   = "margin-top: 25px;")))
               )

                ids(ids()[-which(ids() == variable_id)])
                observeEvent(input[[remove_btn_id]], {
                    variable_row_id  <- paste0("#", variable_row_id)
                    removeUI(selector = variable_row_id, immediate = TRUE)
                })
            })

            output$downloadConfig <- shiny::downloadHandler(
                filename = function() {
                    "periscope_style.yaml"
                },
                content = function(theme_file) {
                    lines           <- c()
                    status          <- c()
                    sidebar_colors  <- c()
                    sidebar_layout  <- c()
                    main_colors     <- c()
                    other_variables <- c()

                    ### Status colors
                    if (input$primary != "#00000000") {
                        status <- c(status, paste0("primary: ", input$primary))
                    }

                    if (input$secondary != "#00000000") {
                        status <- c(status, paste0("secondary: ", input$secondary))
                    }

                    if (input$success != "#00000000") {
                        status <- c(status, paste0("success: ", input$success))
                    }

                    if (input$info != "#00000000") {
                        status <- c(status, paste0("info: ", input$info))
                    }

                    if (input$warning != "#00000000") {
                        status <- c(status, paste0("warning: ", input$warning))
                    }

                    if (input$danger != "#00000000") {
                        status <- c(status, paste0("danger: ", input$danger))
                    }

                    if (input$light != "#00000000") {
                        status <- c(status, paste0("light: ", input$light))
                    }

                    if (input$dark != "#00000000") {
                        status <- c(status, paste0("dark: ", input$dark))
                    }

                    if (length(status) > 0) {
                        status <- c("# Status Colors",
                                    "## Sets the status colors that affects the color of the header, valueBox, infoBox and box.",
                                    "## Valid values are names of the color or hex-decimal value of the color (i.e,: \"blue\", \"#086A87\").",
                                    "## Blank/empty values will use the default values",
                                    status)
                        lines <- c(lines, status,"\n\n")
                    }

                    ###### Sidebar colors
                    if (input$bg != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Background color"))
                        sidebar_colors <- c(sidebar_colors, paste0("bg: ", input$bg, "\n"))
                    }

                    if (input$hover_bg != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Hover background color"))
                        sidebar_colors <- c(sidebar_colors, paste0("hover_bg: ", input$hover_bg, "\n"))
                    }

                    if (input$color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Color"))
                        sidebar_colors <- c(sidebar_colors, paste0("color: ", input$color, "\n"))
                    }

                    if (input$hover_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Hover color"))
                        sidebar_colors <- c(sidebar_colors, paste0("hover_color: ", input$hover_color, "\n"))
                    }

                    if (input$active_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Active color"))
                        sidebar_colors <- c(sidebar_colors, paste0("active_color: ", input$active_color, "\n"))
                    }

                    if (input$submenu_bg != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu background color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_bg: ", input$submenu_bg, "\n"))
                    }

                    if (input$submenu_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_color: ", input$submenu_color, "\n"))
                    }

                    if (input$submenu_hover_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu hover color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_hover_color: ", input$submenu_hover_color, "\n"))
                    }

                    if (input$submenu_hover_bg != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu hover background color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_hover_bg: ", input$submenu_hover_bg, "\n"))
                    }

                    if (input$submenu_active_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu active color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_active_color: ", input$submenu_active_color, "\n"))
                    }

                    if (input$submenu_active_bg != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Submenu active background color"))
                        sidebar_colors <- c(sidebar_colors, paste0("submenu_active_bg: ", input$submenu_active_bg, "\n"))
                    }

                    if (input$header_color != "#000000") {
                        sidebar_colors <- c(sidebar_colors, paste0("### Header color"))
                        sidebar_colors <- c(sidebar_colors, paste0("header_color: ", input$header_color, "\n"))
                    }

                    if (length(sidebar_colors) > 0) {
                        sidebar_colors <- c("# Sidebars Colors",
                                            "## Sidebar colors variables allow you to change sidebars (left and right) related colors",
                                            "## Blank/empty values will use the default values",
                                            sidebar_colors)
                        lines <- c(lines, sidebar_colors, "\n", "\n")
                    }

                    ###### Sidebar Layout
                    if (input$sidebar_width != "") {
                        sidebar_layout <- c(sidebar_layout, paste0("### Left Sidebar width"))
                        sidebar_layout <- c(sidebar_layout, paste0("sidebar_width: ", input$sidebar_width, "\n"))
                    }

                    if (input$control_sidebar_width != "") {
                        sidebar_layout <- c(sidebar_layout, paste0("### Right Sidebar width"))
                        sidebar_layout <- c(sidebar_layout, paste0("control_sidebar_width: ", input$control_sidebar_width, "\n"))
                    }

                    if (input$sidebar_padding_x != "") {
                        sidebar_layout <- c(sidebar_layout, paste0("### Sidebar horizontal padding"))
                        sidebar_layout <- c(sidebar_layout, paste0("sidebar_padding_x: ", input$sidebar_padding_x, "\n"))
                    }

                    if (input$sidebar_padding_y != "") {
                        sidebar_layout <- c(sidebar_layout, paste0("### Sidebar vertical padding"))
                        sidebar_layout <- c(sidebar_layout, paste0("sidebar_padding_y: ", input$sidebar_padding_y, "\n"))
                    }

                    if (input$sidebar_mini_width != "") {
                        sidebar_layout <- c(sidebar_layout, paste0("### Width for mini sidebar"))
                        sidebar_layout <- c(sidebar_layout, paste0("sidebar_mini_width: ", input$sidebar_mini_width, "\n"))
                    }

                    if (length(sidebar_layout) > 0) {
                        sidebar_layout <- c("# Sidebars Layout",
                                            "## Sidebar colors variables allow you to change sidebars (left and right) related colors",
                                            "## Blank/empty values will use the default values",
                                            sidebar_layout)
                        lines <- c(lines, sidebar_layout, "\n", "\n")
                    }
                    writeLines(lines, theme_file)
                }
           )

            shiny::observeEvent(input$done, {
                shiny::removeResourcePath(prefix = "img")
                invisible(shiny::stopApp())
            })

            shiny::observeEvent(input$cancel, {
                shiny::removeResourcePath(prefix = "img")
                invisible(shiny::stopApp())
            })
        }
   )
}
