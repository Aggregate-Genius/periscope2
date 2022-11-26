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
    announce_output <- load_announcements()
    unlink(announcements_file, TRUE)
    announce_output
}

#########################################

test_that("add_ui_header", {
    # no header
    expect_null(shiny::isolate(periscope2:::.g_opts$header))
    # normal header
    skin           <- "light"
    status         <- "white"
    border         <- TRUE
    compact        <- FALSE
    sidebarIcon    <- shiny::icon("bars")
    controlbarIcon <- shiny::icon("th")
    fixed          <- FALSE
    left_ui        <- NULL
    right_ui       <- NULL
    periscope2::add_ui_header(skin           = skin,
                              status         = status,
                              border         = border,
                              compact        = compact,
                              sidebarIcon    = sidebarIcon,
                              controlbarIcon = controlbarIcon,
                              fixed          = fixed,
                              left_ui        = left_ui,
                              right_ui       = right_ui)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$header))
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
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$left_sidebar))
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
    controlbar_menu  <- NULL

    add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                         collapsed        = collapsed,
                         overlay          = overlay,
                         skin             = skin,
                         pinned           = pinned,
                         controlbar_menu  = controlbar_menu)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$right_sidebar))
})


test_that("add_ui_right_sidebar example right sidebar", {
    collapsed        <- TRUE
    overlay          <- TRUE
    skin             <- "light"
    pinned           <- FALSE
    sidebar_elements <-  list(div(checkboxInput("hideFileOrganization", "Show Files Organization"), style = "margin-left:20px"))
    controlbar_menu  <- NULL

    add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                         collapsed        = collapsed,
                         overlay          = overlay,
                         skin             = skin,
                         pinned           = pinned,
                         controlbar_menu  = controlbar_menu)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$right_sidebar))
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
                tags$ul(tags$li("A predefined but flexible template for new Shiny applications with a default dashboard layout"),
                        tags$li("Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local."),
                        tags$li("Six off shelf and ready to be used modules ('Announcments', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'"),
                        tags$li("Different methods to notify user and add useful information about application UI and server operations"))),
        status = "info",
        href   = "https://periscopeapps.org/"
    )

    add_ui_body(list(about_box))
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$body_elements))

    add_ui_body(list(div("more elements")), append = TRUE)
    expect_snapshot_output(shiny::isolate(periscope2:::.g_opts$body_elements))
})

test_that("set_app_parameters default values", {
    expect_equal(shiny::isolate(periscope2:::.g_opts$app_title), "Set using set_app_parameters() in program/global.R")
    expect_null(shiny::isolate(periscope2:::.g_opts$app_info), NULL)
    expect_equal(shiny::isolate(periscope2:::.g_opts$loglevel), "DEBUG")
    expect_equal(shiny::isolate(periscope2:::.g_opts$app_version), "1.0.0")
    expect_null(shiny::isolate(periscope2:::.g_opts$loading_indicator))
    expect_null(shiny::isolate(periscope2:::.g_opts$announcements_file))
    expect_null(load_announcements())
})

test_that("set_app_parameters update values", {
    announcements_file <- system.file("fw_templ", "announce.yaml", package = "periscope2")
    title              <- "periscope Example Application"
    app_info           <- HTML("Demonstrat periscope features and generated application layout")
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
    expect_equal(load_announcements(), 30000)
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
    expect_null(load_announcements())
    unlink(announcements_file, TRUE)
})

test_that("load_announcements start and end dates", {
    expect_null(create_announcements(start_date = "11-26-2022",
                                     end_data   = "12-26-2022"))
    expect_null(create_announcements(start_date        = "11-26-2022",
                                     end_data          = "12-26-2022",
                                     start_date_format = "%m-%d-%y",
                                     end_date_format   = "%m-%d-%y"))
    expect_null(create_announcements(start_date        = "11-26-2022",
                                     end_data          = "12-26-2022",
                                     end_date_format   = "%m-%d-%y"))
    expect_null(create_announcements(start_date        = "11-26-2022",
                                     end_data          = "12-26-2022",
                                     start_date_format = "%m-%d-%y"))
    expect_null(create_announcements(start_date        = "11-26-2022",
                                     start_date_format = "%m-%d-%y"))
    expect_null(create_announcements(style = "info"))
    expect_null(create_announcements(style      = "info",
                                     text       = "text",
                                     auto_close = "abc"))
})

test_that("ui_tooltip", {
    expect_snapshot_output(ui_tooltip(id = "id", label = "mylabel", text = "mytext"))
    expect_snapshot_output(ui_tooltip(id = "id2", label = "mylabel2", text = "mytext2", placement = "left"))
    expect_snapshot_error(ui_tooltip(id = "id2", label = "mylabel2", text = "mytext2", placement = "nowhere"))
})

test_that("ui_tooltip no text", {
    expect_warning(ui_tooltip(id = "id", label = "mylabel", text = ""), "ui_tooltip\\() called without tooltip text.")
})
