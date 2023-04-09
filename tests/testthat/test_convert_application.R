context("periscope2 convert existing application")


expect_converted_application <- function(location,
                                         left_sidebar = TRUE,
                                         right_sidebar = FALSE) {
    local_edition(3)
    expect_true(dir.exists(location))
    expect_true(file.exists(file.path(location, "global.R")))
    expect_true(file.exists(file.path(location, "server.R")))
    expect_true(file.exists(file.path(location, "ui.R")))
    expect_true(dir.exists(file.path(location, "program")))
    expect_true(file.exists(file.path(location, "program/ui_header.R")))
    expect_true(file.exists(file.path(location, "program/ui_footer.R")))
    expect_true(file.exists(file.path(location, "program/ui_body.R")))

    ui_content <- readLines(con = paste(location, "ui.R", sep = .Platform$file.sep))
    expect_true(any(grepl("source(paste(\"program\", \"ui_body.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    expect_true(any(grepl("source(paste(\"program\", \"ui_header.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    expect_true(any(grepl("create_application_dashboard()", ui_content, fixed = TRUE)))

    if (right_sidebar) {
        expect_true(any(grepl("source(paste(\"program\", \"ui_right_sidebar.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    } else {
        expect_false(any(grepl("source(paste(\"program\", \"ui_right_sidebar.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    }

    if (left_sidebar) {
        expect_true(any(grepl("source(paste(\"program\", \"ui_left_sidebar.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    } else {
        expect_false(any(grepl("source(paste(\"program\", \"ui_left_sidebar.R\", sep = .Platform$file.sep), local = TRUE)", ui_content, fixed = TRUE)))
    }

    # clean up
    unlink(location, TRUE)
}

# creates a temp directory, copies the sample_app to this directory and returns the path of the temp app
create_app_tmp_dir <- function(left_sidebar = TRUE, right_sidebar = FALSE) {
    app_name     <- "sample_app_both_sidebars"

    if (left_sidebar && !right_sidebar) {
        app_name <- "sample_app_left_sidebar"
    } else if (!left_sidebar && right_sidebar) {
        app_name <- "sample_app_right_sidebar"
    } else if (!left_sidebar && !right_sidebar) {
        app_name <- "sample_app_no_both_sidebars"
    }


    app_temp.dir <- tempdir()
    file.copy(app_name, app_temp.dir, recursive = TRUE)
    file.path(app_temp.dir, app_name)
}

## left_sidebar tests

test_that("create_left_sidebar null location", {
    expect_error(create_left_sidebar(location = NULL),
                 "Add left sidebar conversion could not proceed, location cannot be empty!")
})

test_that("create_left_sidebar empty location", {
    expect_error(create_left_sidebar(location = ""),
                 "Add left sidebar conversion could not proceed, location cannot be empty!")
})

test_that("create_left_sidebar invalid location", {
    expect_error(create_left_sidebar(location = "invalid"),
                 "Add left sidebar conversion could not proceed, location=<invalid> does not exist!")
})

test_that("create_left_sidebar location does not contain an existing application", {
    expect_error(create_left_sidebar(location = "../testthat"),
                 "Add left sidebar conversion could not proceed, location=<../testthat> does not contain a valid periscope application!")
})

test_that("create_left_sidebar to right sidebar, valid location", {
    app_location <- create_app_tmp_dir(left_sidebar = FALSE, right_sidebar = TRUE)

    expect_message(create_left_sidebar(location = app_location), "Add left sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_converted_application(location = app_location, left_sidebar = TRUE, right_sidebar = TRUE)
})

test_that("create_left_sidebar valid location", {
    app_location <- create_app_tmp_dir(left_sidebar = FALSE)

    expect_message(create_left_sidebar(location = app_location), "Add left sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_converted_application(location = app_location, left_sidebar = TRUE)
})

test_that("create_left_sidebar valid location, added twice", {
    app_location <- create_app_tmp_dir(left_sidebar = FALSE)

    expect_message(create_left_sidebar(location = app_location), "Add left sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_message(create_left_sidebar(location = app_location), "Left sidebar already available, no conversion needed")
    expect_converted_application(location = app_location, left_sidebar = TRUE)
})

## create_right_sidebar tests

test_that("create_right_sidebar null location", {
    expect_error(create_right_sidebar(location = NULL),
                 "Add right sidebar conversion could not proceed, location cannot be empty!")
})

test_that("create_right_sidebar empty location", {
    expect_error(create_right_sidebar(location = ""),
                 "Add right sidebar conversion could not proceed, location cannot be empty!")
})

test_that("create_right_sidebar invalid location", {
    expect_error(create_right_sidebar(location = "invalid"),
                 "Add right sidebar conversion could not proceed, location=<invalid> does not exist!")
})

test_that("create_right_sidebar location does not contain an existing application", {
    expect_error(create_right_sidebar(location = "../testthat"),
                 "Add right sidebar conversion could not proceed, location=<../testthat> does not contain a valid periscope application!")
})

test_that("create_right_sidebar to left sidebar, valid location", {
    app_location <- create_app_tmp_dir(right_sidebar = FALSE, left_sidebar = TRUE)

    expect_message(create_right_sidebar(location = app_location), "Add right sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_converted_application(location = app_location, right_sidebar = TRUE, left_sidebar = TRUE)
})

test_that("create_right_sidebar, valid location", {
    app_location <- create_app_tmp_dir(right_sidebar = FALSE, left_sidebar = FALSE)

    expect_message(create_right_sidebar(location = app_location), "Add right sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_converted_application(location = app_location, right_sidebar = TRUE, left_sidebar = FALSE)
})


test_that("create_right_sidebar valid location, added twice", {
    app_location <- create_app_tmp_dir(right_sidebar = FALSE)

    expect_message(create_right_sidebar(location = app_location), "Add right sidebar conversion was successful. File\\(s\\) updated: ui.R")
    expect_message(create_right_sidebar(location = app_location), "Right sidebar already available, no conversion needed")
    expect_converted_application(location = app_location, right_sidebar = TRUE)
})
