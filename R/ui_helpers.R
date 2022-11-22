#' @export
add_ui_left_sidebar <- function(sidebar_elements = NULL,
                                skin = "light",
                                status,
                                elevation,
                                collapsed,
                                minified,
                                expand_on_hover,
                                fixed,
                                sidebar_menu,
                                custom_area) {
    .g_opts$left_sidebar <- list(list(div(id = "sidebarBasicAlert"),
                                      sidebar_elements),
                                 skin            = skin,
                                 status          = status,
                                 elevation       = elevation,
                                 collapsed       = collapsed,
                                 minified        = minified,
                                 expand_on_hover = expand_on_hover,
                                 fixed           = fixed,
                                 custom_area     = custom_area,
                                 sidebar_menu)
}

#' @export
add_ui_header <- function(skin,
                          status,
                          border,
                          compact,
                          sidebarIcon,
                          controlbarIcon,
                          fixed,
                          left_ui,
                          right_ui) {
    app_title <- shiny::isolate(.g_opts$app_title)
    title     <- div(id = "app_header", app_title)
    app_info  <- shiny::isolate(.g_opts$app_info)

    if (!is.null(app_info) && (class(app_info)[1] == "html")) {
        title <- div(id = "headerAlert",
                     div(id = "app_header"),
                     actionLink("app_info", app_title))
    }
    title_header_alert <- shiny::fluidRow(style = "width:100%",
                                          shiny::column(width = 12, div(id = "announceAlert")),
                                          shiny::column(width = 12, div(id = "headerAlert")),
                                          shiny::column(width = 4,
                                                        div(class = "periscope-busy-ind",
                                                            "Working",
                                                            shiny::img(alt = "Working...",
                                                                       hspace = "5px",
                                                                       src = "img/loader.gif"))),
                                          shiny::column(width = 4, title),
                                          shiny::column(width = 4))
    .g_opts$header <- bs4Dash::bs4DashNavbar(title_header_alert,
                                             skin           = skin,
                                             status         = status,
                                             border         = border,
                                             compact        = compact,
                                             sidebarIcon    = sidebarIcon,
                                             controlbarIcon = controlbarIcon,
                                             fixed          = fixed,
                                             left_ui        = left_ui,
                                             rightUi        = right_ui)
}


#' @export
add_ui_body <- function(body_elements = NULL, append = FALSE) {
    if (append) {
        .g_opts$body_elements <- append(
            shiny::isolate(.g_opts$body_elements),
            body_elements,
            shiny::isolate(length(.g_opts$body_elements)) - 1)
    } else {
        .g_opts$body_elements <- list(div(id = "bodyAlert"),
                                      div(id = "head",
                                          shinyjs::useShinyjs(),
                                          tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/custom.css"),
                                                    tags$head(tags$script(src = "js/custom.js")))),
                                      body_elements)
    }
}

#' @export
createAlert <- function(id = NULL, selector = NULL, options, session = shiny::getDefaultReactiveDomain()) {
    if (!is.null(id) && !is.null(selector)) {
        stop("Please choose either target or selector!")
    }

    message <- bs4Dash:::dropNulls(list(
        id = if (!is.null(id)) session$ns(id),
        selector = selector,
        options = options
    ))

    session$sendCustomMessage("pcreate-alert", message)
}

closeResetAlert <- function(id, session = shiny::getDefaultReactiveDomain()) {
    session$sendCustomMessage("close-alert", id)
}


#' @export
add_ui_right_sidebar <- function(sidebar_elements = NULL,
                                 collapsed,
                                 overlay,
                                 skin,
                                 pinned,
                                 controlbar_menu) {
    .g_opts$right_sidebar <- bs4Dash::bs4DashControlbar(list(div(id = "sidebarRightAlert"),
                                                             sidebar_elements,
                                                             controlbar_menu),
                                                        collapsed = collapsed,
                                                        overlay   = overlay,
                                                        skin      = skin,
                                                        pinned    = pinned)
}

#' @export
add_ui_footer <- function(left, right, fixed) {
    .g_opts$footer <- bs4Dash::bs4DashFooter(left  = list(div(id = "footerAlert"),
                                                          left),
                                             right = right,
                                             fixed = fixed)
}


#' Insert a standardized tooltip
#'
#' This function inserts a standardized tooltip image, label (optional),
#' and hovertext into the application UI
#'
#' @param id character id for the tooltip object
#' @param label text label to appear to the left of the tooltip image
#' @param text tooltip text shown when the user hovers over the image
#'
#' @export
ui_tooltip <- function(id, label = "", text = "", placement = "top") {
    if (is.null(text) || is.na(text) || (text == "")) {
        warning("ui_tooltip() called without tooltip text.")
    }

   shiny::span(class = "periscope-input-label-with-tt",
               label,
               bs4Dash::tooltip(shiny::img(id     = id,
                                           src    = shiny::isolate(.g_opts$tt_image),
                                           height = shiny::isolate(.g_opts$tt_height),
                                           width  = shiny::isolate(.g_opts$tt_width)),
                                title     = text,
                                placement = placement))
}


#' Set Application Parameters
#'
#' This function sets global parameters customizing the shiny application.
#'
#' @param title application title text
#' @param titleinfo character string, HTML value or NULL
#' \itemize{
#' \item{A \strong{character} string will be used to set a link target.  This means the user
#' will be able to click on the application title and be redirected in a new
#' window to whatever value is given in the string.  Any valid URL, File, or
#' other script functionality that would normally be accepted in an <a href=...>
#' tag is allowed.}
#' \item{An \strong{HTML} value will be used to as the HTML content for a modal pop-up
#' window that will appear on-top of the application when the user clicks on the
#' application title.}
#' \item{Supplying \strong{NULL} will disable the title link functionality.}
#' }
#' @param loglevel character string designating the log level to use for
#' the userlog (default = 'DEBUG')
#' @param app_version character string designating the application version (default = '1.0.0').
#'
#' @section Shiny Usage:
#' Call this function from \code{program/global.R} to set the application
#' parameters.
#'
#' @export
set_app_parameters <- function(title,
                               app_info           = NULL,
                               log_level          = "DEBUG",
                               app_version        = "1.0.0",
                               loading_indicator  = NULL,
                               announcements_file = NULL) {
    .g_opts$app_title          <- title
    .g_opts$app_info           <- app_info
    .g_opts$loglevel           <- log_level
    .g_opts$app_version        <- app_version
    .g_opts$loading_indicator  <- loading_indicator
    .g_opts$announcements_file <- announcements_file
}


#' @export
get_app_info <- function() {
    .g_opts$app_info
}


#' @export
get_app_title <- function() {
    .g_opts$app_title
}


#' Get URL Parameters
#'
#' This function returns any url parameters passed to the application as
#' a named list.  Keep in mind url parameters are always user-session scoped
#'
#' @param  session shiny session object
#' @return named list of url parameters and values.  List may be empty if
#' no URL parameters were passed when the application instance was launched.
#'
#' @export
get_url_parameters <- function(session) {
    parameters <- list()

    if (!is.null(session)) {
        raw <- shiny::isolate(session$clientData$url_search)
        parameters <- shiny::parseQueryString(raw)
    }

    parameters
}
