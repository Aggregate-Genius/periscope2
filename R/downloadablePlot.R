# -------------------------------------------
# -- Application Downloadable Plot Module --
# -------------------------------------------


#' downloadablePlot module UI function
#'
#' Creates a custom plot output that is paired with a linked downloadFile
#' button.  This module is compatible with ggplot2, grob and lattice
#' produced graphics.
#'
#' downloadFile button will be hidden if \code{downloadablePlot} parameter \code{downloadfxns} or
#' \code{downloadablePlotUI} parameter \code{downloadtypes} is empty
#'
#' @param id character id for the object
#' @param downloadtypes vector of values for download types
#' @param download_hovertext download button tooltip hover text
#' @param width plot width (any valid css size value)
#' @param height plot height (any valid css size value)
#' @param btn_halign horizontal position of the download button ("left", "center", "right")
#' @param btn_valign vertical position of the download button ("top", "bottom")
#' @param btn_overlap whether the button should appear on top of the bottom of
#' the plot area to save on vertical space \emph{(there is often a blank area
#' where a button can be overlayed instead of utilizing an entire horizontal
#' row for the button below the plot area)}
#' @param clickOpts NULL or an object created by the \link[shiny]{clickOpts} function
#' @param hoverOpts NULL or an object created by the \link[shiny]{hoverOpts} function
#' @param brushOpts NULL or an object created by the \link[shiny]{brushOpts} function
#'
#' @return list of downloadFileButton UI and plot object
#'
#' @section Example:
#' \code{downloadablePlotUI("myplotID", c("png", "csv"),
#' "Download Plot or Data", "300px")}
#'
#' @section Notes:
#' When there is nothing to download in any of the linked downloadfxns the
#' button will be hidden as there is nothing to download.
#'
#' This module is NOT compatible with the built-in (base) graphics \emph{(such as
#' basic plot, etc.)} because they cannot be saved into an object and are directly
#' output by the system at the time of creation.
#'
#' @section Shiny Usage:
#' Call this function at the place in ui.R where the plot should be placed.
#'
#' Paired with a call to \code{downloadablePlot(id, ...)}
#' in server.R
#'
#' @seealso \link[periscope2]{downloadablePlot}
#' @seealso \link[periscope2]{downloadFileButton}
#' @seealso \link[shiny]{clickOpts}
#' @seealso \link[shiny]{hoverOpts}
#' @seealso \link[shiny]{brushOpts}
#' @seealso \link[periscope2]{appResetButton}
#' @seealso \link[periscope2]{appReset}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadableTable}
#' @seealso \link[periscope2]{logViewerOutput}
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(ggplot2)
#'   library(periscope2)
#'   shinyApp(ui = fluidPage(fluidRow(column(width = 12,
#'      downloadablePlotUI("object_id1",
#'                         downloadtypes      = c("png", "csv"),
#'                         download_hovertext = "Download plot and data",
#'                         height             = "500px",
#'                         btn_halign         = "left")))),
#'     server = function(input, output) {
#'       download_plot <- function() {
#'         ggplot(data = mtcars, aes(x = wt, y = mpg)) +
#'         geom_point(aes(color = cyl)) +
#'         theme(legend.justification = c(1, 1),
#'               legend.position      = c(1, 1),
#'               legend.title         = element_blank()) +
#'         ggtitle("GGPlot Example ") +
#'         xlab("wt") +
#'         ylab("mpg")
#'       }
#'       downloadablePlot(id           = "object_id1",
#'                        logger       = "",
#'                        filenameroot = "mydownload1",
#'                        downloadfxns = list(png = download_plot, csv = reactiveVal(mtcars)),
#'                        aspectratio  = 1.33,
#'                        visibleplot  = download_plot)
#'   })
#'}
#'
#' @export
downloadablePlotUI <- function(id,
                               downloadtypes      = c("png"),
                               download_hovertext = NULL,
                               width              = "100%",
                               height             = "400px",
                               btn_halign         = "right",
                               btn_valign         = "bottom",
                               btn_overlap        = TRUE,
                               clickOpts          = NULL,
                               hoverOpts          = NULL,
                               brushOpts          = NULL) {
    ns       <- shiny::NS(id)
    styleval <- "display:inherit; padding: 5px"

    if (btn_halign == "left") {
        styleval <- paste(styleval, "float:left", sep = ";")
    } else if (btn_halign == "center") {
        styleval <- paste(styleval, "float:none", "margin-left:45%", sep = ";")
    } else if (btn_halign != "right") {
        msg <- paste(btn_halign, " is not a valid btn_halign input - using default",
                     "value. Valid values: <'left', 'center', 'right'>")
        warning(msg)
        btn_halign <- "right"
    }

    if (!(btn_valign %in% c("top", "bottom"))) {
        msg <- paste(btn_valign, " is not a valid btn_valign input - using default",
                     "value. Valid values: <'top', 'bottom'>")
        warning(msg)
        btn_valign <- "bottom"
    }

    if (btn_overlap) {
        styleval <- ifelse(btn_valign == "bottom",
                           paste(styleval, "top: -50px", sep = ";"),
                           paste(styleval, paste0("top: -", height), "position:relative", sep = ";"))
    } else {
        styleval <- ifelse(btn_valign == "bottom",
                           paste(styleval, "top: 5px", sep = ";"),
                           paste(styleval, "top: -5px", sep = ";"))

    }

    btn_item <- shiny::conditionalPanel(
        condition = "output.displayButton",
        ns        = ns,
        shiny::span(id    = ns("dplotButtonDiv"),
                    class = "periscope-downloadable-plot-button",
                    style = styleval,
                    periscope2::downloadFileButton(ns("dplotButtonID"),
                                                   downloadtypes,
                                                   download_hovertext)))

    plot_item <- shiny::plotOutput(outputId = ns("dplotOutputID"),
                                   width    = width,
                                   height   = height,
                                   click    = clickOpts,
                                   hover    = hoverOpts,
                                   brush    = brushOpts)
    module_output <- list(plot_item, btn_item)

    if (!btn_overlap && (btn_valign == "top")) {
        module_output <- list(btn_item, plot_item)
    }

    module_output
}

#' downloadablePlot module server function
#'
#' Server-side function for the downloadablePlotUI.  This is a custom
#' plot output paired with a linked downloadFile button.
#'
#' downloadFile button will be hidden if \code{downloadablePlot} parameter \code{downloadfxns} or
#' \code{downloadablePlotUI} parameter \code{downloadtypes} is empty
#'
#' @param id the ID of the Module's UI element
#' @param logger logger to use
#' @param filenameroot the base text used for user-downloaded file - can be
#' either a character string or a reactive expression returning a character
#' string
#' @param aspectratio the downloaded chart image width:height ratio (ex:
#' 1 = square, 1.3 = 4:3, 0.5 = 1:2).  Where not applicable for a download type
#' it is ignored (e.g. data, html downloads)
#' @param downloadfxns a \strong{named} list of functions providing download
#' images or data tables as return values.  The names for the list should be
#' the same names that were used when the plot UI was created.
#' @param visibleplot function or reactive expression providing the plot to
#' display as a return value.  This function should require no input parameters.
#'
#' @return Reactive expression containing the currently selected plot to be available for display and download
#'
#' @section Notes:
#' When there are no values to download in any of the linked downloadfxns the
#' button will be hidden as there is nothing to download.
#'
#' @section Shiny Usage:
#' This function is not called directly by consumers - it is accessed in
#' server.R using the same id provided in \code{downloadablePlotUI}:
#'
#' \strong{\code{downloadablePlot(id, logger, filenameroot,
#' downloadfxns, visibleplot)}}
#'
#' @seealso \link[periscope2]{downloadablePlotUI}
#' @seealso \link[periscope2]{appResetButton}
#' @seealso \link[periscope2]{appReset}
#' @seealso \link[periscope2]{downloadFile}
#' @seealso \link[periscope2]{downloadFile_ValidateTypes}
#' @seealso \link[periscope2]{downloadFile_AvailableTypes}
#' @seealso \link[periscope2]{downloadableTable}
#' @seealso \link[periscope2]{logViewerOutput}
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(ggplot2)
#'   library(periscope2)
#'   shinyApp(ui = fluidPage(fluidRow(column(width = 12,
#'      downloadablePlotUI("object_id1",
#'                         downloadtypes      = c("png", "csv"),
#'                         download_hovertext = "Download plot and data",
#'                         height             = "500px",
#'                         btn_halign         = "left")))),
#'     server = function(input, output) {
#'       download_plot <- function() {
#'         ggplot(data = mtcars, aes(x = wt, y = mpg)) +
#'         geom_point(aes(color = cyl)) +
#'         theme(legend.justification = c(1, 1),
#'               legend.position      = c(1, 1),
#'               legend.title         = element_blank()) +
#'         ggtitle("GGPlot Example ") +
#'         xlab("wt") +
#'         ylab("mpg")
#'       }
#'       downloadablePlot(id           = "object_id1",
#'                        logger       = "",
#'                        filenameroot = "mydownload1",
#'                        downloadfxns = list(png = download_plot, csv = reactiveVal(mtcars)),
#'                        aspectratio  = 1.33,
#'                        visibleplot  = download_plot)
#'   })
#'}
#'
#' @export
downloadablePlot <- function(id,
                             logger       = NULL,
                             filenameroot = "download",
                             aspectratio  = 1,
                             downloadfxns = NULL,
                             visibleplot) {
    shiny::moduleServer(
        id,
        function(input, output, session) {
            downloadFile("dplotButtonID", logger, filenameroot, downloadfxns, aspectratio)
            dpInfo <- shiny::reactiveValues(visibleplot  = NULL,
                                            downloadfxns = NULL)

            shiny::observe({
                dpInfo$visibleplot   <- visibleplot()
                output$dplotOutputID <- shiny::renderPlot({
                    plot <- dpInfo$visibleplot
                    if (inherits(plot, "grob")) {
                        plot <- grid::grid.draw(plot)
                    }
                    plot
                })
            })

            shiny::observe({
                if (length(downloadfxns) > 0) {
                    dpInfo$downloadfxns <- lapply(downloadfxns, do.call, list())
                    rowct               <- lapply(dpInfo$downloadfxns, is.null)
                    session$sendCustomMessage(
                        "downloadbutton_toggle",
                        message = list(btn  = session$ns("dplotButtonDiv"),
                                       rows = sum(unlist(rowct) == FALSE)) )
                }

                output$displayButton <- shiny::reactive(length(downloadfxns) > 0)
                shiny::outputOptions(output, "displayButton", suspendWhenHidden = FALSE)
            })
        })
}
