context("periscope2 - UI functionality")
local_edition(3)

# helper functions
create_announcements <- function(start_date        = NULL,
                                 end_data          = NULL,
                                 start_date_format = NULL,
                                 end_date_format   = NULL,
                                 style             = NULL,
                                 text              = NULL,
                                 auto_close        = NULL) {
    appTemp_dir        <- tempdir()
    appTemp            <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    announcements_file <- paste0(gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE))), ".yaml")
    yaml::write_yaml(list("start_date"        = start_date,
                          "end_date"          = end_data,
                          "start_date_format" = start_date_format,
                          "end_date_format"   = end_date_format,
                          "style"             = style,
                          "text"              = text,
                          "auto_close"        = auto_close),
                     announcements_file)
    yaml::read_yaml(announcements_file)
    periscope2::set_app_parameters(title              = "title",
                                   announcements_file = announcements_file)
    announce_output <- periscope2:::load_announcements()
    unlink(announcements_file, TRUE)
    announce_output
}

#########################################

test_that("add_ui_header - default", {
    # no header
    expect_null(shiny::isolate(periscope2:::.g_opts$header))
    # normal header
    skin               <- "light"
    status             <- "white"
    border             <- TRUE
    compact            <- FALSE
    left_sidebar_icon  <- shiny::icon("bars")
    right_sidebar_icon <- shiny::icon("th")
    fixed              <- FALSE
    left_menu          <- NULL
    right_menu         <- NULL

    periscope2::add_ui_header(left_menu          = left_menu,
                              right_menu         = right_menu,
                              skin               = skin,
                              status             = status,
                              border             = border,
                              compact            = compact,
                              left_sidebar_icon  = left_sidebar_icon,
                              right_sidebar_icon = right_sidebar_icon,
                              fixed              = fixed)


    header <- shiny::isolate(periscope2:::.g_opts$header)
    expect_equal(length(header), 2)
    expect_true(grepl('Set using set_app_parameters() in program/global.R', header[[1]], fixed = TRUE))
    expect_null(header[[2]])
})


test_that("add_ui_left_sidebar no left sidebar", {
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$left_sidebar))
})


test_that("add_ui_left_sidebar empty left sidebar", {
    skin             <- "light"
    status           <- "primary"
    elevation        <- 4
    collapsed        <- FALSE
    minified         <- FALSE
    expand_on_hover  <- FALSE
    fixed            <- TRUE
    sidebar_elements <- NULL
    sidebar_menu     <- NULL
    custom_area      <- NULL
    add_ui_left_sidebar(sidebar_elements = sidebar_elements,
                        skin             = skin,
                        status           = status,
                        elevation        = elevation,
                        collapsed        = collapsed,
                        minified         = minified,
                        expand_on_hover  = expand_on_hover,
                        fixed            = fixed,
                        sidebar_menu     = sidebar_menu,
                        custom_area      = custom_area)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$left_sidebar))
})


test_that("add_ui_left_sidebar example left sidebar", {
    skin             <- "light"
    status           <- "primary"
    elevation        <- 4
    collapsed        <- FALSE
    minified         <- FALSE
    expand_on_hover  <- FALSE
    fixed            <- TRUE
    sidebar_elements <- NULL
    sidebar_menu     <-  sidebarMenu(
        id = "features_id",
        sidebarHeader("Periscope2 Features"),
        menuItem(
            text    = "Application Setup",
            tabName = "application_setup",
            icon    = icon("building")
        ),
        menuItem(
            text    = "Periscope2 Modules",
            tabName = "periscope_modules",
            icon    = icon("cubes")
        ),
        menuItem(
            text    = "User Notifications",
            tabName = "user_notifications",
            icon    = icon("comments")
        )
    )
    custom_area      <- NULL
    add_ui_left_sidebar(sidebar_elements = sidebar_elements,
                        skin             = skin,
                        status           = status,
                        elevation        = elevation,
                        collapsed        = collapsed,
                        minified         = minified,
                        expand_on_hover  = expand_on_hover,
                        fixed            = fixed,
                        sidebar_menu     = sidebar_menu,
                        custom_area      = custom_area)
    left_sidebar <- shiny::isolate(periscope2:::.g_opts$left_sidebar)
    expect_equal(length(left_sidebar), 10)
    expect_snapshot_output(left_sidebar[1:9])
    expect_true(grepl('Application Setup', left_sidebar[[10]], fixed = TRUE))
    expect_true(grepl('Periscope2 Modules', left_sidebar[[10]], fixed = TRUE))
    expect_true(grepl('User Notifications', left_sidebar[[10]], fixed = TRUE))
})


test_that("add_ui_right_sidebar no right sidebar", {
    expect_null(shiny::isolate(periscope2:::.g_opts$right_sidebar))
})


test_that("add_ui_right_sidebar empty right sidebar", {
    collapsed        <- TRUE
    overlay          <- TRUE
    skin             <- "light"
    pinned           <- FALSE
    sidebar_elements <- NULL
    sidebar_menu     <- NULL

    add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                         collapsed        = collapsed,
                         overlay          = overlay,
                         skin             = skin,
                         pinned           = pinned,
                         sidebar_menu     = sidebar_menu)
    righ_sidebar <- shiny::isolate(periscope2:::.g_opts$right_sidebar)
    expect_true(grepl('id="controlbarId"' , righ_sidebar, fixed = TRUE))
    expect_true(grepl('id="sidebarRightAlert"' , righ_sidebar, fixed = TRUE))
})


test_that("add_ui_right_sidebar example right sidebar", {
    collapsed        <- TRUE
    overlay          <- TRUE
    skin             <- "light"
    pinned           <- FALSE
    sidebar_elements <-  list(div(checkboxInput("hideFileOrganization", "Show Files Organization"), style = "margin-left:20px"))
    sidebar_menu     <- NULL

    add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                         collapsed        = collapsed,
                         overlay          = overlay,
                         skin             = skin,
                         pinned           = pinned,
                         sidebar_menu     = sidebar_menu)
    righ_sidebar <- shiny::isolate(periscope2:::.g_opts$right_sidebar)
    expect_true(grepl('id="controlbarId"' , righ_sidebar, fixed = TRUE))
    expect_true(grepl('id="sidebarRightAlert"' , righ_sidebar, fixed = TRUE))
    expect_true(grepl('id="hideFileOrganization"' , righ_sidebar, fixed = TRUE))
    expect_true(grepl('Show Files Organization' , righ_sidebar, fixed = TRUE))
})


test_that("add_ui_footer no footer", {
    expect_null(shiny::isolate(periscope2:::.g_opts$footer))
})


test_that("add_ui_footer empty footer", {
    right <- NULL
    fixed <- FALSE
    left  <- NULL

    add_ui_footer(left, right, fixed)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$footer))
})


test_that("add_ui_footer example footer", {
    right <- "2022"
    fixed <- FALSE
    left  <- a(
        href   = "https://periscopeapps.org/",
        target = "_blank",
        "periscope2")

    add_ui_footer(left, right, fixed)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$footer))
})


test_that("add_ui_body empty body", {
    expect_equal(shiny::isolate(periscope2:::.g_opts$body_elements), c())
    add_ui_body()
    expect_snapshot(shiny::isolate(periscope2:::.g_opts$body_elements))
})


test_that("add_ui_body example body", {
    about_box <- jumbotron(
        title = "periscope2: Enterprise Streamlined 'Shiny' Application Framework",
        lead  = p("periscope2 is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience",
                  "functions with the goal of both streamlining robust application development and assisting in creating a consistent",
                  " user experience regardless of application or developer."),
        tags$dl(tags$dt("Features"),
                tags$ul(tags$li("Predefined but flexible template for new Shiny applications with a default dashboard layout"),
                        tags$li("Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local."),
                        tags$li("Off-the-shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'"),
                        tags$li("Different methods to notify user and add useful information about application UI and server operations"))),
        status = "info",
        href   = "https://periscopeapps.org/"
    )

    add_ui_body(list(about_box))
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$body_elements))

    add_ui_body(list(div("more elements")), append = TRUE)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$body_elements))
    dashboard_ui <- periscope2:::create_application_dashboard()
    expect_true(grepl('id="announceAlert"' , dashboard_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="headerAlert"' , dashboard_ui[[2]], fixed = TRUE))
    expect_true(grepl('Periscope2 Features' , dashboard_ui[[3]], fixed = TRUE))
    expect_true(grepl('id="sidebarRightAlert"' , dashboard_ui[[3]], fixed = TRUE))
    expect_true(grepl('id="footerAlert"' , dashboard_ui[[3]], fixed = TRUE))
})

test_that("add_ui_body append", {
    add_ui_body(list(div("append div")), append = TRUE)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$body_elements))
})

test_that("set_app_parameters default values", {
    expect_equal(shiny::isolate(periscope2:::.g_opts$app_title), "Set using set_app_parameters() in program/global.R")
    expect_null(shiny::isolate(periscope2:::.g_opts$app_info), NULL)
    expect_equal(shiny::isolate(periscope2:::.g_opts$loglevel), "DEBUG")
    expect_equal(shiny::isolate(periscope2:::.g_opts$app_version), "1.0.0")
    expect_null(shiny::isolate(periscope2:::.g_opts$loading_indicator))
    expect_null(shiny::isolate(periscope2:::.g_opts$announcements_file))
    expect_null(periscope2:::load_announcements())
})

test_that("set_app_parameters update values", {
    announcements_file <- system.file("fw_templ", "announce.yaml", package = "periscope2")
    title              <- "periscope Example Application"
    app_info           <- HTML("Demonstrate periscope features and generated application layout")
    log_level          <- "INFO"
    app_version        <- "2.3.1"
    loading_indicator  <- list(html = tagList(div("Loading ...")))

    periscope2::set_app_parameters(title              = title,
                                   app_info           = app_info,
                                   log_level          = log_level,
                                   app_version        = app_version,
                                   loading_indicator  = loading_indicator,
                                   announcements_file = announcements_file)

    expect_equal(shiny::isolate(periscope2:::.g_opts$app_title), title)
    expect_snapshot(shiny::isolate(periscope2:::.g_opts$app_info))
    expect_equal(shiny::isolate(periscope2:::.g_opts$loglevel), log_level)
    expect_equal(shiny::isolate(periscope2:::.g_opts$app_version), app_version)
    expect_snapshot(shiny::isolate(periscope2:::.g_opts$loading_indicator))
    expect_equal(shiny::isolate(periscope2:::.g_opts$announcements_file), announcements_file)
    expect_equal(periscope2:::load_announcements(), 30000)
    expect_equal( periscope2:::fw_get_loglevel(), log_level)
    expect_equal(periscope2:::fw_get_title(), title)
    expect_equal(periscope2:::fw_get_version(), app_version)
})

test_that("load_announcements empty file", {
    # test empty announcement
    appTemp_dir        <- tempdir()
    appTemp            <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    announcements_file <- paste0(gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE))), ".yaml")
    yaml::write_yaml("", announcements_file)

    periscope2::set_app_parameters(title              = "title",
                                   announcements_file = announcements_file)
    expect_null(periscope2:::load_announcements())
    unlink(announcements_file, TRUE)
})

test_that("load_announcements - parsing error", {
    # test empty announcement
    appTemp_dir        <- tempdir()
    appTemp            <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    announcements_file <- paste0(gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE))), ".yaml")
    cat(":", file = (con <- file(announcements_file, "w", encoding = "UTF-8")))
    close(con)

    periscope2::set_app_parameters(title              = "title",
                                   announcements_file = announcements_file)
    expect_warning(periscope2:::load_announcements(), regexp = "[(Could not parse TestThatApp)]")
    unlink(announcements_file, TRUE)
})

test_that("load_announcements function parameters", {
    expect_null(create_announcements(start_date = "2222-11-26",
                                     end_data   = "2222-12-26"))
    expect_null(create_announcements(start_date = "2022-11-26",
                                     end_data   = "2222-12-26",
                                     style      = "not-style"))
    expect_null(create_announcements(start_date        = "11-26-2222",
                                     end_data          = "12-26-2222",
                                     start_date_format = "%m-%d-%Y",
                                     end_date_format   = "%m-%d-%Y"))
    expect_null(create_announcements(start_date        = "11-26-2222",
                                     end_data          = "12-26-2222",
                                     end_date_format   = "%m-%d-%Y"))
    expect_null(create_announcements(start_date        = "11-26-2222",
                                     end_data          = "12-26-2222",
                                     start_date_format = "%m-%d-%Y"))
    expect_null(create_announcements(start_date        = "11-26-2222",
                                     start_date_format = "%m-%d-%Y"))
    expect_null(create_announcements(style = "info"))
    expect_null(create_announcements(style      = "info",
                                     text       = "text",
                                     auto_close = "abc"))
})

test_that("load_theme_settings - null settings", {
    expect_snapshot(load_theme_settings())
})

test_that("create_theme - full settings", {
    theme_settings                  <- yaml::read_yaml(system.file("fw_templ", "p_example", "periscope_style.yaml",
                                                                   package = "periscope2"))
    theme_settings["sidebar_width"] <- 300

    expect_snapshot(nchar(create_theme()))
})

test_that("create_theme - invalid color settings", {
    theme_settings <- yaml::read_yaml(system.file("fw_templ", "p_example", "periscope_style.yaml", package = "periscope2"))

    theme_settings["primary"] <- "not color"

    expect_snapshot(nchar(create_theme()))
})

test_that("create_theme - invalid measure settings", {
    theme_settings <- yaml::read_yaml(system.file("fw_templ", "p_example", "periscope_style.yaml", package = "periscope2"))

    theme_settings["sidebar_horizontal_padding"] <- "3oo"
    theme_settings["sidebar_mini_width"]         <- -2

    expect_snapshot(nchar(create_theme()))
})

test_that("ui_tooltip", {
    expect_snapshot_output(ui_tooltip(id = "id", label = "mylabel", text = "mytext"))
    expect_snapshot_output(ui_tooltip(id = "id2", label = "mylabel2", text = "mytext2", placement = "left"))
    expect_snapshot_error(ui_tooltip(id = "id2", label = "mylabel2", text = "mytext2", placement = "nowhere"))
})

test_that("ui_tooltip no text", {
    expect_warning(ui_tooltip(id = "id", label = "mylabel", text = ""), "ui_tooltip\\() called without tooltip text.")
})


test_that("theme - valid theme", {
    theme_settings <- yaml::read_yaml(system.file("fw_templ", "p_example", "periscope_style.yaml", package = "periscope2"))
    dir.create("www")
    yaml::write_yaml(theme_settings, "www/periscope_style.yaml")
    expect_snapshot(nchar(create_theme()))
    unlink("www/periscope_style.yaml")
    unlink("www", recursive = TRUE)
})


test_that("theme - parsing error", {
    dir.create("www")
    theme_file           <- "www/periscope_style.yaml"
    cat(":", file = (con <- file(theme_file, "w", encoding = "UTF-8")))
    close(con)
    expect_snapshot(nchar(suppressWarnings(periscope2:::create_theme())))
    unlink("www/periscope_style.yaml")
    unlink("www", recursive = TRUE)
})


test_that("theme - invalid theme settings", {
    theme_settings <- yaml::read_yaml(system.file("fw_templ", "p_example", "periscope_style.yaml", package = "periscope2"))
    dir.create("www")
    theme_settings[["primary"]]             <- "not color"
    theme_settings[["sidebar_width"]]       <- "300"
    theme_settings[["right_sidebar_width"]] <- "-300"

    yaml::write_yaml(theme_settings, "www/periscope_style.yaml")
    expect_snapshot(nchar(create_theme()))
    unlink("www/periscope_style.yaml")
    unlink("www", recursive = TRUE)
})


test_that("dashboard - create default dashboard", {
    expect_snapshot(periscope2:::create_application_dashboard())
})


test_that("add_ui_header - html title", {
    announcements_file <- system.file("fw_templ", "announce.yaml", package = "periscope2")
    title              <- "periscope Example Application"
    app_info           <- HTML("Demonstrate periscope features and generated application layout")
    log_level          <- "INFO"
    app_version        <- "2.3.1"
    loading_indicator  <- list(html = tagList(div("Loading ...")))

    periscope2::set_app_parameters(title              = title,
                                   app_info           = app_info,
                                   log_level          = log_level,
                                   app_version        = app_version,
                                   loading_indicator  = loading_indicator,
                                   announcements_file = announcements_file)
    # normal header
    skin               <- "light"
    status             <- "white"
    border             <- TRUE
    compact            <- FALSE
    left_sidebar_icon  <- shiny::icon("bars")
    right_sidebar_icon <- shiny::icon("th")
    fixed              <- FALSE
    left_menu          <- NULL
    right_menu         <- NULL

    periscope2::add_ui_header(left_menu          = left_menu,
                              right_menu         = right_menu,
                              skin               = skin,
                              status             = status,
                              border             = border,
                              compact            = compact,
                              left_sidebar_icon  = left_sidebar_icon,
                              right_sidebar_icon = right_sidebar_icon,
                              fixed              = fixed)


    expect_snapshot(shiny::isolate(periscope2:::.g_opts$app_info))
    header <- shiny::isolate(periscope2:::.g_opts$header)
    expect_snapshot(header[[1]])
})


test_that("add_ui_header - url title", {
    announcements_file <- system.file("fw_templ", "announce.yaml", package = "periscope2")
    title              <- "periscope Example Application"
    app_info           <- "https://cran.r-project.org/web/packages/periscope2/index.html"
    log_level          <- "DEBUG"
    app_version        <- "2.3.1"
    loading_indicator  <- list(html = tagList(div("Loading ...")))

    periscope2::set_app_parameters(title              = title,
                                   app_info           = app_info,
                                   log_level          = log_level,
                                   app_version        = app_version,
                                   loading_indicator  = loading_indicator,
                                   announcements_file = announcements_file)
    # normal header
    skin               <- "light"
    status             <- "white"
    border             <- TRUE
    compact            <- FALSE
    left_sidebar_icon  <- shiny::icon("bars")
    right_sidebar_icon <- shiny::icon("th")
    fixed              <- FALSE
    left_menu          <- NULL
    right_menu         <- NULL

    periscope2::add_ui_header(left_menu          = left_menu,
                              right_menu         = right_menu,
                              skin               = skin,
                              status             = status,
                              border             = border,
                              compact            = compact,
                              left_sidebar_icon  = left_sidebar_icon,
                              right_sidebar_icon = right_sidebar_icon,
                              fixed              = fixed)


    expect_snapshot(shiny::isolate(periscope2:::.g_opts$app_info))
    header <- shiny::isolate(periscope2:::.g_opts$header)
    expect_snapshot(header[[1]])
})
