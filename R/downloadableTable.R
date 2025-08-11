# -------------------------------------------
# -- Application Downloadable Table Module --
# -------------------------------------------


#' downloadableTable module UI function
#'
#' Creates a custom high-functionality table paired with a linked downloadFile
#' button.  The table has search and highlight functionality, infinite scrolling,
#' sorting by columns and returns a reactive dataset of selected items.
#'
#' downloadFile button will be hidden if \code{downloadableTable} parameter \code{downloaddatafxn} or
#' \code{downloadableTableUI} parameter \code{downloadtypes} is empty
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
#' \code{downloadableTableUI("mytableID", c("csv", "tsv"),
#' "Click Here", "300px")}
#'
#' @section Notes:
#' When there are no rows to download in any of the linked downloaddatafxns the
#' button will be hidden as there is nothing to download.
#'
#' @section Shiny Usage:
#' Call this function at the place in ui.R where the table should be placed.
#'
#' Paired with a call to \code{downloadableTable(id, ...)}
#' in server.R
#'
#' @seealso \link[periscope2]{downloadableTable}
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
#'    downloadableTableUI("object_id1",
#'                        downloadtypes = c("csv", "tsv"),
#'                        hovertext     = "Download the data here!",
#'                        contentHeight = "300px",
#'                        singleSelect  = FALSE)))),
#'    server = function(input, output) {
#'      mydataRowIds <- function(){
#'        rownames(head(mtcars))[c(2, 5)]
#'      }
#'      selectedrows <- downloadableTable(
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
downloadableTableUI <- function(id,
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


#' downloadableTable module server function
#'
#' Server-side function for the downloadableTableUI.  This is a custom
#' high-functionality table paired with a linked downloadFile
#' button.
#'
#' downloadFile button will be hidden if \code{downloadableTable} parameter \code{downloaddatafxn} or
#' \code{downloadableTableUI} parameter \code{downloadtypes} is empty
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
#' server.R using the same id provided in \code{downloadableTableUI}:
#'
#' \strong{\code{downloadableTable(id, logger, filenameroot,
#' downloaddatafxns, tabledata, rownames, caption, selection)}}
#'
#' \emph{Note}: calling module server returns the reactive expression containing the
#' currently selected rows in the display table.
#'
#' @seealso \link[periscope2]{downloadableTableUI}
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
#'    downloadableTableUI("object_id1",
#'                        downloadtypes = c("csv", "tsv"),
#'                        hovertext     = "Download the data here!",
#'                        contentHeight = "300px",
#'                        singleSelect  = FALSE)))),
#'    server = function(input, output) {
#'      mydataRowIds <- function(){
#'        rownames(head(mtcars))[c(2, 5)]
#'      }
#'      selectedrows <- downloadableTable(
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
downloadableTable <- function(id,
                              logger           = NULL,
                              filenameroot     = "download",
                              downloaddatafxns = NULL,
                              tabledata,
                              selection        = NULL,
                              table_options    = list()) {
    shiny::moduleServer(id,
                        function(input, output, session) {

                            if (all(!is.null(selection),
                                    is.character(selection))) {
                                message("'selection' parameter must be a function or reactive expression. Setting default value NULL.")
                                selection <- NULL
                            }

                            if (is.null(filenameroot)) {
                                filenameroot <- ""
                            } else if (shiny::is.reactive(filenameroot) || is.function(filenameroot)) {
                                filenameroot <- shiny::isolate(filenameroot())
                            }

                            downloadFile("dtableButtonID", logger, filenameroot, downloaddatafxns)

                            dtInfo <- shiny::reactiveValues(selection = NULL,
                                                            selected  = NULL,
                                                            tabledata = NULL)

                            shiny::observe({
                                result <- list(mode = ifelse(input$dtableSingleSelect == "TRUE", "single", "multiple"))
                                if (!is.null(selection)) {
                                    selection_value <- selection()
                                    if (result[["mode"]] == "single" && length(selection_value) > 1) {
                                        selection_value <- selection_value[1]
                                    }
                                    result[["selected"]] <- selection_value
                                    dtInfo$selection <- NULL
                                }
                                dtInfo$selection <- result
                                dtInfo$selected  <- rownames(result)
                            })

                            shiny::observe({
                                dtInfo$selected  <- input$dtableOutputID_rows_selected
                            })

                            shiny::observe({
                                dtInfo$tabledata <- tabledata()
                            })

                            shiny::observe({
                                output$displayButton <- shiny::reactive(length(downloaddatafxns) > 0)
                                shiny::outputOptions(output, "displayButton", suspendWhenHidden = FALSE)
                            })


                            output$dtableOutputID <- DT::renderDataTable({
                                sourcedata <- dtInfo$tabledata

                                if (NROW(sourcedata) > 0) {
                                    row.names <- rownames(sourcedata)
                                    row.ids   <- as.character(seq(1:NROW(sourcedata)))
                                    if (is.null(row.names) || identical(row.names, row.ids)) {
                                        DT_RowId <- paste0("rowid_", row.ids)
                                        rownames(sourcedata) <- DT_RowId
                                    }
                                }

                                if (is.null(table_options[["scrollY"]])) {
                                    table_options[["scrollY"]] <- input$dtableOutputHeight
                                }

                                table_options[["selection"]] <- dtInfo$selection

                                if (is.null(table_options[["escape"]])) {
                                    table_options[["escape"]] <- FALSE
                                }

                                if (is.null(table_options[["rownames"]])) {
                                    table_options[["rownames"]] <- FALSE
                                }

                                # get format functions
                                format_options_idx <- which(startsWith(names(table_options), "format"))
                                format_options <- table_options[format_options_idx]
                                if (length(format_options_idx) > 0) {
                                    dt_args <- build_datatable_arguments(table_options[-format_options_idx])
                                } else {
                                    dt_args <- build_datatable_arguments(table_options)
                                }

                                if (is.null(sourcedata)) {
                                    sourcedata <- data.frame()
                                }

                                dt_args[["data"]] <- sourcedata

                                tryCatch({
                                    dt <- do.call(DT::datatable, dt_args)

                                    if ((length(format_options) > 0) && (NROW(dt_args$data) > 0)) {
                                        dt <- format_columns(dt, format_options)
                                    }
                                    dt
                                },
                                error = function(e) {
                                    message("Could not apply DT options due to: ", e$message)
                                    DT::datatable(sourcedata)
                                })
                            })


                            shiny::reactive({
                                shiny::isolate(dtInfo$tabledata)[dtInfo$selected, ]
                            })

                        })
}


build_datatable_arguments <- function(table_options) {
    dt_args <- list()
    formal_dt_args <- methods::formalArgs(DT::datatable)
    dt_args[["rownames"]] <- TRUE
    dt_args[["class"]] <- paste("periscope-downloadable-table table-condensed",
                               "table-striped table-responsive")
    options <- list()
    for (option in names(table_options)) {
        if (option %in% c("editable", "width", "height")) {
            message("DT option '", option ,"' is not supported. Ignoring it.")
            next
        }

        if (option %in% formal_dt_args) {
            dt_args[[option]] <- table_options[[option]]
        } else {
            options[[option]] <- table_options[[option]]
        }
    }

    if (is.null(options[["deferRender"]])) {
        options[["deferRender"]] <- FALSE
    }

    if (is.null(options[["paging"]]) && is.null(table_options[["pageLength"]])) {
        options[["paging"]] <- FALSE
    }

    if (is.null(options[["scrollX"]])) {
        options[["scrollX"]] <- TRUE
    }

    if (is.null(options[["dom"]]) && is.null(table_options[["pageLength"]])) {
        options[["dom"]] <- '<"periscope-downloadable-table-header"f>tr'
    }

    if (is.null(options[["processing"]])) {
        options[["processing"]] <- TRUE
    }

    if (is.null(options[["rowId"]])) {
        options[["rowId"]] <- 1
    }

    if (is.null(options[["searchHighlight"]])) {
        options[["searchHighlight"]] <- TRUE
    }
    dt_args[["options"]] <- options
    dt_args
}


format_columns <- function(dt, format_options) {
    for (format_idx in 1:length(format_options)) {
        format_args <- format_options[[format_idx]]
        format_args[["table"]] <- dt
        format <- tolower(names(format_options)[format_idx])
        dt <- switch(format,
                     "formatstyle" = do.call(DT::formatStyle, format_args),
                     "formatdate" = do.call(DT::formatDate, format_args),
                     "formatsignif" = do.call(DT::formatSignif, format_args),
                     "formatround" = do.call(DT::formatRound, format_args),
                     "formatpercentage" = do.call(DT::formatPercentage, format_args),
                     "formatstring" = do.call(DT::formatString, format_args),
                     "formatcurrency" = do.call(DT::formatCurrency, format_args))
    }
    dt
}
