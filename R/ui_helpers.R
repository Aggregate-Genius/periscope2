#' add_ui_left_sidebar
#'
#' This function adds left sidebar configurations and elements. It is called within "ui_left_sidebar.R".
#' Check example application for detailed example
#'
#' @param sidebar_elements list of shiny ui elements
#' @param skin Sidebar skin. "dark" or "light".
#' @param status Sidebar status. Check \code{?bs4Dash::dashboardSidebar()} for list of valid values
#' @param elevation Sidebar elevation. 4 by default (until 5)
#' @param collapsed If TRUE, the sidebar will be collapsed on app startup.
#' @param minified 	Whether to slightly close the sidebar but still show item icons. Default to TRUE
#' @param expand_on_hover Whether to expand the sidebar om hover. TRUE by default.
#' @param fixed character Whether to fix the sidebar. Default to TRUE.
#' @param sidebar_menu sidebar menu items
#' @param custom_area Sidebar bottom space area. Only works if sidebar is fixed
#'
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
    .g_opts$left_sidebar <- list(list(shiny::div(id = "sidebarBasicAlert"),
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


#' add_ui_header
#'
#' Builds application header with given configurations and elements. It is called within "ui_header.R".
#' Check example application for detailed example
#'
#' @param skin Sidebar skin. "dark" or "light".
#' @param status Sidebar status. Check \code{?bs4Dash::bs4DashNavbar()} for list of valid values
#' @param border Whether to separate the navbar and body by a border. TRUE by default.
#' @param compact Whether items should be compacted. FALSE by default.
#' @param sidebarIcon Icon of the main sidebar toggle
#' @param controlbarIcon Icon to toggle the controlbar (left)
#' @param fixed Whether to fix the navbar to the top. FALSE by default.
#' @param left_ui Custom left Ui content. Any element like dropdownMenu.
#' @param right_ui Custom right Ui content. Any element like dropdownMenu.
#'
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
    title     <- shiny::div(id = "app_header", app_title)
    app_info  <- shiny::isolate(.g_opts$app_info)

    if (!is.null(app_info) && (class(app_info)[1] == "html")) {
        title <- shiny::div(id = "headerAlert",
                            shiny::div(id = "app_header"),
                            shiny::actionLink("app_info", app_title))
    }
    title_header_alert <- shiny::fluidRow(style = "width:100%",
                                          shiny::column(width = 12, shiny::div(id = "announceAlert")),
                                          shiny::column(width = 12, shiny::div(id = "headerAlert")),
                                          shiny::column(width = 4,
                                                        shiny::div(class = "periscope-busy-ind",
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


#' add_ui_body
#'
#' Builds application body with given configurations and elements. It is called within "ui_body.R".
#' Check example application for detailed example
#'
#' @param body_elements list of ui elements to be displayed in application body
#' @param append add elements to current body elements or remove previous body elements (default = FALSE)
#'
#' @export
add_ui_body <- function(body_elements = NULL, append = FALSE) {
    if (append) {
        .g_opts$body_elements <- append(
            shiny::isolate(.g_opts$body_elements),
            body_elements,
            shiny::isolate(length(.g_opts$body_elements)) - 1)
    } else {
        .g_opts$body_elements <- list(shiny::div(id = "bodyAlert"),
                                      shiny::div(id = "head",
                                                 shinyjs::useShinyjs(),
                                                 shiny::tags$head(shiny::tags$link(rel  = "stylesheet",
                                                                                   type = "text/css",
                                                                                   href = "css/custom.css"),
                                                                  shiny::tags$head(shiny::tags$script(src = "js/custom.js")))),
                                      body_elements)
    }
}


#' createAlert
#'
#' Created an alert panel in server to be displayed the given ui anchor
#'
#' @param id Anchor id
#' @param selector jQuery selector. Allow more customization for the anchor (nested tags).
#' @param options List of options to pass to the alert
#' @param session Shiny session object.
#'
#' @examples
#'          #createAlert(id       = "sidebarRightAlert",
#'          #            options  = list(title    = "Right Side",
#'          #                            status   = "success",
#'          #                            closable = TRUE,
#'          #                            content  = "Example Basic Sidebar Alert"))
#'
#' @export
createAlert <- function(id       = NULL,
                        selector = NULL,
                        options,
                        session  = shiny::getDefaultReactiveDomain()) {
    if (!is.null(id) && !is.null(selector)) {
        stop("Please choose either target or selector!")
    }

    if (!is.null(id) && !is.null(session)) {
        id = session$ns(id)
    }

    message_params <- list(id       = id,
                           selector = selector,
                           options  = options)

    message_params <- message_params[!vapply(message_params, is.null, FUN.VALUE = logical(1))]

    if (!is.null(session)) {
        session$sendCustomMessage("pcreate-alert", message_params)
    }
}


closeResetAlert <- function(id, session = shiny::getDefaultReactiveDomain()) {
    session$sendCustomMessage("close-alert", id)
}


#' add_ui_right_sidebar
#'
#' Builds application right sidebar with given configurations and elements. It is called within "ui_right_sidebar.R".
#' Check example application for detailed example
#'
#' @param sidebar_elements list of shiny ui elements
#' @param collapsed If TRUE, the sidebar will be collapsed on app startup.
#' @param overlay Whether the sidebar covers the content when expanded. Default to TRUE
#' @param skin Sidebar skin. "dark" or "light".
#' @param pinned Whether to block the controlbar state (TRUE or FALSE). Default to NULL
#' @param controlbar_menu right sidebar elements
#'
#' @export
add_ui_right_sidebar <- function(sidebar_elements = NULL,
                                 collapsed,
                                 overlay,
                                 skin,
                                 pinned,
                                 controlbar_menu) {
    .g_opts$right_sidebar <- bs4Dash::bs4DashControlbar(list(shiny::div(id = "sidebarRightAlert"),
                                                             sidebar_elements,
                                                             controlbar_menu),
                                                        collapsed = collapsed,
                                                        overlay   = overlay,
                                                        skin      = skin,
                                                        pinned    = pinned)
}

#' add_ui_footer
#'
#' Builds application footer with given configurations and elements. It is called within "ui_footer.R".
#' Check example application for detailed example
#'
#' @param left Left text
#' @param right Right text
#' @param fixed Whether to fix the navbar to the top. FALSE by default.
#'
#' @export
add_ui_footer <- function(left, right, fixed) {
    .g_opts$footer <- bs4Dash::bs4DashFooter(left  = list(shiny::div(id = "footerAlert"),
                                                          left),
                                             right = right,
                                             fixed = fixed)
}


#' ui_tooltip
#'
#' This function inserts a standardized tooltip image, label (optional),
#' and hovertext into the application UI
#'
#' @param id character id for the tooltip object
#' @param label text label to appear to the left of the tooltip image
#' @param text tooltip text shown when the user hovers over the image
#' @param placement where to display tooltip label.
#'                   Available places are "top", "bottom", "left", "right" (default is "top")
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
#' @param app_info character string, HTML value or NULL
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
#' @param log_level character string designating the log level to use for
#'                  the userlog (default = 'DEBUG')
#' @param app_version character string designating the application version (default = '1.0.0')
#' @param loading_indicator  uses waiter (see https://waiter.john-coene.com/#/).
#'                           Pass a list like list(html = spin_1(), color = "#333e48") to configure
#'                           waiterShowOnLoad (refer to the package help for all styles).
#' @param announcements_file path to announcements configuration file
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


#' get_app_info
#'
#' Returns current application app info
#'
#' @seealso \link[periscope2]{set_app_parameters}
#'
#' @export
get_app_info <- function() {
    .g_opts$app_info
}


#' get_app_title
#'
#' Returns current application app title
#'
#' @seealso \link[periscope2]{set_app_parameters}
#'
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
