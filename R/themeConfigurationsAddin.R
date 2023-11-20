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
                "Sidebar Colors",
                #icon = icon("code"),
                miniUI::miniContentPanel(
                    shiny::p("Sidebar colors variables allow you to change sidebars (left and right) related colors"),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_bg_color",
                                                                 label      = "Background Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_hover_bg_color",
                                                                 label      = "Hover Background Color",
                                                                 showColour = "both")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_color",
                                                                 label      = "Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_hover_color",
                                                                 label      = "Hover Color",
                                                                 showColour = "both")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_active_color",
                                                                 label      = "Active Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_bg_color",
                                                                 label      = "Submenu Background Color",
                                                                 showColour = "both")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_color",
                                                                 label      = "Submenu Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_hover_color",
                                                                 label      = "Submenu Hover Color",
                                                                 showColour = "both")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_hover_bg_color",
                                                                 label      = "Submenu Hover Background Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_submenu_active_color",
                                                                 label      = "Submenu Active Color",
                                                                 showColour = "both")),
                    stableColumnLayout(colourpicker::colourInput(inputId    = "sb_submenu_active_bg_color",
                                                                 label      = "Submenu Active Background Color",
                                                                 showColour = "both"),
                                       colourpicker::colourInput(inputId    = "sb_header_color",
                                                                 label      = "Header Color",
                                                                 showColour = "both"))
                )
            ),
            miniUI::miniTabPanel(
                "Sidebars",
                #icon = icon("code"),
                miniUI::miniContentPanel()
            ),
            miniUI::miniTabPanel(
                "Navbar",
                #icon = icon("code"),
                miniUI::miniContentPanel()
            ),
            miniUI::miniTabPanel(
                "Colors",
                #icon = icon("code"),
                miniUI::miniContentPanel()
            ),
            miniUI::miniTabPanel(
                "Color Contrast",
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
