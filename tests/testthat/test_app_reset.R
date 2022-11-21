context("periscope2 - App reset")

test_that(".appResetButton", {
    local_edition(3)
    expect_snapshot_output(appResetButton("myid"))
})

test_that("app_reset - no reset button", {
    expect_silent(testServer(appReset,
                             args = list(reset_wait = 5000,
                                         logger     = periscope2:::fw_get_user_log()),
                             expr = {session$setInputs(resetPending = NULL)}))
})

test_that("app_reset - reset button - no pending - defaul time", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(reset_wait     = 5000,
                                                          alert_location = "headerAlert",
                                                          logger         = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = TRUE,
                                                                        resetPending = FALSE)}))
    expect_match(reset_output, "Resetting in  5 seconds")
})

test_that("app_reset - reset button - no pending - defaul time", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(reset_wait     = 5000,
                                                          alert_location = "headerAlert2",
                                                          logger         = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = TRUE,
                                                                        resetPending = FALSE)}))
    expect_match(reset_output, "Resetting in  5 seconds")
})

test_that("app_reset - reset button - no pending - custom time", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(reset_wait = 3000,
                                                          logger     = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = TRUE,
                                                                        resetPending = FALSE)}))
    expect_match(reset_output, "Resetting in  3 seconds")
})

test_that("app_reset - reset button - no pending - no passed time", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(logger = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = TRUE,
                                                                        resetPending = FALSE)}))
    expect_match(reset_output, "Resetting in  5 seconds")
})

test_that("app_reset - no reset button - with pending", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(logger = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = FALSE,
                                                                        resetPending = TRUE)}))
    expect_match(reset_output, "Application Reset cancelled by user")

})

test_that("app_reset - reset button - with pending", {
    reset_output <- capture_output(testServer(appReset,
                                              args = list(logger = periscope2:::fw_get_user_log()),
                                              expr = {session$setInputs(resetButton  = TRUE,
                                                                        resetPending = TRUE)}))
    expect_match(reset_output, "WARNING:actions:Application Reset")
})

test_that("app_reset - no reset button - no pending", {
    expect_silent(testServer(appReset,
                             args = list(logger = periscope2:::fw_get_user_log()),
                             expr = {session$setInputs(resetButton  = FALSE,
                                                       resetPending = FALSE)}))
})
