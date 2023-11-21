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
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_bg_color",
                                                                 label      = "Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_hover_bg_color",
                                                                 label      = "Hover Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_color",
                                                                 label      = "Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_hover_color",
                                                                 label      = "Hover Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_active_color",
                                                                 label      = "Active Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_bg_color",
                                                                 label      = "Submenu Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_color",
                                                                 label      = "Submenu Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_hover_color",
                                                                 label      = "Submenu Hover Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_hover_bg_color",
                                                                 label      = "Submenu Hover Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_active_color",
                                                                 label      = "Submenu Active Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_active_bg_color",
                                                                 label      = "Submenu Active Background Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"),
                                       colourpicker::colourInput(inputId    = "sb_header_color",
                                                                 label      = "Header Color",
                                                                 showColour = "both",
                                                                 value      = "#00000000"))
                )
            ),
            miniUI::miniTabPanel(
                "Sidebars Layout",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("Sidebar layout variables allow you to change sidebars (left and right) width, paddinh, ..."),
                    stableColumnLayout(shiny::numericInput(inputId = "left_sidebar_width",
                                                           label   = "Left Sidebar Width",
                                                           value   = NA),
                                       shiny::numericInput(inputId = "right_sidebar_width",
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
                                       colourpicker::colourInput(inputId    = "gray_800",
                                                                 label      = "Gray 800t",
                                                                 showColour = "both",
                                                                 value      = "#343a40")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "gray_900",
                                                                 label      = "Gray 900",
                                                                 showColour = "both",
                                                                 value      = "#212529"),
                                       colourpicker::colourInput(inputId    = "white",
                                                                 label      = "White",
                                                                 showColour = "both",
                                                                 value      = "#ffffff"))
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
                "Custom Variables",
                #icon = icon("code"),
                miniUI::miniContentPanel()
            )
        )
    )
}


themeBuilder_addin_server <- function(id = NULL) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
        }
    )
}
