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
    miniUI::miniPage()
}


themeBuilder_addin_server <- function(id = NULL) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
        }
    )
}
