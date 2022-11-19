#' Add UI Elements to the Sidebar (Basic Tab)
#'
#' This function registers UI elements to the primary (front-most) tab
#' on the dashboard sidebar.  The default name of the tab is \strong{Basic} but
#' can be renamed using the tabname argument.  This tab will be active on the
#' sidebar when the user first opens the shiny application.
#'
#' @param elementlist list of UI elements to add to the sidebar tab
#' @param append whether to append the \code{elementlist} to currently
#' registered elements or replace the currently registered elements.
#' @param tabname change the label on the UI tab (default = "Basic")
#'
#' @section Shiny Usage:
#' Call this function after creating elements in \code{ui_sidebar.R} to register
#' them to the application framework and show them on the Basic tab in the
#' dashboard sidebar
#'
#' @seealso \link[periscope]{add_ui_sidebar_advanced}
#' @seealso \link[periscope]{add_ui_body}
#'
#' @examples 
#' require(shiny)
#' 
#' s1 <- selectInput("sample1", "A Select", c("A", "B", "C"))
#' s2 <- radioButtons("sample2", NULL, c("A", "B", "C"))
#' 
#' add_ui_sidebar_basic(list(s1, s2), append = FALSE)
#' 
#' @export
add_ui_sidebar_basic <- function(elementlist = NULL,
                                 append = FALSE,
                                 tabname = "Basic") {
    if (append) {
        .g_opts$side_basic <- append(
            shiny::isolate(.g_opts$side_basic),
            elementlist)
    } else {
        .g_opts$side_basic <- list(div(id = "sidebarBasicAlert"),
                                   elementlist)
    }
    .g_opts$side_basic_label <- tabname
    invisible(NULL)
}


#' Add UI Elements to the Sidebar (Advanced Tab)
#'
#' This function registers UI elements to the secondary (rear-most) tab
#' on the dashboard sidebar.  The default name of the tab is \strong{Advanced}
#' but can be renamed using the tabname argument.
#'
#' @param elementlist list of UI elements to add to the sidebar tab
#' @param append whether to append the \code{elementlist} to the currently
#' registered elements or replace the currently registered elements completely
#' @param tabname change the label on the UI tab (default = "Advanced")
#'
#' @section Shiny Usage:
#' Call this function after creating elements in \code{program/ui_sidebar.R} to register
#' them to the application framework and show them on the Advanced tab in the
#' dashboard sidebar
#'
#' @seealso \link[periscope]{add_ui_sidebar_basic}
#' @seealso \link[periscope]{add_ui_body}
#'
#' @examples 
#' require(shiny)
#' 
#' s1 <- selectInput("sample1", "A Select", c("A", "B", "C"))
#' s2 <- radioButtons("sample2", NULL, c("A", "B", "C"))
#' 
#' add_ui_sidebar_advanced(list(s1, s2), append = FALSE)
#' 
#' @export
add_ui_sidebar_advanced <- function(elementlist = NULL,
                                    append = FALSE,
                                    tabname = "Advanced") {
    .g_opts$side_advanced_label <- tabname
    if (append) {
        .g_opts$side_advanced <- append(
            shiny::isolate(.g_opts$side_advanced),
            elementlist,
            length(shiny::isolate(.g_opts$side_advanced)) - 1)
    } else {
        .g_opts$side_advanced <- list(
            div(id = "sidebarAdvancedAlert"),
            elementlist)
    }
}

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
    .g_opts$left_sidebar <-list(list(div(id = "sidebarBasicAlert"),
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

closeResetAlert <- function (id, session = shiny::getDefaultReactiveDomain()) {
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

#' Add UI Elements to the Right Sidebar
#'
#' This function registers UI elements at the right dashboard sidebar. 
#' The UI elements to be added depend on the version of shinydashboardPlus in use.
#'
#' @param elementlist list of UI elements to add to the sidebar tab
#' @param append whether to append the \code{elementlist} to the currently
#' registered elements or replace the currently registered elements completely
#'
#' @section Shiny Usage:
#' Call this function after creating elements in \code{program/ui_sidebar_right.R} to register
#' them to the application framework and show them on the right dashboard sidebar
#'
#' @seealso \link[periscope]{add_ui_sidebar_basic}
#' @seealso \link[periscope]{add_ui_body}
#' @seealso \link[shinydashboardPlus]{shinydashboardPlusGallery}

#' @examples 
#' \dontrun{
#' require(shiny)
#' require(shinydashboardPlus)
#' 
#' # shinydashboardPlus changed significantly in version 2.0 and has 
#' # different syntax for the element content, here is an example for each
#' 
#' # shinydashboardPlus < 2.0
#' s1 <- rightSidebarTabContent(id = 1, icon = "desktop", title = "Tab 1 - Plots", active = TRUE, 
#'                              div(helpText(align = "center", "Sample UI Text"),
#'                                  selectInput("sample1", "A Select", c("A", "B", "C")) ))
#' 
#' # shinydasboardPlus >= 2.0
#' s1 <- controlbarMenu(id = 1, selected = "Tab 1 - Plots",
#'                      controlbarItem(icon = icon("desktop"), title = "Tab 1 - Plots",
#'                                     div(helpText(align = "center", "Sample UI Text"),
#'                                     selectInput("sample1", "A Select", c("A", "B", "C")) )))
#'                                     
#' # add the above content to the sidebar (periscope functionality)
#' add_ui_sidebar_right(list(s1), append = FALSE)
#' }
#' 
#' @export
add_ui_sidebar_right <- function(elementlist = NULL, append = FALSE) {
    if (append) {
        .g_opts$side_right <- append(
            shiny::isolate(.g_opts$side_right),
            elementlist)
    } else {
        .g_opts$side_right <- elementlist
    }
    invisible(NULL)
}


#' Add UI Elements to the Body area
#'
#' This function registers UI elements to the body of the application (the
#' right side).  Items are added in the order given.
#'
#' @param elementlist list of UI elements to add to the body
#' @param append whether to append the \code{elementlist} to the currently
#' registered elements or replace the currently registered elements completely
#'
#' @section Shiny Usage:
#' Call this function after creating elements in \code{program/ui_body.R} to
#' register them to the application framework and show them on the body area
#' of the dashboard application
#'
#' @seealso \link[periscope]{add_ui_sidebar_basic}
#' @seealso \link[periscope]{add_ui_sidebar_advanced}
#'
#' @examples 
#' require(shiny)
#' 
#' body1 <- htmlOutput("example1")
#' body2 <- actionButton("exButton", label = "Example")
#' 
#' add_ui_body(list(body1, body2))
#' 
#' 
# add_ui_body <- function(elementlist = NULL, append = FALSE) {
#     if (append) {
#         .g_opts$body_elements <- append(
#             shiny::isolate(.g_opts$body_elements),
#             elementlist,
#             shiny::isolate(length(.g_opts$body_elements)) - 1)
#     } else {
#         .g_opts$body_elements <- list(div(id = "bodyAlert"),
#                                       elementlist)
#     }
#     invisible(NULL)
# }


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
#' @param showlog enable or disable the visible userlog at the bottom of the
#' body on the application.  Logging will still take place, this disables the
#' visible functionality only.
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
                               show_log           = TRUE,
                               app_version        = "1.0.0",
                               loading_indicator  = NULL,
                               announcements_file = NULL) {
    .g_opts$app_title          <- title
    .g_opts$app_info           <- app_info
    .g_opts$loglevel           <- log_level
    .g_opts$show_userlog       <- show_log
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

    return(parameters)
}
