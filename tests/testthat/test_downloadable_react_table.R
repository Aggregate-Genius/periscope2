context("periscope2 - downloadable react table")
local_edition(3)

test_that("downloadableReactTableUI", {
    table_ui <- downloadableReactTableUI(id            = "myid",
                                         downloadtypes = c("csv"),
                                         hovertext     = "myHoverText")
    expect_equal(length(table_ui), 4)
    expect_true(grepl('id="myid-reactTableButtonDiv"', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('title="myHoverText"', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="myid-reactTableButtonID-csv"', table_ui[[1]], fixed = TRUE))
    expect_false(grepl('style="display:none">', table_ui[[1]], fixed = TRUE))
    expect_true(grepl('id="myid-reactTableOutputID"', table_ui[[2]], fixed = TRUE))
})

test_that("downloadableReactTableUI - no download types", {
    table_ui <- downloadableReactTableUI(id = "myid2")
    expect_equal(length(table_ui), 4)
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
                   expect_true(grepl(paste0(rownames(get_mtcars_data()), collapse = "|"), output$reactTableOutputID))
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
    testServer(downloadableReactTable,
               args = list(table_data = NULL),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })
    testServer(downloadableReactTable,
               args = list(table_data = data.frame()),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = function() { NULL }),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = function() { data.frame() }),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })
})


test_that("downloadableReactTable - single values", {
    testServer(downloadableReactTable,
               args = list(table_data = 5),
               expr = {
                   expect_true(grepl('"x":null', output$reactTableOutputID, fixed = TRUE))
               })

    testServer(downloadableReactTable,
               args = list(table_data = function() {5}),
               expr = {
                   expect_true(grepl('"table_data..":[5]', output$reactTableOutputID, fixed = TRUE))
               })
})
