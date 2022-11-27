context("periscope2 - downloadable table")
local_edition(3)

test_that("downloadableTableUI", {
    expect_snapshot_output(downloadableTableUI(id            = "myid",
                                               downloadtypes = c("csv"),
                                               hovertext     = "myHoverText"))
})

# helper functions
data <- reactive({
    head(mtcars)
})

data_without_rownames <- reactive({
    sub_data           <- head(mtcars)
    rownames(sub_data) <- NULL
    sub_data
})

mydataRowIds <- function(){
    rownames(head(mtcars))
}

test_that("downloadableTable - singleSelect_FALSE_selection_enabled", {
        testServer(downloadableTable,
                   args = list(logger           = periscope2:::fw_get_user_log(),
                               filenameroot     = "mydownload1",
                               downloaddatafxns = list(csv = data, tsv = data),
                               tabledata        = data,
                               selection        = mydataRowIds),
                   expr = {
                       session$setInputs(dtableSingleSelect = "FALSE")
                       expect_snapshot(output$dtableOutputID)

                   })
})

test_that("downloadableTable - null data", {
    testServer(downloadableTable,
               args = list(logger           = periscope2:::fw_get_user_log(),
                           filenameroot     = "mydownload1",
                           tabledata        = function() { NULL }),
               expr = {
                   session$setInputs(dtableSingleSelect = "FALSE")
                   expect_snapshot(output$dtableOutputID)

               })
})

test_that("downloadableTable - invalid download option", {
    testServer(downloadableTable,
               args = list(logger           = periscope2:::fw_get_user_log(),
                           filenameroot     = "mydownload1",
                           downloaddatafxns = list(sv = data),
                           tabledata        = data,
                           selection        = mydataRowIds),
               expr = {
                   session$setInputs(dtableSingleSelect = "FALSE")
                   expect_snapshot(output$dtableOutputID)

               })
})

test_that("downloadableTable - singleSelect_TRUE_selection_enabled", {
    testServer(downloadableTable,
               args = list(logger           = periscope2:::fw_get_user_log(),
                           filenameroot     = "mydownload1",
                           downloaddatafxns = list(csv = data, tsv = data),
                           tabledata        = data,
                           selection        = mydataRowIds),
               expr = {
                   session$setInputs(dtableSingleSelect = "TRUE")
                   expect_snapshot(output$dtableOutputID)

               })
})

test_that("downloadableTable - null rownames", {

    testServer(downloadableTable,
               args = list(logger           = periscope2:::fw_get_user_log(),
                           filenameroot     = "mydownload1",
                           downloaddatafxns = list(csv = data_without_rownames, tsv = data_without_rownames),
                           tabledata        = data_without_rownames,
                           selection        = NULL),
               expr = {
                   session$setInputs(dtableSingleSelect = "FALSE")
                   expect_snapshot(output$dtableOutputID)

               })
})

test_that("downloadableTable - singleSelect and selection disabled", {
  expect_silent(testServer(downloadableTable,
                             args = list(logger           = periscope2:::fw_get_user_log(),
                                         filenameroot     = "mydownload1",
                                         downloaddatafxns = list(csv = data, tsv = data),
                                         tabledata        = data),
                             expr = {}))
})

test_that("downloadableTable - invalid_selection", {
    expect_message(testServer(downloadableTable,
                              args = list(logger           = periscope2:::fw_get_user_log(),
                                          filenameroot     = "mydownload1",
                                          downloaddatafxns = list(csv = data, tsv = data),
                                          tabledata        = data,
                                          selection        = "single"),
                              expr = {}), "")
})

test_that("build_datatable_arguments", {
    table_options <- list(rownames = FALSE,
                          callback   = "table.order([2, 'asc']).draw();",
                          caption    = " Very Important Information",
                          colnames   = c("Area", "Delta", "Increase"),
                          filter     = "bottom",
                          width      = "150px",
                          height     = "50px",
                          extensions = "Buttons",
                          plugins    = "natural",
                          editable   = TRUE,
                          order      = list(list(2, "asc"), list(3, "desc")))
    expect_snapshot(build_datatable_arguments(table_options))
})


test_that("format_columns", {
    set.seed(123)
    dt           <- cbind(matrix(rnorm(60, 1e5, 1e6), 20), runif(20), rnorm(20, 100))
    dt[, 1:3]    <- round(dt[, 1:3])
    dt[, 4:5]    <- round(dt[, 4:5], 7)
    colnames(dt) <- head(LETTERS, NCOL(dt))
    expect_snapshot(format_columns(DT::datatable(dt),
                                   list(formatCurrency   = list(columns = c("A", "C")),
                                        formatPercentage = list(columns = c("D"), 2))))
})
