# -------------------------------------------
# -- Application Downloadable React Table Module --
# -------------------------------------------


#' downloadableReactTable module UI function
#'
#' Creates a custom high-functionality table paired with a linked downloadFile
#' button.  The table has search and highlight functionality, infinite scrolling,
#' sorting by columns and returns a reactive dataset of selected items.
#'
#' downloadFile button will be hidden if \code{downloadableReactTable} parameter \code{downloaddatafxn} or
#' \code{downloadableReactTableUI} parameter \code{downloadtypes} is empty
#'
#' @param id character id for the object
#' @param downloadtypes vector of values for data download types
#' @param hovertext download button tooltip hover text
#' @param contentHeight viewable height of the table (any valid css size value)
#' @param singleSelect whether the table should only allow a single row to be
#' selected at a time (FALSE by default allows multi-select).
#'
#' @return list of downloadFileButton UI and DT datatable
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
#'                        downloadtypes = c("csv", "tsv"),
#'                        hovertext     = "Download the data here!",
#'                        contentHeight = "300px",
#'                        singleSelect  = FALSE)))),
#'    server = function(input, output) {
#'      mydataRowIds <- function(){
#'        rownames(head(mtcars))[c(2, 5)]
#'      }
#'      selectedrows <- downloadableReactTable(
#'        id               = "object_id1",
#'        logger           = "",
#'        filenameroot     = "mydownload1",
#'        downloaddatafxns = list(csv = reactiveVal(mtcars), tsv = reactiveVal(mtcars)),
#'        tabledata        = reactiveVal(mtcars),
#'        selection        = mydataRowIds,
#'        table_options    = list(rownames = TRUE,
#'                             caption  = "This is a great table!"))
#'      observeEvent(selectedrows(), {
#'        print(selectedrows())
#'      })})
#'}
#'
#' @export
downloadableReactTableUI <- function(id,
                                downloadtypes = NULL,
                                hovertext     = NULL,
                                contentHeight = "200px",
                                singleSelect  = FALSE) {
    ns <- shiny::NS(id)

    list(
        shiny::conditionalPanel(
            condition = "output.displayButton",
            ns        = ns,
            shiny::span(
                id    = ns("dtableButtonDiv"),
                class = "periscope-downloadable-table-button",
                style = ifelse(length(downloadtypes) > 0, "", "display:none"),
                downloadFileButton(ns("dtableButtonID"),
                                   downloadtypes,
                                   hovertext))),
        DT::dataTableOutput(ns("dtableOutputID")),
        shiny::tags$input(
            id    = ns("dtableOutputHeight"),
            type  = "text",
            class = "shiny-input-container hidden",
            value = contentHeight),
        shiny::tags$input(
            id    = ns("dtableSingleSelect"),
            type  = "text",
            class = "shiny-input-container hidden",
            value = singleSelect)
    )
}


#' downloadableReactTable module server function
#'
#' Server-side function for the downloadableReactTableUI.  This is a custom
#' high-functionality table paired with a linked downloadFile
#' button.
#'
#' downloadFile button will be hidden if \code{downloadableReactTable} parameter \code{downloaddatafxn} or
#' \code{downloadableReactTableUI} parameter \code{downloadtypes} is empty
#'
#' Generated table can highly customized using function \code{?DT::datatable} same arguments
#'  except for `options` and `selection` parameters.
#'
#' For `options` user can pass the same \code{?DT::datatable} options using the same names and
#' values one by one separated by comma.
#'
#' For `selection` parameter it can be either a function or reactive expression providing the row_ids of the
#' rows that should be selected.
#'
#' Also, user can apply the same provided \code{?DT::formatCurrency} columns formats on passed
#' dataset using format functions names as keys and their options as a list.
#'
#'
#' @param id  the ID of the Module's UI element
#' @param logger logger to use
#' @param filenameroot the text used for user-downloaded file - can be
#' either a character string, a reactive expression or a function returning a character
#' string
#' @param downloaddatafxns a \strong{named} list of functions providing the data as
#' return values.  The names for the list should be the same names that were used
#' when the table UI was created.
#' @param tabledata function or reactive expression providing the table display
#' data as a return value. This function should require no input parameters.
#' @param selection function or reactive expression providing the row_ids of the
#' rows that should be selected
#' @param table_options optional table formatting parameters check \code{?DT::datatable} for options full list.
#' Also see example below to see how to pass options
#'
#' @return Reactive expression containing the currently selected rows in the
#' display table
#'
#' @section Notes:
#'  \itemize{
#'   \item When there are no rows to download in any of the linked downloaddatafxns
#'   the button will be hidden as there is nothing to download.
#'   \item \code{selection} parameter has different usage than DT::datatable \code{selection} option.
#'   See parameters usage section.
#'   \item DT::datatable options \code{editable}, \code{width} and \code{height} are not supported
#' }
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server.R using the same id provided in \code{downloadableReactTableUI}:
#'
#' \strong{\code{downloadableReactTable(id, logger, filenameroot,
#' downloaddatafxns, tabledata, rownames, caption, selection)}}
#'
#' \emph{Note}: calling module server returns the reactive expression containing the
#' currently selected rows in the display table.
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
#'                        downloadtypes = c("csv", "tsv"),
#'                        hovertext     = "Download the data here!",
#'                        contentHeight = "300px",
#'                        singleSelect  = FALSE)))),
#'    server = function(input, output) {
#'      mydataRowIds <- function(){
#'        rownames(head(mtcars))[c(2, 5)]
#'      }
#'      selectedrows <- downloadableReactTable(
#'        id               = "object_id1",
#'        logger           = "",
#'        filenameroot     = "mydownload1",
#'        downloaddatafxns = list(csv = reactiveVal(mtcars), tsv = reactiveVal(mtcars)),
#'        tabledata        = reactiveVal(mtcars),
#'        selection        = mydataRowIds,
#'        table_options    = list(rownames = TRUE,
#'                             caption  = "This is a great table!"))
#'      observeEvent(selectedrows(), {
#'        print(selectedrows())
#'      })})
#'}
#'
#' @export
downloadableReactTable <- function(id,
                              logger           = NULL,
                              filenameroot     = "download",
                              downloaddatafxns = NULL,
                              tabledata,
                              selection        = NULL,
                              table_options    = list()) {
        shiny::moduleServer(id,
                        function(input, output, session) {
                            shiny::reactive(iris)
                        }
        )
}
