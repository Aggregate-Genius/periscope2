# FRAMEWORK HELPER FUNCTIONS ---------------------------------
# -- (Used in shiny with ::: but not exported as user fxns) --


# Framework Server Setup
fw_server_setup <- function(input, output, session, logger, logger_viewer_id = "logViewer") {
    logfile <- shiny::isolate(.setup_logging(session, logger))
    logViewer(logger_viewer_id, logfile)
}


# Get Logging Level
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
    list(
        shiny::fluidRow(shiny::column(width = 12, shiny::div(id = "announceAlert"))),
        shiny::fluidRow(shiny::column(width = 12, shiny::div(id = "headerAlert"))),
        shiny::fluidRow(shiny::column(width = 12,
                        bs4Dash::bs4DashPage(title      = shiny::isolate(.g_opts$app_title),
                                             header     = shiny::isolate(.g_opts$header),
                                             body       = bs4Dash::bs4DashBody(shiny::isolate(.g_opts$body_elements)),
                                             sidebar    = do.call(bs4Dash::bs4DashSidebar, shiny::isolate(.g_opts$left_sidebar)),
                                             controlbar = shiny::isolate(.g_opts$right_sidebar),
                                             footer     = shiny::isolate(.g_opts$footer),
                                             freshTheme = create_theme(),
                                             dark       = NULL,
                                             help       = NULL,
                                             preloader  = shiny::isolate(.g_opts$loading_indicator)))))
}

create_theme <- function() {
    bs4dash_vars_keys <- fresh::search_vars_bs4dash()[["variable"]]
    theme_settings    <- load_theme_settings()
    status            <- list()
    sidebar_colors    <- list()
    sidebar_layout    <- list()
    main_colors       <- list()
    colors_contrast   <- list()
    other_variables   <- list()

    # keys
    status_keys         <- c("primary", "secondary", "success", "info",
                              "warning", "danger", "light", "dark")
    sidebar_colors_keys <- c("bg", "hover_bg", "color", "hover_color", "active_color",
                              "submenu_bg", "submenu_color", "submenu_hover_color", "submenu_hover_bg",
                              "submenu_active_color", "submenu_active_bg", "header_color")
    sidebar_layout_keys <- c("sidebar_width", "control_sidebar_width", "sidebar_padding_x", "sidebar_padding_y",
                              "sidebar_mini_width")
    main_colors_keys    <- c("blue", "lightblue", "navy", "cyan", "teal", "olive", "green", "lime", "orange", "yellow",
                              "fuchsia", "purple", "maroon", "red", "black", "gray_x_light", "gray_600", "gray_800",
                              "gray_900", "white")
    contrast_keys       <- c("contrasted_threshold", "text_dark", "text_light")

    if (!is.null(theme_settings) && is.list(theme_settings)) {
        # colors check
        for (color_key in c(status_keys,
                            sidebar_colors_keys,
                            main_colors_keys,
                            c("text_dark", "text_light"))) {
            if ((color_key %in% names(theme_settings)) &&
                !is_valid_color(theme_settings[[color_key]])) {
                warning(color_key, " has invalid color value. Setting default color.")
                theme_settings[color_key] <- NULL
            }
        }

        # measures check
        for (measure_key in c(sidebar_layout_keys, "contrasted_threshold")) {
            measure <- theme_settings[[measure_key]]

            if (!is.null(measure)) {
                if (is.na(as.numeric(measure)) || measure <= 0) {
                    warning(measure, " must be positive value. Setting default value.")
                    theme_settings[[measure_key]] <- NULL
                } else {
                    theme_settings[[measure_key]] <- paste0(measure, "px")
                }
            }
        }

        status          <- theme_settings[status_keys[status_keys %in% names(theme_settings)]]
        sidebar_colors  <- theme_settings[sidebar_colors_keys[sidebar_colors_keys %in% names(theme_settings)]]
        sidebar_layout  <- theme_settings[sidebar_layout_keys[sidebar_layout_keys %in% names(theme_settings)]]
        main_colors     <- theme_settings[main_colors_keys[main_colors_keys %in% names(theme_settings)]]
        colors_contrast <- theme_settings[contrast_keys[contrast_keys %in% names(theme_settings)]]
        other_variables <- theme_settings[bs4dash_vars_keys[bs4dash_vars_keys %in% names(theme_settings)]]

    }

    fresh::create_theme(
        do.call(fresh::bs4dash_status, status),
        do.call(fresh::bs4dash_sidebar_light, sidebar_colors),
        do.call(fresh::bs4dash_layout, sidebar_layout),
        do.call(fresh::bs4dash_color, main_colors),
        do.call(fresh::bs4dash_yiq, colors_contrast),
        do.call(fresh::bs4dash_vars, other_variables)
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
