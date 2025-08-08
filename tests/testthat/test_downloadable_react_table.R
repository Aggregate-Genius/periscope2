context("periscope2 - downloadable react table")
local_edition(3)

test_that("downloadableReactTableUI", {
    table_ui <- downloadableReactTableUI(id            = "myid",
                                         downloadtypes = c("csv"),
                                         hovertext     = "myHoverText")
    expect_equal(length(table_ui), 2)
    expect_true(grepl('id="myid-reactTableButtonDiv"', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('title="myHoverText"', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="myid-reactTableButtonID-csv"', table_ui[[1]], fixed = TRUE))
    expect_false(grepl('style="display:none">', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="myid-reactTableOutputID"', table_ui[[2]], fixed = TRUE))
})


test_that("downloadableReactTableUI - no download types", {
    table_ui <- downloadableReactTableUI(id = "myid2")
    expect_equal(length(table_ui), 2)
    expect_true(grepl('id="myid2-reactTableButtonDiv"', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('style="display:none">', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="myid2-reactTableOutputID"', table_ui[[2]], fixed = TRUE))
})


# helper functions
get_mtcars_data <- reactive({
    head(mtcars)
})


test_that("downloadableReactTable - valid data", {
    testServer(downloadableReactTable,
               args = list(table_data = get_mtcars_data),
               expr = {
                   expect_true(grepl(paste0(names(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
                   expect_false(grepl(paste0(rownames(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$mpg, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$cyl, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$disp, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$hp, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$drat, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$wt, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$qsec, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$vs, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$am, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$gear, collapse = "|"), output$reactTableOutputID))
                   expect_true(grepl(paste0(get_mtcars_data()$carb, collapse = "|"), output$reactTableOutputID))
               })
})


test_that("downloadableReactTable - null or empty data.frame", {
    no_table_data_error <- "'table_data' parameter must be a function or reactive expression."
    server_error        <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data = NULL),
                   expr = {
                       expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
                       }))
    expect_true(grepl(no_table_data_error, server_error))

    server_error <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data = data.frame()),
                   expr = {
                       expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
                       }))
    expect_true(grepl(no_table_data_error, server_error))

    server_error <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data = NA),
                   expr = {
                       expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
                       }))
    expect_true(grepl(no_table_data_error, server_error))



    testServer(downloadableReactTable,
               args = list(table_data = function() { NULL }),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = shiny::reactiveVal(NULL)),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = shiny::reactiveVal(NA)),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = function() { data.frame() }),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = shiny::reactiveVal(data.frame())),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - single values", {
    no_table_data_error <- "'table_data' parameter must be a function or reactive expression."
    server_error        <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data = 5),
                   expr = {
                       expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
                       }))
    expect_true(grepl(no_table_data_error, server_error))

    testServer(downloadableReactTable,
               args = list(table_data = function() {5}),
               expr = {
                   expect_true(grepl('"table_data..":[5]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = shiny::reactiveVal(5)),
               expr = {
                   expect_true(grepl('"table_data..":[5]', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - empty data.frame", {
    no_table_data_error <- "'table_data' parameter must be a function or reactive expression."
    server_error        <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data = data.frame(5)),
                   expr = {
                       expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
                       }))
    expect_true(grepl(no_table_data_error, server_error))


    testServer(downloadableReactTable,
               args = list(table_data = function() {data.frame(5)}),
               expr = {
                   expect_true(grepl('data":{"X5":[5]}', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = shiny::reactiveVal(data.frame(5))),
               expr = {
                   expect_true(grepl('data":{"X5":[5]}', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - selection_mode", {
    skip_if(getRversion() < "4.1.0", "Skipping due to lifecycle warnings in R < 4.1.0")
    testServer(downloadableReactTable,
               args = list(table_data     = get_mtcars_data,
                           selection_mode = "Single"),
               expr = {
                   expect_true(grepl('"id":".selection"', output$reactTableOutputID, fixed = TRUE))
                   expect_true(grepl('"selection":"single"', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data     = get_mtcars_data,
                           selection_mode = "multiple"),
               expr = {
                   expect_true(grepl('"id":".selection"', output$reactTableOutputID, fixed = TRUE))
                   expect_true(grepl('"selection":"multiple"', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data     = get_mtcars_data,
                           selection_mode = "not_valid_mode"),
               expr = {
                   expect_false(grepl('"id":".selection"', output$reactTableOutputID, fixed = TRUE))
                   expect_false(grepl('"selection""', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - pre_selected_rows", {
    skip_if(getRversion() < "4.1.0", "Skipping due to lifecycle warnings in R < 4.1.0")

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           pre_selected_rows = function() {c(1, 3)}),
               expr = {
                   server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                   error_msg    <- "'selection_mode' parameter must be either 'single' or 'multiple' to use 'pre_selected_rows' param. Setting default value NULL"
                   expect_true(grepl(error_msg,  server_error))
               })

    server_error <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data        = get_mtcars_data,
                               selection_mode    = "multiple",
                               pre_selected_rows = c(1, 3)),
                   expr = {
                       output$reactTableOutputID
                   }))
    expect_true(grepl("'pre_selected_rows' parameter must be a function or reactive expression. Setting default value NULL.", server_error))

    server_error <- testServer(downloadableReactTable,
                   args = list(table_data        = get_mtcars_data,
                               selection_mode    = "multiple",
                               pre_selected_rows = function() {c(1, 3, "a")}),
                   expr = {
                       server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                       error_msg    <- "'pre_selected_rows' parameter must be a function or reactive expression that returns numeric vector. Setting default value NULL."
                       expect_true(grepl(error_msg,  server_error))
                       })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "single",
                           pre_selected_rows = function() {c(1, 3)}),
               expr = {
                   server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                   error_msg    <- "when 'selection_mode' is 'single', only first value of 'pre_selected_rows' will be used"
                   expect_true(grepl(error_msg,  server_error))
                   expect_true(grepl('"defaultSelected":[0]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "single",
                           pre_selected_rows = function() {c(1)}),
               expr = {
                   expect_true(grepl('"defaultSelected":[0]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "multiple",
                           pre_selected_rows = function() {c(1, 3)}),
               expr = {
                   expect_true(grepl('"defaultSelected":[0,2]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "multiple",
                           pre_selected_rows = function() {c(1, 300)}),
               expr = {
                   server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                   error_msg    <- "Excluding 'pre_selected_rows' value: 300 as it is out of range."
                   expect_true(grepl(error_msg,  server_error))
                   expect_true(grepl('"defaultSelected":[0]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "multiple",
                           pre_selected_rows = function() {c(-1, 2)}),
               expr = {
                   server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                   error_msg    <- "Excluding 'pre_selected_rows' value: -1 as it is out of range."
                   expect_true(grepl(error_msg,  server_error))
                   expect_true(grepl('"defaultSelected":[1]', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data        = get_mtcars_data,
                           selection_mode    = "multiple",
                           pre_selected_rows = function() {c(-1, 2, 4, 300)}),
               expr = {
                   server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                   error_msg    <- "Excluding 'pre_selected_rows' values: -1, 300 as they are out of range."
                   expect_true(grepl(error_msg,  server_error))
                   expect_true(grepl('"defaultSelected":[1,3]', output$reactTableOutputID, fixed = TRUE))
               })

    server_error <- capture_output(
        testServer(downloadableReactTable,
                   args = list(table_data        = get_mtcars_data,
                               selection_mode    = "multiple",
                               pre_selected_rows = function() {c(-1, 300)}),
                   expr = {
                       expect_false(grepl('"defaultSelected"', output$reactTableOutputID, fixed = TRUE))
                       }), print = TRUE)
    error_msg <- "All 'pre_selected_rows' values are out of range. Setting default value NULL."
    expect_true(grepl(error_msg,  server_error))

    testServer(downloadableReactTable,
                   args = list(table_data        = get_mtcars_data,
                               selection_mode    = "single",
                               pre_selected_rows = function() {c(-1, 300)}),
                   expr = {
                       server_error <- capture_output(output$reactTableOutputID, print = TRUE)
                       error_msg    <- "when 'selection_mode' is 'single', only first value of 'pre_selected_rows' will be used"
                       expect_true(grepl(error_msg,  server_error))
                       expect_false(grepl('"defaultSelected"', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - file_name_root and download_data_fxns", {
    testServer(downloadableReactTable,
                   args = list(table_data         = get_mtcars_data,
                               download_data_fxns = list(csv = get_mtcars_data),
                               file_name_root     = "test"),
                   expr = {
                       expect_true(grepl(paste0(names(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
               })

    testServer(downloadableReactTable,
                   args = list(table_data         = get_mtcars_data,
                               download_data_fxns = list(csv = get_mtcars_data),
                               file_name_root     = reactiveVal("test")),
                   expr = {
                       expect_true(grepl(paste0(names(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
               })

    testServer(downloadableReactTable,
                   args = list(table_data         = get_mtcars_data,
                               download_data_fxns = list(csv = get_mtcars_data),
                               file_name_root     = function() { "test" }),
                   expr = {
                       expect_true(grepl(paste0(names(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
               })

    server_warning <- capture_output(testServer(downloadableReactTable,
                   args = list(table_data         = function() { "test" },
                               download_data_fxns = list(csv = get_mtcars_data),
                               file_name_root     = NULL),
                   expr = {
                       expect_true(grepl(paste0(names(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
               }), print = TRUE)

    warn_msg <- "file_name_root' parameter should not be NULL. Setting default value 'data_file'"
    expect_true(grepl(warn_msg, server_warning))
})


test_that("downloadableReactTable - table_options", {
    testServer(downloadableReactTable,
               args = list(table_data    = function() { "test" },
                           table_options = list(showSortable = TRUE)),
               expr = {
                   expect_true(grepl('"showSortable":true', output$reactTableOutputID))
    })

    testServer(downloadableReactTable,
                   args = list(table_data    = function() { "test" },
                               table_options = list("unnamed_option")),
                   expr = {
                       server_warning <- capture_output(output$reactTableOutputID, print = TRUE)
                       warn_msg       <- "Excluding the following unnamed option(s): unnamed_option"
                       expect_true(grepl(warn_msg, server_warning, fixed = TRUE))
    })

    testServer(downloadableReactTable,
                   args = list(table_data    = function() { "test" },
                               table_options = list(not_valid = "option")),
                   expr = {
                       server_warning <- capture_output(output$reactTableOutputID, print = TRUE)
                       warn_msg       <- "Excluding the following invalid option(s): not_valid"
                       expect_true(grepl(warn_msg, server_warning, fixed = TRUE))
    })

    server_warning <- capture_output(testServer(
        downloadableReactTable,
        args = list(table_data    = function() { "test" },
                    table_options = list(invalid      = "option",
                                         showSortable = TRUE,
                                         invalid_2    = "option2",
                                         "unnamed_option")),
        expr = {
            expect_true(grepl('"showSortable":true', output$reactTableOutputID))
    }), print = TRUE)

    warn_msg1 <- "Excluding the following unnamed option(s): unnamed_option"
    warn_msg2 <- "Excluding the following invalid option(s): invalid, invalid_2"

    expect_true(grepl(warn_msg1, server_warning, fixed = TRUE))
    expect_true(grepl(warn_msg2, server_warning, fixed = TRUE))

})


test_that("downloadableReactTable - module return", {
    skip_if(getRversion() < "4.1.0", "Skipping due to lifecycle warnings in R < 4.1.0")
    local_mocked_bindings(
        getReactableState = function(...) {
         list(showSortable    = TRUE,
              defaultSelected = c(2, 3),
              selected        = c(2, 3))
        },
        .package = "reactable")

    testServer(
        downloadableReactTable,
        args = list(table_data = function() { "test" }),
        expr = {
            result <- session$returned()
            expect_equal(length(result), 2)
            expect_true(all(c("selected_rows", "table_state") %in% names(result)))
            expect_true(is.null(result$selected_rows))
   })

    local_mocked_bindings(
        getReactableState = function(...) {
         list(data            = get_mtcars_data(),
              showSortable    = TRUE,
              defaultSelected = c(2, 3),
              selected        = c(2, 3))
        },
        .package = "reactable")


    testServer(
        downloadableReactTable,
        args = list(table_data = get_mtcars_data),
        expr = {
            result <- session$returned()
            expect_equal(length(result), 2)
            expect_true(all(c("selected_rows", "table_state") %in% names(result)))
            expect_true(NROW(result$selected_rows) == 2)
            expect_true(all(c("Mazda RX4 Wag", "Datsun 710") %in%  rownames(result$selected_rows)))
  })

})


