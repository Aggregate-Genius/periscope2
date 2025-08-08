#' Add UI elements to dashboard left sidebar section
#'
#' This function adds left sidebar configurations and UI elements. It is called within "ui_left_sidebar.R".
#' Check example application for detailed example
#'
#' @param sidebar_elements List of regular shiny UI elements (inputText, textArea, etc..)
#' @param sidebar_menu     \code{?bs4Dash::bs4SidebarMenu()} object to created a menu inside left sidebar
#' @param collapsed        If TRUE, the sidebar will be collapsed on app start up
#' @param custom_area      List of regular shiny UI elements but for sidebar bottom space area only.
#'                         Only works if sidebar is fixed
#' @param elevation        A number between 0 and 5, which applies a shadow to the sidebar to add a shadow effect.
#' @param expand_on_hover  When \code{minified} is TRUE, if this property is TRUE, the sidebar opens when hovering but re-collapses as soon as the focus is lost (default = TRUE)
#' @param fixed            Whether to see all menus at once without scrolling up and down.(default = TRUE)
#' @param minified         Whether to slightly close the sidebar but still show item icons (default = FALSE)
#' @param skin             Sidebar skin. "dark" or "light" (default = "light")
#' @param status           Determines which color menu items (if exist) will have Check \code{?bs4Dash::dashboardSidebar()} for list of valid values
#'
#' @return list of both shiny UI elements and named left sidebar properties
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_left_sidebar.R} to set left sidebar parameters
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'   # Inside ui_left_sidebar.R
#'   # sidebar menu items
#'   sidebar_elements <- textInput("text_id", "Test", "Test Data")
#'   sidebar_menu     <- sidebarMenu(sidebarHeader("Main Menu"),
#'                                   menuItem("menu item 1",
#'                                            tabName = "item_1 page"),
#'                                   menuItem("menu item 2",
#'                                            tabName = "item_2 page"))
#'   add_ui_left_sidebar(sidebar_elements = sidebar_elements,
#'                       sidebar_menu     = sidebar_menu)
#' @seealso \link[bs4Dash:bs4DashSidebar]{bs4Dash:bs4DashSidebar()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
add_ui_left_sidebar <- function(sidebar_elements = NULL,
                                sidebar_menu     = NULL,
                                collapsed        = FALSE,
                                custom_area      = NULL,
                                elevation        = 4,
                                expand_on_hover  = TRUE,
                                fixed            = TRUE,
                                minified         = FALSE,
                                status           = "primary",
                                skin             = "light") {
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


#' Add UI elements to dashboard header section
#'
#' Builds application header with given configurations and elements. It is called within "ui_header.R".
#' These elements will be displayed in the header beside application title and application busy indicator.
#'
#' \subsection{Application header consists of three elements:}{
#'    \describe{
#'      \item{busy indicator}{An automatic wait indicator that are shown when the shiny server session is busy}
#'      \item{application title}{Display application title}
#'      \item{heade menu}{Optional header menu to switch between application different tabs}
#'    }
#' }
#'
#' Header elements can be arranged via \code{ui_position} and \code{title_position} parameters.
#' \cr
#' Header elements look and feel can also be configured in \bold{"www\\css\\custom.css"} file under
#' \bold{"Application Header"} section.
#' \cr
#' Check example application for detailed example
#'
#' @param ui_elements        It can be any UI element but mostly used for navbarMenu. NULL by default.
#'                           Check \code{?bs4Dash::navbarMenu()}
#' @param ui_position        Location of UI elements in the header. Must be either of 'center', 'left' or 'right'
#'                           Default value is 'right'.
#' @param title              Sets application title. If it is not NULL, it will override "title" value that is set in
#'                           \code{?periscope2::set_app_parameters()} (default = NULL)
#' @param title_position     Location of the title in the header. Must be either of 'center', 'left' or 'right'
#'                           Default value is 'Center'. If there are no UI elements, this param will be ignored.
#' @param left_menu          Left menu. bs4DropdownMenu object (or similar dropdown menu).
#'                           Check \code{?bs4Dash::bs4DropdownMenu()}
#' @param right_menu         Right menu. bs4DropdownMenu object (or similar dropdown menu).
#'                           Check \code{?bs4Dash::bs4DropdownMenu()}
#' @param border             Whether to separate the navbar and body by a border. TRUE by default
#' @param compact            Whether items should be compacted. FALSE by default
#' @param fixed              Whether to fix the navbar to the top. FALSE by default
#' @param left_sidebar_icon  Left sidebar toggle icon
#' @param right_sidebar_icon Right sidebar toggle icon
#' @param skin               Sidebar skin. "dark" or "light"
#' @param status             Sidebar status. Check \code{?bs4Dash::bs4DashNavbar()} for list of valid values
#'
#' @return list of both shiny UI elements and named header properties
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_header.R} to set header parameters
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'
#'   # Inside ui_header.R
#'   # Custom left UI menu
#'   left_menu <- tagList(dropdownMenu(badgeStatus = "info",
#'                                   type        = "notifications",
#'                                    notificationItem(inputId = "triggerAction2",
#'                                                     text    = "Error!",
#'                                                     status  = "danger")),
#'                       dropdownMenu(badgeStatus = "info",
#'                                    type        = "tasks",
#'                                    taskItem(inputId = "triggerAction3",
#'                                             text    = "My progress",
#'                                             color   = "orange",
#'                                             value   = 10)))
#'
#'   # Custom right UI menu
#'   right_menu <- dropdownMenu(badgeStatus = "danger",
#'                           type        = "messages",
#'                           messageItem(inputId = "triggerAction1",
#'                                       message = "message 1",
#'                                       from    = "Divad Nojnarg",
#'                                       time    = "today",
#'                                       color   = "lime"))
#'   # -- Register Header Elements in the ORDER SHOWN in the UI
#'   add_ui_header(left_menu = left_menu, right_menu = right_menu)
#'
#' @seealso \link[bs4Dash:bs4DashNavbar]{bs4Dash:bs4DashNavbar()}
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
add_ui_header <- function(ui_elements        = NULL,
                          ui_position        = "right",
                          title              = NULL,
                          title_position     = "center",
                          left_menu          = NULL,
                          right_menu         = NULL,
                          border             = TRUE,
                          compact            = FALSE,
                          right_sidebar_icon = shiny::icon("bars"),
                          fixed              = FALSE,
                          left_sidebar_icon  = shiny::icon("th"),
                          skin               = "light",
                          status             = "white") {
    if (!is.null(title)) {
        .g_opts$app_title <- title
    }

    app_title <- shiny::isolate(.g_opts$app_title)
    title     <- shiny::div(id = "app_header", app_title)
    app_info  <- shiny::isolate(.g_opts$app_info)

    if (!is.null(app_info)) {
        if (class(app_info)[1] == "html") {
            title <- shiny::div(id = "app_header",
                                shiny::actionLink("app_info", app_title))
        } else {
            title <- shiny::div(id = "app_header",
                                shiny::a(id = "app_info", href = app_info, target = "_blank", app_title))
        }

    }

    busy_indicator <- shiny::div(class = "periscope-busy-ind",
                                 "Working",
                                 shiny::img(alt = "Working...",
                                            hspace = "5px",
                                            src = "img/loader.gif"))
    if (length(ui_elements) > 0) {
        ui_elements <- shiny::div(id = "header_menu", ui_elements)
    }

    header_left   <- busy_indicator
    header_center <- title
    header_right  <- ui_elements

    if (!is.null(ui_elements)) {
        if (!is.null(title_position)) {
            title_position <- tolower(title_position)
        }

        if (!is.null(ui_position)) {
            ui_position <- tolower(ui_position)
        }

        if ((is.null(title_position)) ||
            !(title_position %in% c("left", "center", "right"))) {
            warning("title_position must be on of 'left', 'center'or 'right' values. Setting default value 'center'")
            title_position <- "center"
        }

        if ((is.null(ui_position)) ||
            !(ui_position %in% c("left", "center", "right"))) {
            warning("ui_position must be on of 'left', 'center'or 'right' values. Setting default value 'right'")
            ui_position <- "right"
        }

        if (title_position == ui_position) {
            warning("title_position cannot be equal to ui_position. Setting default values")
            title_position <- "center"
            ui_position    <- "right"
        }

        if (title_position == "center") {
            if (ui_position == "left") {
                header_right <- busy_indicator
                header_left  <- ui_elements
            }
        } else if (title_position == "left") {
            header_left <- title

            if (ui_position == "right") {
                header_right  <- ui_elements
                header_center <- busy_indicator
            } else{
                header_right  <- busy_indicator
                header_center <- ui_elements
            }
        } else if (title_position == "right") {
            header_right <- title

            if (ui_position == "left") {
                header_left   <- ui_elements
                header_center <- busy_indicator
            } else{
                header_left   <- busy_indicator
                header_center <- ui_elements
            }
        }


    }

    header <- shiny::div(class = "app_header_container",
                         header_left,
                         header_center,
                         header_right)

    .g_opts$header <- bs4Dash::bs4DashNavbar(header,
                                             skin           = skin,
                                             status         = status,
                                             border         = border,
                                             compact        = compact,
                                             sidebarIcon    = left_sidebar_icon,
                                             controlbarIcon = right_sidebar_icon,
                                             fixed          = fixed,
                                             leftUi         = left_menu,
                                             rightUi        = right_menu)
}


#' Add UI elements to dashboard body section
#'
#' Builds application body with given configurations and elements. It is called within "ui_body.R".
#' Check example application for detailed example
#'
#' @param body_elements List of UI elements to be displayed in application body
#' @param append        Add elements to current body elements or remove previous body elements (default = FALSE)
#'
#' @return list of both shiny UI elements and html div tags for alert and linking app JS and CSS files
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_body.R} to set body parameters
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'   # Inside ui_body.R
#'   about_box <- jumbotron(title  = "periscope2: Test Example",
#'                          lead   = p("periscope2 is a scalable and UI-standardized 'shiny' framework
#'                          	       including a variety of developer convenience functions"),
#'                          status = "info",
#'                          href   = "https://periscopeapps.org/")
#'   # -- Register Elements in the ORDER SHOWN in the UI
#'   add_ui_body(list(about_box))
#'
#' @seealso \link[bs4Dash:bs4DashBody]{bs4Dash:bs4DashBody()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
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


#' Display alert panel at specified location
#'
#' Create an alert panel in server code to be displayed in the specified UI selector location
#'
#' @param session  Shiny session object
#' @param id       Anchor id (either id or selector only should be set)
#' @param selector Character vector represents jQuery selector to add the alert to is
#'                 (i.e ".alertClass", div.badge-danger.navbar-badge). If 'id' is specified, this parameter will be neglected
#' @param options  List of options to pass to the alert
#'
#' @return html div and inserts it in the app DOM
#'
#' @section Shiny Usage:
#' Call this function from \code{program/server_local.R} or any other server file to setup the needed alert
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'
#'   # Inside server_local.R
#'   createPSAlert(id       = "sidebarRightAlert",
#'                 options  = list(title    = "Right Side",
#'                                 status   = "success",
#'                                 closable = TRUE,
#'                                 content  = "Example Basic Sidebar Alert"))
#'   # Test se
#'   ## a div with class "badge-danger.navbar-badge" must be exist in UI to display alert
#'   selector <- "div.badge-danger.navbar-badge"
#'   createPSAlert(selector = selector,
#'                 options  = list(title    = "Selector Title",
#'                                 status   = "danger",
#'                                 closable = TRUE,
#'                                 content  = "Selector Alert"))
#'
#'
#' @seealso \link[bs4Dash:closeAlert]{bs4Dash:closeAlert()}
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
createPSAlert <- function(session  = shiny::getDefaultReactiveDomain(),
                          id       = NULL,
                          selector = NULL,
                          options) {
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


#' Add UI elements to dashboard right sidebar section
#'
#' Builds application right sidebar with given configurations and elements. It is called within "ui_right_sidebar.R".
#' Check example application for detailed example
#'
#' @param sidebar_elements List of regular shiny UI elements (inputText, textArea, etc..)
#' @param sidebar_menu     \code{?bs4Dash::controlbarMenu()} object to created a menu inside right sidebar
#' @param collapsed        If TRUE, the sidebar will be collapsed on app startup (default = TRUE)
#' @param overlay          Whether the sidebar covers the content when expanded (default = TRUE)
#' @param pinned           If TRUE, allows right sidebar to remain open even after a click outside (default = FALSE)
#' @param skin             Sidebar skin. "dark" or "light" (default = "light")
#'
#' @return list of both shiny UI elements and named right sidebar properties
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_right_sidebar.R} to set right sidebar parameters
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'
#'   # Inside ui_right_sidebar.R
#'   sidebar_elements <- list(div(checkboxInput("checkMe", "Example Check")))
#'   sidebar_menu     <- controlbarMenu(id = "controlbarmenu",
#'                                      controlbarItem("Item 2", "Simple text"))
#'  # -- Register Right Sidebar Elements in the ORDER SHOWN in the UI
#'   add_ui_right_sidebar(sidebar_elements = sidebar_elements,
#'                        sidebar_menu     = sidebar_menu)
#'
#' @seealso \link[bs4Dash:bs4DashControlbar]{bs4Dash:bs4DashControlbar()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
add_ui_right_sidebar <- function(sidebar_elements = NULL,
                                 sidebar_menu     = NULL,
                                 collapsed        = TRUE,
                                 overlay          = TRUE,
                                 pinned           = FALSE,
                                 skin             = "light") {
    .g_opts$right_sidebar <- bs4Dash::bs4DashControlbar(list(shiny::div(id = "sidebarRightAlert"),
                                                             sidebar_elements,
                                                             sidebar_menu),
                                                        collapsed = collapsed,
                                                        overlay   = overlay,
                                                        skin      = skin,
                                                        pinned    = pinned)
}


#' Add UI elements to dashboard footer section
#'
#' Builds application footer with given configurations and elements. It is called within "ui_footer.R".
#' Check example application for detailed example
#'
#' @param left  Left side UI elements
#' @param right Right side UI elements
#' @param fixed Always show footer at page bottom regardless page scroll location (default = FALSE).
#'
#' @return list of both shiny UI elements and named footer properties
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_footer.R} to set footer parameters
#'
#' @examples
#'   library(shiny)
#'   library(bs4Dash)
#'
#'   # Inside ui_footer.R
#'   # Left text
#'   left <- a(href   = "https://periscopeapps.org/",
#'             target = "_blank",
#'             "periscope2")
#'   # Right text
#'   right <- "2022"
#'
#'   # -- Register Elements in the ORDER SHOWN in the UI
#'   add_ui_footer(left, right)
#'
#' @seealso \link[bs4Dash:bs4DashFooter]{bs4Dash:bs4DashFooter()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
add_ui_footer <- function(left  = NULL,
                          right = NULL,
                          fixed = FALSE) {
    .g_opts$footer <- bs4Dash::bs4DashFooter(left  = list(shiny::div(id = "footerAlert"),
                                                          left),
                                             right = right,
                                             fixed = fixed)
}


#' Add tooltip icon and text to UI elements labels
#'
#' This function inserts a standardized tooltip image, label (optional),
#' and hovertext into the application UI
#'
#' @param id        The id for the tooltip object
#' @param label     Text label to appear to the left of the tooltip image
#' @param text      Tooltip text shown when the user hovers over the image
#' @param placement Where to display tooltip label. Available places are "top", "bottom", "left", "right" (default is "top")
#'
#' @return html span with the label, tooltip image and tooltip text
#'
#' @section Shiny Usage:
#' Call this function from \code{program/ui_body.R} to set tooltip parameters
#'
#' @examples
#'   library(shiny)
#'   library(periscope2)
#'
#'   # Inside ui_body.R or similar UI file
#'    ui_tooltip(id   = "top_tip",
#'              label = "Top Tooltips",
#'              text  = "Top tooltip")
#'
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
ui_tooltip <- function(id,
                       label     = "",
                       text      = "",
                       placement = "top") {
    if (is.null(text) || is.na(text) || (text == "")) {
        warning("ui_tooltip() called without tooltip text.")
    }

   shiny::span(class = "periscope-input-label-with-tt",
               label,
               tooltip(shiny::img(id     = id,
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
#' @param title              `r lifecycle::badge("deprecated")` Use \link[periscope2]{add_ui_header} to configure application title text
#' @param app_info           Application detailed information. It can be character string, HTML value or NULL
#'                             \itemize{
#'                                      \item{A \strong{character} string will be used to set a link target.
#'                                            This means the user will be able to click on the application title and be
#'                                            redirected in a new window to whatever value is given in the string.
#'                                            Any valid URL, File, or other script functionality that would normally be
#'                                            accepted in an \code{<a href=...></a>}  tag is allowed.}
#'                                      \item{An \strong{HTML} value will be used to as the HTML content for a modal pop-up
#'                                            window that will appear on-top of the application when the user clicks on the
#'                                            application title.}
#'                                      \item{Supplying \strong{NULL} will disable the title link functionality.}
#'                             }
#' @param log_level          Designating the log level to use for the user log as 'DEBUG','INFO', 'WARN' or 'ERROR' (default = 'DEBUG')
#' @param app_version        Character string designating the application version (default = '1.0.0')
#' @param loading_indicator  It uses waiter (see https://waiter.john-coene.com/#/).\cr
#'                             Pass a list like list(html = spin_1(), color = "#333e48") to \cr configure
#'                             waiterShowOnLoad (refer to the package help for all styles).
#' @param announcements_file `r lifecycle::badge("deprecated")`. Use \link[periscope2]{load_announcements} to configure announcement.
#'
#' @return no return value, called for setting new application global properties
#'
#' @section Shiny Usage:
#' Call this function from \code{program/global.R} to set the application
#' parameters.
#'
#' @examples
#'   library(shiny)
#'   library(waiter)
#'   library(periscope2)
#'
#'   # Inside program/global.R
#'   set_app_parameters(app_info          = HTML("Example info"),
#'                      log_level         = "DEBUG",
#'                      app_version       = "1.0.0",
#'                      loading_indicator = list(html = tagList(spin_1(), "Loading ...")))
#'
#'
#' @seealso \link[periscope2:announcementConfigurationsAddin]{periscope2:announcementConfigurationsAddin()}
#' @seealso \link[periscope2:load_announcements]{periscope2:load_announcements()}
#' @seealso \link[waiter:waiter]{waiter:waiter_show()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
#' @seealso \link[periscope2:get_url_parameters]{periscope2:get_url_parameters()}
#'
#' @export
set_app_parameters <- function(title              = NULL,
                               app_info           = NULL,
                               log_level          = "DEBUG",
                               app_version        = "1.0.0",
                               loading_indicator  = NULL,
                               announcements_file = NULL) {
    if (!is.null(announcements_file)) {
        lifecycle::deprecate_warn(
            when    = "0.2.3",
            what    = "set_app_parameters(announcements_file)",
            details = "Please use `periscope2::load_announcements` instead"
        )
    }

    if (!is.null(title)) {
        lifecycle::deprecate_warn(
            when    = "0.2.3",
            what    = "set_app_parameters(title)",
            details = "Please use `periscope2::add_ui_header(title)` instead"
        )
    }

    .g_opts$app_title          <- title
    .g_opts$app_info           <- app_info
    .g_opts$loglevel           <- log_level
    .g_opts$app_version        <- app_version
    .g_opts$loading_indicator  <- loading_indicator
    .g_opts$announcements_file <- announcements_file
}


#' Parse application passed URL parameters
#'
#' This function returns any url parameters passed to the application as
#' a named list.  Keep in mind url parameters are always user-session scoped
#'
#' @param session shiny session object
#'
#' @return named list of url parameters and values.  List may be empty if
#' no URL parameters were passed when the application instance was launched
#'
#' @section Shiny Usage:
#' Call this function from \code{program/server_local.R} or any other server file
#'
#' @examples
#'   library(shiny)
#'   library(periscope2)
#'
#'   # Display application info
#'   observeEvent(input$app_info, {
#'                url_params <- get_url_parameters(session)
#'                show_alert(html                = TRUE,
#'                           showCloseButton     = FALSE,
#'                           animation           = "slide-from-top",
#'                           closeOnClickOutside = TRUE,
#'                           text                = url_params[["passed_paramter"]],
#'                           title               = "alert title")
#'   })
#'
#'
#' @seealso \link[periscope2:set_app_parameters]{periscope2:set_app_parameters()}
#' @seealso \link[periscope2:add_ui_footer]{periscope2:add_ui_footer()}
#' @seealso \link[periscope2:add_ui_left_sidebar]{periscope2:add_ui_left_sidebar()}
#' @seealso \link[periscope2:add_ui_header]{periscope2:add_ui_header()}
#' @seealso \link[periscope2:add_ui_body]{periscope2:add_ui_body()}
#' @seealso \link[periscope2:add_ui_right_sidebar]{periscope2:add_ui_right_sidebar()}
#' @seealso \link[periscope2:ui_tooltip]{periscope2:ui_tooltip()}
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


# Override bs4Dash tooltip function to allow html handling in tooltips
tooltip <- function(tag, title, placement = c("top", "bottom", "left", "right")) {
    placement <- match.arg(placement)

    tag <- shiny::tagAppendAttributes(
        tag,
        `data-toggle`    = "tooltip",
        `data-placement` = placement,
        title            = title,
        `data-html`      = "true"
    )

    tagId <- tag$attribs$id

    shiny::tagList(
        shiny::singleton(
            shiny::tags$head(
                shiny::tags$script(
                    sprintf(
                        "$(function () {
              // enable tooltip
              $('#%s').tooltip();
            });
            ",
                        tagId
                    )
                )
            )
        ),
        tag
    )
}

