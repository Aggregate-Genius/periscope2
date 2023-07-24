context("periscope2 - misc functions")

log_directory <- tempdir()

test_that("get_url_parameters - NULL", {
    result <- get_url_parameters(NULL)
    expect_equal(result, list(), "get_url_parameters")
})

test_that("get_url_parameters", {
    fake_session <- list(clientData = list(url_search = "&test1=ABC&test2=123"))
    result       <- get_url_parameters(fake_session)
    expect_equal(result, list(test1 = "ABC", test2 = "123"), "get_url_parameters")
})

test_that("fw_get_user_log", {
    result <- periscope2:::fw_get_user_log()
    expect_equal(class(result)[1], "Logger")
})

test_that("setup_logging", {
    result <- shiny::isolate(.setup_logging(NULL, periscope2:::fw_get_user_log()))
    expect_true(shiny::is.reactive(result))
})

test_that("setup_logging existing log", {
    logger <- periscope2:::fw_get_user_log()
    file.create(paste0(paste(log_directory, logger$name, sep = .Platform$file.sep), ".log"))

    result <- shiny::isolate(.setup_logging(NULL, logger))
    expect_true(shiny::is.reactive(result))
})

test_that("fw_server_setup", {
    local_edition(3)
    expect_snapshot_error(fw_server_setup(input = list(),
                                          output = list(),
                                          session = MockShinySession$new(),
                                          logger = periscope2:::fw_get_user_log()))
})

test_that("is_valid_color", {
    expect_true(is_valid_color("green"))
    expect_false(is_valid_color("not color"))
})

test_that("is_valid_format - valid format", {
    expect_true(periscope2:::is_valid_format("2023-07-07"))
})

# clean up
unlink("log", TRUE)
