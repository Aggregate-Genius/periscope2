# -------------------------------------------
# -- Application Downloadable File Module --
# -------------------------------------------


#' downloadFileButton module UI function
#'
#' Creates a custom high-functionality button for file downloads with two
#' states - single download type or multiple-download types.  The button image
#' and pop-up menu (if needed) are set accordingly.  A tooltip can also be set
#' for the button.
#'
#' @param id character id for the object
#' @param downloadtypes vector of values for data download types
#' @param hovertext tooltip hover text
#'
#' @return html span with tooltip and either shiny downloadButton in case of single download or shiny actionButton otherwise
#'
#' @section Button Features:
#' \itemize{
#'     \item Consistent styling of the button, including a hover tooltip
#'     \item Single or multiple types of downloads
#'     \item Ability to download different data for each type of download
#' }
#'
#' @section Example:
#' \code{downloadFileUI("mybuttonID1", c("csv", "tsv"), "Click Here")}
#' \code{downloadFileUI("mybuttonID2", "csv", "Click to download")}
#'
#' @section Shiny Usage:
#' Call this function at the place in ui.R where the button should be placed.
#'
#' It is paired with a call to \code{downloadFile(id, ...)}
#' in server.R
#'
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
#'
#' @examples
#' if (interactive()) {
#'    library(shiny)
#'    library(periscope2)
#'    shinyApp(ui = fluidPage(fluidRow(column(width = 6,
#'      # single download type
#'      downloadFileButton("object_id1",
#'                         downloadtypes = c("csv"),
#'                         hovertext     = "Button 1 Tooltip")),
#'       column(width = 6,
#'       # multiple download types
#'       downloadFileButton("object_id2",
#'                          downloadtypes = c("csv", "tsv"),
#'                          hovertext     = "Button 2 Tooltip")))),
#'      server = function(input, output) {
#'        # single download type
#'        downloadFile(id           = "object_id1",
#'                     logger       = "",
#'                     filenameroot = "mydownload1",
#'                     datafxns     = list(csv = reactiveVal(iris)),
#'                     aspectratio  = 1)
#'        # multiple download types
#'        downloadFile(id           = "object_id2",
#'                     logger       = "",
#'                     filenameroot = "mydownload2",
#'                     datafxns     = list(csv = reactiveVal(mtcars),
#'                     tsv = reactiveVal(mtcars)))
#'    })
#'}
#'
#' @export
downloadFileButton <- function(id,
                               downloadtypes = c("csv"),
                               hovertext     = NULL) {
    ns             <- shiny::NS(id)
    file_button_ui <- ""

    if (length(downloadtypes) > 1) {
        # create dropdown list
        dropdown <- list()
        for (item in downloadtypes) {
            dropdown <- list(dropdown,
                             shiny::tags$li(
                                 shiny::downloadLink(
                                     ns(item),
                                     label = item,
                                     class = "periscope-download-choice")))
        }
        dropdown <- shiny::tagList(dropdown)

        # button with dropdown list
        file_button_ui <- bs4Dash::tooltip(shiny::span(class = "btn-group",
                                                       bs4Dash::actionButton(
                                                           inputId          = ns("downloadFileList"),
                                                           label            = NULL,
                                                           icon             = shiny::icon("copy", lib = "font-awesome"),
                                                           type             = "action",
                                                           class            = "dropdown-toggle periscope-download-btn",
                                                           `data-toggle`    = "dropdown",
                                                           `aria-haspopup`  = "true",
                                                           `aria-expanded`  = "false"),
                                                       shiny::tags$ul(class = "dropdown-menu",
                                                                      id = ns("testList"),
                                                                      dropdown)),
                                           title     = hovertext,
                                           placement = "top")

    } else if (length(downloadtypes) == 1) {
        # single button - no dropdown
        file_button_ui <- bs4Dash::tooltip(shiny::span(shiny::downloadButton(ns(downloadtypes[1]),
                                                                             label = NULL,
                                                                             class = "periscope-download-btn")),
                                           title     = hovertext,
                                           placement = "top")
    }
    file_button_ui
}

check_openxlsx2_availability <- function() {
    length(find.package("openxlsx2", quiet = TRUE)) > 0
}

check_openxlsx_availability <- function() {
    length(find.package("openxlsx", quiet = TRUE)) > 0
}


#' downloadFile module server function
#'
#' Server-side function for the downloadFileButton.  This is a custom
#' high-functionality button for file downloads supporting single or multiple
#' download types.  The server function is used to provide the data for download.
#'
#' @param id ID of the Module's UI element
#' @param logger logger to use
#' @param filenameroot the base text used for user-downloaded file - can be
#' either a character string or a reactive expression that returns a character
#' string
#' @param datafxns a \strong{named} list of functions providing the data as
#' return values.  The names for the list should be the same names that were used
#' when the button UI was created.
#' @param aspectratio the downloaded chart image width:height ratio (ex:
#' 1 = square, 1.3 = 4:3, 0.5 = 1:2). Where not applicable for a download type
#' it is ignored (e.g. data downloads).
#'
#' @return no return value, called for downloading selected file type
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server.R using the same id provided in \code{downloadFileButton}:
#'
#' \strong{\code{downloadFile(id, logger, filenameroot, datafxns)}}
#'
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
#'
#' @examples
#' if (interactive()) {
#'    library(shiny)
#'    library(periscope2)
#'    shinyApp(ui = fluidPage(fluidRow(column(width = 6,
#'      # single download type
#'      downloadFileButton("object_id1",
#'                         downloadtypes = c("csv"),
#'                         hovertext     = "Button 1 Tooltip")),
#'       column(width = 6,
#'       # multiple download types
#'       downloadFileButton("object_id2",
#'                          downloadtypes = c("csv", "tsv"),
#'                          hovertext     = "Button 2 Tooltip")))),
#'      server = function(input, output) {
#'        # single download type
#'        downloadFile(id           = "object_id1",
#'                     logger       = "",
#'                     filenameroot = "mydownload1",
#'                     datafxns     = list(csv = reactiveVal(iris)),
#'                     aspectratio  = 1)
#'        # multiple download types
#'        downloadFile(id           = "object_id2",
#'                     logger       = "",
#'                     filenameroot = "mydownload2",
#'                     datafxns     = list(csv = reactiveVal(mtcars),
#'                     tsv = reactiveVal(mtcars)))
#'    })
#'}
#'
#' @export
downloadFile <- function(id,
                         logger       = NULL,
                         filenameroot = "download",
                         datafxns     = NULL,
                         aspectratio  = 1) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            rootname <- filenameroot
            if ("character" %in% class(filenameroot)) {
                rootname <- shiny::reactive({filenameroot})
            }

            # --- DATA processing

            output$csv  <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "csv", sep = ".")}),
                content  = function(file) {
                    if (!is.null(datafxns)) {
                        writeFile("csv", datafxns$csv(), file, logger,
                                  shiny::reactive({paste(rootname(), "csv", sep = ".")}))
                    }
                })

            output$xlsx <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "xlsx", sep = ".")}),
                content  = function(file) {
                    if (!is.null(datafxns)) {
                        writeFile("xlsx", datafxns$xlsx(), file, logger,
                                  shiny::reactive({paste(rootname(), "xlsx", sep = ".")}))
                    }
                })

            output$tsv  <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "tsv", sep = ".")}),
                content = function(file) {
                    if (!is.null(datafxns)) {
                        writeFile("tsv", datafxns$tsv(), file, logger,
                                  shiny::reactive({paste(rootname(), "tsv", sep = ".")}))
                    }
                })

            output$txt  <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "txt", sep = ".")}),
                content = function(file) {
                    if (!is.null(datafxns)) {
                        writeFile("txt", datafxns$txt(), file, logger,
                                  shiny::reactive({paste(rootname(), "txt", sep = ".")}))
                    }
                })

            # filename is expected to be a reactive expression
            writeFile <- function(type, data, file, logger, filename) {
                # tabular values
                if ((type == "csv") || (type == "tsv")) {
                    show_rownames <- attr(data, "show_rownames")
                    show_rownames <- !is.null(show_rownames) && show_rownames
                    show_colnames <- TRUE
                    if (show_rownames) {
                        show_colnames <- NA
                    }

                    utils::write.table(data, file,
                                       sep = ifelse(type == "tsv", "\t", ","),
                                       dec = ".",
                                       qmethod = "double",
                                       col.names = show_colnames,
                                       row.names = show_rownames)
                }
                # excel file
                else if (type == "xlsx") {

                    if (check_openxlsx2_availability()) {
                        if (inherits(data, "wbWorkbook")) {
                            openxlsx2::wb_save(data, file)
                        } else {
                            show_rownames <- attr(data, "show_rownames")
                            openxlsx2::write_xlsx(data,
                                                  file,
                                                  as_table  = TRUE,
                                                  row_names = !is.null(show_rownames) && show_rownames)
                        }
                    } else if (check_openxlsx_availability()) {
                        if ((inherits(data, "Workbook")) && ("openxlsx" %in% attributes(class(data)))) {
                            openxlsx::saveWorkbook(data, file)
                        } else {
                            show_rownames <- attr(data, "show_rownames")
                            openxlsx::write.xlsx(data,
                                                 file,
                                                 asTable  = TRUE,
                                                 rowNames = !is.null(show_rownames) && show_rownames)
                        }
                    } else {
                        writexl::write_xlsx(data, file)
                    }
                }
                # text file processing
                else if (type == "txt") {
                    if (inherits(data, "character")) {
                        writeLines(data, file)
                    } else if (is.data.frame(data) || is.matrix(data)) {
                        utils::write.table(data, file)
                    } else {
                        msg <- paste(type, "could not be processed")
                        logwarn(msg)
                        warning(msg)
                        writeLines(msg, file)
                    }
                }
                # error - type not handled
                else {
                    msg <- paste(type, "not implemented as a download type")
                    logwarn(msg)
                    warning(msg)
                }
                loginfo(paste("File downloaded in browser: <",
                              filename(), ">"), logger = logger)
            }

            # --- IMAGE processing

            output$png <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "png", sep = ".")}),
                content = function(file) {
                    writeImage("png", datafxns$png(), file, aspectratio, logger,
                               shiny::reactive({paste(rootname(), "png", sep = ".")}))
                })

            output$jpeg <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "jpeg", sep = ".")}),
                content = function(file) {
                    writeImage("jpeg", datafxns$jpeg(), file, aspectratio, logger,
                               shiny::reactive({paste(rootname(), "jpeg", sep = ".")}))
                })

            output$tiff <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "tiff", sep = ".")}),
                content = function(file) {
                    writeImage("tiff", datafxns$tiff(), file, aspectratio, logger,
                               shiny::reactive({paste(rootname(), "tiff", sep = ".")}))
                })

            output$bmp <- shiny::downloadHandler(
                filename = shiny::reactive({paste(rootname(), "bmp", sep = ".")}),
                content = function(file) {
                    writeImage("bmp", datafxns$bmp(), file, aspectratio, logger,
                               shiny::reactive({paste(rootname(), "bmp", sep = ".")}))
                })

            writeImage <- function(type, data, file, aspectratio, logger, filename) {
                dim <- list(width = 7, height = 7/aspectratio, units = "in")

                #ggplot processing
                if (inherits(data, c("ggplot", "ggmatrix", "grob"))) {
                    if (type %in% c("png", "jpeg", "tiff", "bmp")) {
                        ggplot2::ggsave(filename = file,
                                        plot     = data,
                                        width    = dim$width,
                                        height   = dim$height,
                                        units    = dim$units,
                                        scale    = 2)
                    } else {
                        msg <- paste("Unsupported plot type for ggplot download - ",
                                     "must be in: <png, jpeg, tiff, bmp>")
                        logwarn(msg)
                        warning(msg)
                    }
                } else if (inherits(data, "trellis")) {
                    #lattice processing
                    if (type %in% c("png", "jpeg", "tiff", "bmp")) {
                        do.call(type, list(filename = file,
                                           width    = dim$width,
                                           height   = dim$height,
                                           units    = dim$units,
                                           res      = 600))
                        print(data)
                        grDevices::dev.off()
                    }
                    else {
                        msg <- paste("Unsupported plot type for lattice download - ",
                                     "must be in: <png, jpeg, tiff, bmp>")
                        logwarn(msg)
                        warning(msg)
                    }
                } else {
                    # error - type not handled
                    # ------- should really never be hit
                    msg <- paste(type, "not implemented as a download type")
                    logwarn(msg)
                    warning(msg)
                }
                loginfo(paste("File downloaded in browser: <",
                              filename(), ">"), logger = logger)
            }
        })
}


#' Check passed file types against downloadFile module allowed file types list
#'
#' It is a downloadFile module helper to return periscope2 defined file types list and warns user if an invalid type is included
#'
#' @param types list of types to test
#'
#' @return the list input given in types
#'
#' @examples
#'   #inside console
#'   ## Check valid types
#'   result <- periscope2::downloadFile_AvailableTypes()
#'   identical(result, c("csv", "xlsx", "tsv", "txt", "png", "jpeg", "tiff", "bmp"))
#'
#'   ## check invalid type
#'   testthat::expect_warning(downloadFile_ValidateTypes(types = "csv_invalid"),
#'                            "file download list contains an invalid type <csv_invalid>")
#'
#'
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{logViewerOutput}
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadableTableUI}
#' @seealso \link[periscope2]{downloadableTable}
#'
#' @export
downloadFile_ValidateTypes <- function(types) {
    for (type in types) {
        if (!(type %in% shiny::isolate(.g_opts$data_download_types)) &&
            !(type %in% shiny::isolate(.g_opts$plot_download_types)) ) {
            warning(paste0("file download list contains an invalid type <",
                           type, ">"))
        }
    }
    types
}


#' downloadFile module list of allowed file types
#'
#' Returns a list of all supported types
#'
#' @return a vector of all supported types
#'
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[periscope2]{downloadFile}
#'
#' @export
downloadFile_AvailableTypes <- function() {
    c(shiny::isolate(.g_opts$data_download_types),
      shiny::isolate(.g_opts$plot_download_types))
}
