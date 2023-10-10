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

        )
    )

    server <- function(input, output, session) {
        observeEvent(input$done, {
            invisible(stopApp())
        })

    }

    viewer <- dialogViewer("Announcement Configuration YAML File Builder")
    runGadget(ui, server, viewer = viewer)
}
