# FRAMEWORK HELPER FUNCTIONS ---------------------------------
# -- (Used in shiny with ::: but not exported as user fxns) --


# Framework Server Setup
fw_server_setup <- function(input, output, session, logger, logger_viewer_id = "logViewer") {
    logfile <- shiny::isolate(.setup_logging(session, logger))
    logViewer(logger_viewer_id, logfile)
}


# Get LogLevel
fw_get_loglevel <- function() {
    shiny::isolate(.g_opts$loglevel)
}

# Get Application Title
fw_get_title <- function() {
    shiny::isolate(.g_opts$app_title)
}

# Get Application Version
fw_get_version <- function() {
    shiny::isolate(.g_opts$app_version)
}

# Get User Action Log
fw_get_user_log <- function() {
    getLogger(name = "actions")
}


#' create_application_dashboard
#'
#' Creates application final dashboard from application different settings and configurations.
#' It is called once in the application in "ui.R". It should not be modified or updated by user
#'
#' @keywords internal
#' @noRd
create_application_dashboard <- function() {
    bs4Dash::bs4DashPage(title      = shiny::isolate(.g_opts$app_title),
                         header     = shiny::isolate(.g_opts$header),
                         body       = bs4Dash::bs4DashBody(shiny::isolate(.g_opts$body_elements)),
                         sidebar    = do.call(bs4Dash::bs4DashSidebar, shiny::isolate(.g_opts$left_sidebar)),
                         controlbar = shiny::isolate(.g_opts$right_sidebar),
                         footer     = shiny::isolate(.g_opts$footer),
                         freshTheme = create_theme(),
                         dark       = NULL,
                         preloader  = shiny::isolate(.g_opts$loading_indicator))
}

create_theme <- function() {
    theme_settings <- NULL

    ## statuses colors
    primary   <- NULL
    secondary <- NULL
    success   <- NULL
    info      <- NULL
    warning   <- NULL
    danger    <- NULL
    light     <- NULL
    dark      <- NULL

    ## layout options
    sidebar_width                   <- NULL
    sidebar_horizontal_padding      <- NULL
    sidebar_vertical_padding        <- NULL
    sidebar_mini_width              <- NULL
    right_sidebar_width             <- NULL
    main_content_horizontal_padding <- NULL
    main_content_vertical_padding   <- NULL
    main_background_color           <- NULL

    ## sidebar colors
    sidebar_background_color        <- NULL
    sidebar_background_hover_color  <- NULL
    sidebar_hover_color             <- NULL
    sidebar_color                   <- NULL
    sidebar_active_color            <- NULL
    submenu_background_color        <- NULL
    submenu_color                   <- NULL
    submenu_hover_color             <- NULL
    submenu_background_hover_color  <- NULL
    submenu_active_color            <- NULL
    submenu_active_background_color <- NULL
    header_color                    <- NULL

    ## button colors
    button_background_color <- NULL
    button_color            <- NULL
    button_border_color     <- NULL

    # keys
    status_keys          <- c("primary", "secondary", "success", "info",
                              "warning", "danger", "light", "dark")
    layout_colors_keys   <- c("main_background_color")
    layout_measures_keys <- c("sidebar_width", "sidebar_horizontal_padding",
                              "sidebar_vertical_padding", "sidebar_mini_width",
                              "right_sidebar_width", "main_content_horizontal_padding",
                              "main_content_vertical_padding")
    sidebar_colors_keys  <- c("sidebar_background_color", "sidebar_background_hover_color",
                             "sidebar_hover_color", "sidebar_color", "sidebar_active_color",
                             "submenu_background_color", "submenu_color", "submenu_hover_color",
                             "submenu_background_hover_color", "submenu_active_color",
                             "submenu_active_background_color", "header_color")
    button_colors_keys   <- c("button_background_color", "button_color", "button_border_color")
    all_colors_keys      <- c(status_keys, layout_colors_keys, sidebar_colors_keys, button_colors_keys)
    theme_settings       <- load_theme_settings()

    if (!is.null(theme_settings) && is.list(theme_settings)) {
        for (color in all_colors_keys) {
            if (!is_valid_color(theme_settings[[color]])) {
                warning(color, " has invalid color value. Setting default color.")
                theme_settings[[color]] <- NULL
            }
        }

        # statuses
        primary   <- theme_settings[["primary"]]
        secondary <- theme_settings[["secondary"]]
        success   <- theme_settings[["success"]]
        info      <- theme_settings[["info"]]
        warning   <- theme_settings[["warning"]]
        danger    <- theme_settings[["danger"]]
        light     <- theme_settings[["light"]]
        dark      <- theme_settings[["dark"]]

        # layout colors
        main_background_color <- theme_settings[["main_background_color"]]

        ## sidebar colors
        sidebar_background_color        <- theme_settings[["sidebar_background_color"]]
        sidebar_background_hover_color  <- theme_settings[["sidebar_background_hover_color"]]
        sidebar_hover_color             <- theme_settings[["sidebar_hover_color"]]
        sidebar_color                   <- theme_settings[["sidebar_color"]]
        sidebar_active_color            <- theme_settings[["sidebar_active_color"]]
        submenu_background_color        <- theme_settings[["submenu_background_color"]]
        submenu_color                   <- theme_settings[["submenu_color"]]
        submenu_hover_color             <- theme_settings[["submenu_hover_color"]]
        submenu_background_hover_color  <- theme_settings[["submenu_background_hover_color"]]
        submenu_active_color            <- theme_settings[["submenu_active_color"]]
        submenu_active_background_color <- theme_settings[["submenu_active_background_color"]]
        header_color                    <- theme_settings[["header_color"]]

        ## button colors
        button_background_color <- theme_settings[["button_background_color"]]
        button_color            <- theme_settings[["button_color"]]
        button_border_color     <- theme_settings[["button_border_color"]]

        for (measure_key in layout_measures_keys) {
            measure <- theme_settings[[measure_key]]

            if (!is.null(measure)) {
                if (any(!is.numeric(measure), measure <= 0)) {
                    warning(measure, " must be positive value. Setting default value.")
                    theme_settings[[measure_key]] <- NULL
                } else {
                    theme_settings[[measure_key]] <- paste0(measure, "px")
                }
            }
        }

        sidebar_width                   <- theme_settings[["sidebar_width"]]
        sidebar_horizontal_padding      <- theme_settings[["sidebar_horizontal_padding"]]
        sidebar_vertical_padding        <- theme_settings[["sidebar_vertical_padding"]]
        sidebar_mini_width              <- theme_settings[["sidebar_mini_width"]]
        right_sidebar_width             <- theme_settings[["right_sidebar_width"]]
        main_content_horizontal_padding <- theme_settings[["main_content_horizontal_padding"]]
        main_content_vertical_padding   <- theme_settings[["main_content_vertical_padding"]]
    }

    fresh::create_theme(
        fresh::bs4dash_status(
            primary   = primary,
            secondary = secondary,
            success   = success,
            info      = info,
            warning   = warning,
            danger    = danger,
            light     = light,
            dark      = dark
        ),
        fresh::bs4dash_layout(
            sidebar_width         = sidebar_width,
            sidebar_padding_x     = sidebar_horizontal_padding,
            sidebar_padding_y     = sidebar_vertical_padding,
            sidebar_mini_width    = sidebar_mini_width,
            control_sidebar_width = right_sidebar_width,
            main_bg               = main_background_color,
            content_padding_x     = main_content_horizontal_padding,
            content_padding_y     = main_content_vertical_padding
        ),
        fresh::bs4dash_sidebar_light(
            bg                   = sidebar_background_color,
            hover_bg             = sidebar_background_hover_color,
            color                = sidebar_color,
            hover_color          = sidebar_hover_color,
            active_color         = sidebar_active_color,
            submenu_bg           = submenu_background_color,
            submenu_color        = submenu_color,
            submenu_hover_color  = submenu_hover_color,
            submenu_hover_bg     = submenu_background_hover_color,
            submenu_active_color = submenu_active_color,
            submenu_active_bg    = submenu_active_background_color,
            header_color         = header_color
        ),
        fresh::bs4dash_button(
            default_background_color = button_background_color,
            default_color            = button_color,
            default_border_color     = button_border_color
        )
    )
}

is_valid_color <- function(color) {
    tryCatch({
        grDevices::col2rgb(color)
        TRUE
    },
    error = function(e) {
        FALSE
    })
}


#' load_announcements
#'
#' Reads and parses application announcements configurations in \code{config/announce.yaml}, then display announcements in
#' application header.
#'
#' If announce.yaml does not exist or contains invalid configurations. Nothing will be displayed.
#' Closing announcements is caller application responsibility
#'
#' @return number of seconds an announcement should be staying in caller application
#'
#' @examples
#'   # announce_close_time <- periscope2:::load_announcements()
#'   # if (!is.null(announce_close_time)) {
#'   #     shinyjs::delay(announce_close_time,{bs4Dash::closeAlert("announceAlert")})
#'   # }
#'
#' @keywords internal
#' @noRd
load_announcements <- function() {
    announce_setup     <- NULL
    auto_close         <- NULL
    announcements_file <- shiny::isolate(.g_opts$announcements_file)

    if ((!is.null(announcements_file)) &&
        (file.exists(announcements_file))) {
        tryCatch({
            announce_setup <- yaml::read_yaml(announcements_file)
            if (any(is.null(announce_setup),
                    !is.list(announce_setup),
                    length(announce_setup) < 1)) {
                logwarn(paste("File",
                              announcements_file,
                              "is empty or corrupted. Announcements will be ignored"))
                announce_setup <- NULL
            }
        },
        error = function(e) {
            logwarn(paste("Could not parse", announcements_file, "due to", e$message))
        })

        if (!is.null(announce_setup)) {
            start_date        <- announce_setup[["start_date"]]
            start_date_format <- announce_setup[["start_date_format"]]
            end_date          <- announce_setup[["end_date"]]
            end_date_format   <- announce_setup[["end_date_format"]]
            style             <- announce_setup[["style"]]
            title             <- announce_setup[["title"]]
            text              <- announce_setup[["text"]]
            auto_close        <- announce_setup[["auto_close"]]
            valid             <- TRUE

            if (!is.null(start_date)) {
                if (!is_valid_format(start_date, start_date_format)) {
                    if (is.null(start_date_format)) {
                        start_date_format <- ""
                    }
                    logwarn(paste("Announcement 'start_date' value '",
                                  start_date,
                                  "' could not be converted to a valid date",
                                  " with the given 'start_date_format' value: '",
                                  start_date_format, "' "))
                    valid <- FALSE
                } else {
                    start_date <- lubridate::as_date(start_date, format = start_date_format)
                }
            }

            if (valid && !is.null(end_date)) {
                if (!is_valid_format(end_date, end_date_format)) {
                    if (is.null(end_date_format)) {
                        end_date_format <- ""
                    }
                    logwarn(paste("Announcement 'end_date' value '",
                                  end_date,"' could not be converted to a valid date",
                                  " with the given 'end_date_format' value: '", end_date_format, "' "))
                    valid <- FALSE
                } else {
                    end_date <- lubridate::as_date(end_date, format = end_date_format)
                }
            }

            if (valid && !(any(is.null(start_date), start_date <= Sys.Date()) &&
                           any(is.null(end_date), Sys.Date() <= end_date))) {
                valid <- FALSE
            }

            valid_styles <- c("info", "danger", "success", "warning", "primary")
            style        <- tolower(style)

            if (valid && any(length(style) == 0,
                             style == "",
                             !(tolower(style) %in% valid_styles))) {
                logwarn(paste("Announcement 'style' must be one of ",
                              paste(valid_styles, collapse = ", ")))
                valid <- FALSE
            }

            if (valid && any(is.null(text), text == "")) {
                logwarn("Announcement 'text' value is empty. It must contain non empty text value")
                valid <- FALSE
            }

            if (valid) {
                createAlert(id      = "announceAlert",
                            options = list(title    = title,
                                           status   = style,
                                           closable = TRUE,
                                           content  = text))
                if (is.null(auto_close) ||
                    !is.numeric(auto_close) ||
                    auto_close == 0) {
                    logwarn(paste("Announcement 'auto_close' value '",
                                  auto_close,
                                  "' is invalid. It must contain numeric value.",
                                  "Setting 'auto_close' to default value 'NULL'"))
                    auto_close <- NULL
                } else {
                    auto_close <- auto_close * 1000
                }
            }
        }
    }
    auto_close
}

is_valid_format <- function(x, format = NULL) {
    valid_format <- FALSE

    tryCatch({
        date <- lubridate::as_date(x, format = format)
        if (!is.na(date)) {
            valid_format <- TRUE
        }
    },
    warning = function(w) {
        logerror(paste("Could not convert date: '",
                       x,
                       "' with format: '",
                       format,
                       "' with error: '", w$message,
                       "'"))
    })

    valid_format
}

load_theme_settings <- function() {
    theme_settings <- NULL

    if (file.exists("www/periscope_style.yaml")) {
        tryCatch({
            theme_settings <- yaml::read_yaml("www/periscope_style.yaml")
        },
        error = function(e){
            warning("Could not parse 'periscope_style.yaml' due to: ", e$message)
        })
    }

    theme_settings
}
