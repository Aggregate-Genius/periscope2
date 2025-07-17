# -------------------------------------------------
# -- Application Downloadable React Table Module --
# -------------------------------------------------


#' downloadableReactTable module UI function
#'
#' downloadableReactTable module is extending \code{?reactable} package table functions by creating
#' a custom high-functionality table paired with \link[periscope2]{downloadFile} button.
#' The table has the following default functionality:search, highlight functionality, infinite scrolling, sorting by columns and
#' returns a reactive dataset of selected items.
#'
#' \link[periscope2]{downloadFile} button will be hidden if \code{downloadableReactTableUI} parameter
#' \code{downloadtypes} is empty
#'
#' @param id character id for the object
#' @param downloadtypes vector of values for data download types
#' @param hovertext download button tooltip hover text
#' @param contentHeight viewable height of the table (any valid css size value)
#'
#' @return list of downloadFileButton UI and reactable table and hidden inputs for contentHeight option
#'
#' @section Table Features:
#' \itemize{
#'     \item Consistent styling of the table
#'     \item downloadFile module button functionality built-in to the table (it will be shown only if downloadtypes is defined)
#'     \item Ability to show different data from the download data
#'     \item Table is automatically fit to the window size with infinite
#'     y-scrolling
#'     \item Table search functionality including highlighting built-in
#'     \item Multi-select built in, including reactive feedback on which table
#'     items are selected
#' }
#'
#' @section Example:
#' \code{downloadableReactTableUI("mytableID", c("csv", "tsv"),
#' "Click Here", "300px")}
#'
#' @section Notes:
#' When there are no rows to download in any of the linked downloaddatafxns the
#' button will be hidden as there is nothing to download.
#'
#' @section Shiny Usage:
#' Call this function at the place in ui.R where the table should be placed.
#'
#' Paired with a call to \code{downloadableReactTable(id, ...)}
#' in server.R
#'
#' @seealso \link[periscope2]{downloadableReactTable}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadablePlot}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(periscope2)
#'  shinyApp(ui = fluidPage(fluidRow(column(width = 12,
#'    downloadableReactTableUI("object_id1",
#'                             downloadtypes = c("csv", "tsv"),
#'                             hovertext     = "Download the data here!",
#'                             contentHeight = "300px"))),
#'    server = function(input, output) {
#'        downloadableReactTable(id             = "object_id1",
#'                               table_datam    = reactiveVal(mtcars),
#'                               selection_mode = "multiple")})
#'}
#'
#' @export
downloadableReactTableUI <- function(id,
                                     downloadtypes = NULL,
                                     hovertext     = NULL,
                                     contentHeight = "200px") {
    ns <- shiny::NS(id)
    list(
        shiny::conditionalPanel(
            # TODO: this condition should be set in the server when
            # download function is active
            condition = "output.displayButton",
            ns        = ns,
            shiny::span(
                id    = ns("reactTableButtonDiv"),
                # TODO: Review this style class when
                # download function is active to make sure it is consistent with
                # the table look and feel
                class = "periscope-downloadable-table-button",
                style = ifelse(length(downloadtypes) > 0, "", "display:none"),
                # TODO: Review download button styles and make sure it is
                # consistent with the new table when download function is active
                downloadFileButton(ns("reactTableButtonID"),
                                   downloadtypes,
                                   hovertext))),
        reactable::reactableOutput(ns("reactTableOutputID")),
        # TODO: test this function when table options are passed to
        # server function
        shiny::tags$input(
            id    = ns("reactTableOutputHeight"),
            type  = "text",
            class = "shiny-input-container hidden",
            value = contentHeight)
        )
}


#' downloadableReactTable module server function
#'
#' Server-side function for the downloadableReactTableUI.
#'
#'
#' @param id  the ID of the Module's UI element
#' @param table_data reactive expression (or parameter-less function) that acts as table data source
#' @param selection_mode to enable row selection, set \code{selection_mode} value to either "single" for single row
#'                       selection or "multiple" for multiple rows selection, case insensitive. Any other value will
#'                       disable row selection, (default = NULL). An additional column will be added to the table if
#'                       selection mode is enabled with rabio buttons for single row selection and checkboxes for
#'                       "multiple" rows selection mode.
#'
#' @return Rendered react table
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server.R using the same id provided in \code{downloadableReactTableUI}:
#'
#' \strong{\code{downloadableReactTable(id)}}
#'
#' @seealso \link[periscope2]{downloadableReactTableUI}
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadablePlot}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(periscope2)
#'  shinyApp(ui = fluidPage(fluidRow(column(width = 12,
#'    downloadableReactTableUI("object_id1",
#'                             downloadtypes = c("csv", "tsv"),
#'                             hovertext     = "Download the data here!")))),
#'    server = function(input, output) {
#'        downloadableReactTable(id             = "object_id1",
#'                               table_data     = reactiveVal(mtcars),
#'                               selection_mode = "multiple")})
#'}
#'
#' @export
downloadableReactTable <- function(id,
                                   table_data,
                                   selection_mode = NULL) {
        shiny::moduleServer(id,
             function(input, output, session) {
                 if (is.null(table_data) || !is.function(table_data)) {
                     output$reactTableOutputID <- reactable::renderReactable({ NULL })
                 } else {
                     table_react_params <- shiny::reactiveValues(table_data = NULL)
                     shiny::observe({
                         if (!is.data.frame(table_data())) {
                             table_data <- shiny::reactiveVal(data.frame(table_data()))
                         }
                         table_react_params$table_data <- table_data()
                     })
                     output$reactTableOutputID <- reactable::renderReactable({
                         table_output <- NULL
                         if (!is.null(table_react_params$table_data) && (NCOL(table_react_params$table_data) > 0)) {
                             row_selection_mode <- NULL
                             if (!is.null(selection_mode) && (tolower(selection_mode) %in% c("single", "multiple"))) {
                                 row_selection_mode <- tolower(selection_mode)
                             }
                             table_output <- reactable::reactable(data      = table_react_params$table_data,
                                                                  selection = row_selection_mode,
                                                                  defaultSelected = NULL)
                         }
                         table_output
                    })
                }
            }
        )
}
