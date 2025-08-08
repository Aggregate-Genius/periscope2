context("periscope2 - Log Viewer")
local_edition(3)
# Helper functions
sample_log <- function(){
    c("actions [2022-02-19 14:03:26] Be Sure to Remember to Log ALL user actions",
      "actions [2022-02-19 14:03:27] Sample Title (click for an info pop-up) started with log level <DEBUG>",
      "actions [2022-02-19 14:04:32] Application Reset requested by user.  Resetting in  5 seconds")
}

null_log <- function(){
    NULL
}

empty_log <- function(){
    NULL
}

# UI unit tests
test_that("logViewerOutput", {
    expect_snapshot_output(logViewerOutput("myid"))
})


# Server unit tests
test_that("logViewer - valid sample log", {
    testServer(logViewer,
               args = list(id = "myid", logger = sample_log),
               expr = {
                   expect_snapshot_output(output$"myid-reactTableOutputID")
               })
})


# test_that("logViewer - null sample log", {
#     testServer(logViewer,
#                args = list(id = "nullLogger", logger = null_log),
#                expr = {
#                    expect_null(output$nullLogger)
#                })
# })
#
#
# test_that("logViewer - empty sample log", {
#     testServer(logViewer,
#                args = list(id = "emptyLogger", logger = empty_log),
#                expr = {
#                    expect_null(output$emptyLogger)
#                })
# })
