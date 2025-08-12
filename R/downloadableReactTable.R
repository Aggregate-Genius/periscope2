# -------------------------------------------------
# -- Application Downloadable React Table Module --
# -------------------------------------------------


#' downloadableReactTable module UI function
#'
#' downloadableReactTable module is extending \code{?reactable} package table functions by creating
#' a custom high-functionality table paired with \link[periscope2]{downloadFile} button.
#' The table has the following default functionality:search, highlight functionality, infinite scrolling, sorting by columns and
#' returns a reactive dataset of selected items and table current state.
#'
#' \link[periscope2]{downloadFile} button will be hidden if \code{downloadableReactTableUI} parameter
#' \code{downloadtypes} is empty
#'
#' @param id character id for the object
#' @param downloadtypes vector of values for data download types
#' @param hovertext download button tooltip hover text
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
#' "Click Here")}
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
#'  library(reactable)
#'
#'  shinyApp(
#'      ui = fluidPage(fluidRow(column(
#'          width = 12,
#'          downloadableReactTableUI(
#'              id            = "object_id1",
#'              downloadtypes = c("csv", "tsv"),
#'              hovertext     = "Download the data here!")))),
#'      server = function(input, output) {
#'          table_state <- downloadableReactTable(
#'              id                 = "object_id1",
#'              table_data         = reactiveVal(iris),
#'              download_data_fxns = list(csv = reactiveVal(iris), tsv = reactiveVal(iris)),
#'              selection_mode     = "multiple",
#'              pre_selected_rows  = function() {c(1, 3, 5)},
#'              table_options      = list(columns = list(
#'                  Sepal.Length = colDef(name = "Sepal Length"),
#'                  Sepal.Width  = colDef(filterable = TRUE),
#'                  Petal.Length = colDef(show = FALSE),
#'                  Petal.Width  = colDef(defaultSortOrder = "desc")),
#'                  showSortable = TRUE,
#'                  theme = reactableTheme(
#'                      borderColor = "#dfe2e5",
#'                      stripedColor = "#f6f8fa",
#'                      highlightColor = "#f0f5f9",
#'                      cellPadding = "8px 12px")))
#'
#'         observeEvent(table_state(), { print(table_state()) })
#'     })
#' }
#'
#' @export
downloadableReactTableUI <- function(id,
                                     downloadtypes = NULL,
                                     hovertext     = NULL) {
    ns <- shiny::NS(id)
    list(
        shiny::conditionalPanel(
            condition = "output.displayButton",
            ns        = ns,
            shiny::span(
                id    = ns("reactTableButtonDiv"),
                class = "periscope-downloadable-react-table-button",
                style = ifelse(length(downloadtypes) > 0, "", "display:none"),
                downloadFileButton(ns("reactTableButtonID"),
                                   downloadtypes,
                                   hovertext))),
        reactable::reactableOutput(ns("reactTableOutputID"))
    )
}


#' downloadableReactTable module server function
#'
#' Server-side function for the downloadableReactTableUI.
#'
#'
#' @param id the ID of the Module's UI element
#' @param table_data reactive expression (or parameter-less function) that acts as table data source
#' @param selection_mode to enable row selection, set \code{selection_mode} value to either "single" for single row
#'                       selection or "multiple" for multiple rows selection, case insensitive. Any other value will
#'                       disable row selection. Row selection will be enabled by radio buttons in "single" selection
#'                       and checkboxes in "multiple" selection (default = NULL)
#' @param pre_selected_rows reactive expression (or parameter-less function) provides the rows indices of the rows to
#'                          be selected when the table is rendered. If selection_mode is disabled, this parameter will
#'                          have no effect. If selection_mode is "single" only the first row index will be used (default = NULL)
#' @param file_name_root the base name used for user-downloaded file. It can be either a character string
#'                       a reactive expression or a function returning a character string (default = 'data_file')
#' @param download_data_fxns a \strong{named} list of functions providing the data as return values.
#'                           The names for the list should be the same names as the ones used in the
#'                           downloadableReactTableUI (default = NULL)
#' @param pagination to enable table pagination (default = FALSE)
#' @param table_height max table height in pixels. Vertical scroll will be shown after that height value
#' @param show_rownames enable displaying rownames as a separate column (default = FALSE)
#' @param columns_filter enable the filtering input on each column in the table (default = FALSE)
#' @param global_search enable table global searching input to search and filter in all columns at once
#'                              (default = TRUE)
#' @param row_highlight enable highlighting rows upon mouse hover (default = TRUE)
#' @param row_striping add zebra-striped style to table rows (default = TRUE)
#' @param table_options optional table formatting parameters check \code{?reactable::reactable} for options full list.
#'                      Also see example below to see how to pass options (default = list())
#' @param logger logger to use (default = NULL)
#'
#' @return A named list of two elements:
#'  \itemize{
#'     \item selected_rows: data.frame of current selected rows
#'     \item table_state: a list of the current table state. The list keys are
#'         ("page", "pageSize", "pages", "sorted" and "selected").
#'          Review \code{?reactable::getReactableState} for more info.
#' }
#'
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
#'  library(reactable)
#'
#'  shinyApp(
#'      ui = fluidPage(fluidRow(column(
#'          width = 12,
#'          downloadableReactTableUI(
#'              id            = "object_id1",
#'              downloadtypes = c("csv", "tsv"),
#'              hovertext     = "Download the data here!")))),
#'      server = function(input, output) {
#'          table_state <- downloadableReactTable(
#'              id                 = "object_id1",
#'              table_data         = reactiveVal(iris),
#'              download_data_fxns = list(csv = reactiveVal(iris), tsv = reactiveVal(iris)),
#'              selection_mode     = "multiple",
#'              pre_selected_rows  = function() {c(1, 3, 5)},
#'              table_options      = list(columns = list(
#'                  Sepal.Length = colDef(name = "Sepal Length"),
#'                  Sepal.Width  = colDef(filterable = TRUE),
#'                  Petal.Length = colDef(show = FALSE),
#'                  Petal.Width  = colDef(defaultSortOrder = "desc")),
#'                  theme = reactableTheme(
#'                      borderColor = "#dfe2e5",
#'                      stripedColor = "#f6f8fa",
#'                      highlightColor = "#f0f5f9",
#'                      cellPadding = "8px 12px")))
#'
#'         observeEvent(table_state(), { print(table_state()) })
#'     })
#' }
#'
#' @export
downloadableReactTable <- function(id,
                                   table_data,
                                   selection_mode     = NULL,
                                   pre_selected_rows  = NULL,
                                   file_name_root     = "data_file",
                                   download_data_fxns = NULL,
                                   pagination         = FALSE,
                                   table_height       = 600,
                                   show_rownames      = FALSE,
                                   columns_filter     = FALSE,
                                   global_search      = TRUE,
                                   row_highlight      = TRUE,
                                   row_striping       = TRUE,
                                   table_options      = list(),
                                   logger             = NULL) {
        shiny::moduleServer(id,
             function(input, output, session) {
                 if (is.null(table_data) || !is.function(table_data)) {
                     logerror("'table_data' parameter must be a function or reactive expression.", logger = logger)
                     output$reactTableOutputID <- reactable::renderReactable({ NULL })
                 } else {
                     table_react_params <- shiny::reactiveValues(table_data        = NULL,
                                                                 pre_selected_rows = NULL)
                     if (is.null(file_name_root)) {
                         logwarn("'file_name_root' parameter should not be NULL. Setting default value 'data_file'.", logger = logger)
                         file_name_root <- "data_file"
                     }

                     downloadFile(id           = "reactTableButtonID",
                                  logger       = logger,
                                  filenameroot = file_name_root,
                                  datafxns     = download_data_fxns)
                     shiny::observe({
                         output$displayButton <- shiny::reactive(length(download_data_fxns) > 0)
                         shiny::outputOptions(output, "displayButton", suspendWhenHidden = FALSE)
                    })

                     if (!is.null(pre_selected_rows) && !is.function(pre_selected_rows)) {
                         logwarn("'pre_selected_rows' parameter must be a function or reactive expression. Setting default value NULL.", logger = logger)
                         pre_selected_rows <- NULL
                     }

                     shiny::observe({
                         if (!is.data.frame(table_data())) {
                             table_data <- shiny::reactiveVal(data.frame(table_data()))
                         }

                         table_react_params$table_data <- table_data()
                         output$displayButton <- shiny::reactive((length(download_data_fxns) > 0))

                         if (NROW(table_react_params$table_data) == 0) {
                            output$displayButton <- shiny::reactive(FALSE)

                         }
                         shiny::outputOptions(output, "displayButton", suspendWhenHidden = FALSE)
                     })

                     shiny::observe({
                         table_react_params$pre_selected_rows <- NULL
                         if ((is.null(selection_mode) || !(tolower(selection_mode) %in% c("single", "multiple"))) &&
                              !is.null(pre_selected_rows)) {
                             logwarn("'selection_mode' parameter must be either 'single' or 'multiple' to use 'pre_selected_rows' param. Setting default value NULL.",
                                     logger = logger)
                         } else if (!is.null(pre_selected_rows) && !is.numeric(pre_selected_rows())) {
                             logwarn("'pre_selected_rows' parameter must be a function or reactive expression that returns numeric vector. Setting default value NULL.",
                                     logger = logger)
                         } else if (!is.null(pre_selected_rows)) {
                             table_react_params$pre_selected_rows <- pre_selected_rows()
                         }

                     })
                     output$reactTableOutputID <- reactable::renderReactable({
                         table_output <- NULL

                         if (!all(is.na(table_react_params$table_data)) &&
                             !is.null(table_react_params$table_data) &&
                             (NCOL(table_react_params$table_data) > 0)) {
                             row_selection_mode <- NULL
                             if (!is.null(selection_mode) && (tolower(selection_mode) %in% c("single", "multiple"))) {
                                 row_selection_mode <- tolower(selection_mode)

                                 if ((row_selection_mode == "single") && (length(table_react_params$pre_selected_rows) > 1)) {
                                     logwarn("when 'selection_mode' is 'single', only first value of 'pre_selected_rows' will be used",
                                             logger = logger)
                                     table_react_params$pre_selected_rows <- table_react_params$pre_selected_rows[1]
                                 }

                                 if (length(table_react_params$pre_selected_rows) > 0) {
                                     excluded_indices <- table_react_params$pre_selected_rows[
                                         sapply(table_react_params$pre_selected_rows,
                                                function(x) {
                                                    x < 1 || x > NROW(table_react_params$table_data)
                                                    })]
                                     if (length(excluded_indices) > 0) {
                                         if (length(excluded_indices) == length(table_react_params$pre_selected_rows)) {
                                             logwarn("All 'pre_selected_rows' values are out of range. Setting default value NULL.",
                                                     logger = logger)
                                             table_react_params$pre_selected_rows <- NULL
                                         } else {
                                             value_msg <- paste("value:", excluded_indices[1] ,"as it is")
                                             if (length(excluded_indices) > 1) {
                                                 value_msg <- paste("values:", paste0(excluded_indices, collapse = ", "), "as they are")
                                             }

                                             logwarn(paste("Excluding 'pre_selected_rows'" , value_msg, "out of range."),
                                                     logger = logger)
                                             table_react_params$pre_selected_rows <- table_react_params$pre_selected_rows[
                                                 !(table_react_params$pre_selected_rows %in% excluded_indices)]
                                         }
                                     }
                                 }
                             }

                             table_arguments <- list(data            = table_react_params$table_data,
                                                     selection       = row_selection_mode,
                                                     defaultSelected = table_react_params$pre_selected_rows,
                                                     pagination      = pagination,
                                                     height          = table_height,
                                                     rownames        = show_rownames,
                                                     filterable      = columns_filter,
                                                     searchable      = global_search,
                                                     highlight       = row_highlight,
                                                     striped         = row_striping)
                             if (length(table_options) > 0) {
                                 all_options       <- methods::formalArgs(reactable::reactable)
                                 unnamed_options   <- append(table_options[names(table_options) == ""],
                                                             table_options[is.null(names(table_options))])
                                 invalid_options <- table_options[!(names(table_options) %in% all_options)]
                                 invalid_options <- invalid_options[!(invalid_options %in% unnamed_options)]
                                 valid_options   <- table_options[names(table_options) %in% all_options]

                                 if (length(unnamed_options) > 0) {
                                     logwarn(paste("Excluding the following unnamed option(s):",
                                                   paste(unnamed_options, collapse = ", ")), logger = logger)
                                 }

                                 if (length(invalid_options) > 0) {
                                     logwarn(paste("Excluding the following invalid option(s):",
                                                   paste(names(invalid_options), collapse = ", ")), logger = logger)
                                 }

                                 table_arguments <- append(table_arguments, valid_options)
                             }

                             table_output <- do.call(reactable::reactable, table_arguments)

                         }
                         table_output
                    })
                 }
                 shiny::reactive({
                     table_state   <- reactable::getReactableState("reactTableOutputID")
                     selected_rows <- NULL
                     if (!is.null(table_state) && !is.null(table_state$selected) && is.data.frame(table_data())) {
                         selected_rows <- table_data()[table_state$selected, ]
                     }
                     list(selected_rows = selected_rows, table_state = table_state)
                 })
            }
        )
}
