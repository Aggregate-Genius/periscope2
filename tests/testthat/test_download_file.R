context("periscope2 - download file")
local_edition(3)

# helper functions
download_plot <- function() {
    ggplot2::ggplot(data = mtcars, aes(x = wt, y = mpg)) +
        geom_point(aes(color = cyl)) +
        theme(legend.justification = c(1, 1),
              legend.position      = c(1, 1),
              legend.title         = element_blank()) +
        ggtitle("GGPlot Example w/Hover") +
        xlab("wt") +
        ylab("mpg")
}

download_lattice_plot <- function() {
    lattice::xyplot(Sepal.Length ~ Petal.Length, data = head(iris))
}

download_data <- function() {
    head(mtcars)
}

download_data_show_row_names <- function() {
    attr(mtcars, "show_rownames") <-  TRUE
    head(mtcars)
}

download_string_list <- function() {
    c("test1", "test2", "tests")
}

download_char_data <- function() {
    "A123B"
}

# UI Testing
test_that("downloadFileButton", {
    file_btn <- downloadFileButton(id            = "myid",
                                   downloadtypes = c("csv"),
                                   hovertext     = "myhovertext")
    expect_true(grepl('title="myhovertext"', file_btn, fixed = TRUE))
    expect_true(grepl('id="myid-csv"', file_btn, fixed = TRUE))
})

test_that("downloadFileButton - no download type", {
    file_btn <- downloadFileButton(id            = "myid2",
                                   downloadtypes = NULL,
                                   hovertext     = "myhovertext")
    expect_equal(file_btn, "")
})

test_that("downloadFileButton multiple types", {
    file_btn <- downloadFileButton(id            = "myid",
                                   downloadtypes = c("csv", "tsv"),
                                   hovertext     = "myhovertext")
    expect_true(grepl('class="btn-group"', file_btn, fixed = TRUE))
    expect_true(grepl('myid-downloadFileList"', file_btn, fixed = TRUE))
    expect_true(grepl('id="myid-csv"', file_btn, fixed = TRUE))
    expect_true(grepl('id="myid-tsv"', file_btn, fixed = TRUE))
})

test_that("downloadFileButton invalid type", {
    file_btn <- downloadFileButton(id            = "myid",
                                   downloadtypes = c("sv"),
                                   hovertext     = "myhovertext")
    expect_true(grepl('title="myhovertext"', file_btn, fixed = TRUE))
    expect_true(grepl('id="myid-sv"', file_btn, fixed = TRUE))
})

# Server Testing
test_that("downloadFile_ValidateTypes valid", {
    result <- downloadFile_ValidateTypes(types = "csv")

    expect_equal(result, "csv")
})

test_that("downloadFile_ValidateTypes invalid", {
    expect_warning(downloadFile_ValidateTypes(types = "csv_invalid"),
                   "file download list contains an invalid type <csv_invalid>")
})

test_that("downloadFile_AvailableTypes", {
    result <- downloadFile_AvailableTypes()

    expect_equal(result, c("csv", "xlsx", "tsv", "txt", "png", "jpeg", "tiff", "bmp"))
})

test_that("downloadFile - all download types", {
    testServer(downloadFile,
               args = list(logger       = periscope2:::fw_get_user_log(),
                           filenameroot = "mydownload1",
                           datafxns     = list(csv   = download_data,
                                               xlsx  = download_data,
                                               tsv   = download_data,
                                               txt   = download_data,
                                               png   = download_plot,
                                               jpeg  = download_plot,
                                               tiff  = download_plot,
                                               bmp   = download_plot)),
               expr = {
                   expect_snapshot_file(output$csv)
                   expect_snapshot_file(output$tsv)
                   expect_snapshot_file(output$txt)
                   expect_true(file.exists(output$xlsx))
                   expect_true(file.exists(output$png))
                   expect_true(file.exists(output$jpeg))
                   expect_true(file.exists(output$tiff))
                   expect_true(file.exists(output$bmp))
               })

})

test_that("downloadFile - lattice plot", {
    testServer(downloadFile,
               args = list(logger       = periscope2:::fw_get_user_log(),
                           filenameroot = "mydownload1",
                           datafxns     = list(png   = download_lattice_plot,
                                               jpeg  = download_lattice_plot,
                                               tiff  = download_plot,
                                               bmp   = download_lattice_plot)),
               expr = {
                   expect_true(file.exists(output$png))
                   expect_true(file.exists(output$jpeg))
                   expect_true(file.exists(output$tiff))
                   expect_true(file.exists(output$bmp))
               })

})


test_that("downloadFile - show rownames", {
    testServer(downloadFile,
               args = list(logger       = periscope2:::fw_get_user_log(),
                           filenameroot = "show_row_names_download",
                           datafxns     = list(csv = download_data_show_row_names)),
               expr = {
                   expect_snapshot_file(output$csv)
               })
})

test_that("downloadFile - download char data", {
    testServer(downloadFile,
               args = list(logger       = periscope2:::fw_get_user_log(),
                           filenameroot = "my_char_download",
                           datafxns     = list(txt = download_char_data,
                                               tsv = download_char_data,
                                               csv = download_char_data)),
               expr = {
                   expect_snapshot_file(output$txt)
                   expect_snapshot_file(output$tsv)
                   expect_snapshot_file(output$csv)
               })
})

test_that("downloadFile - download txt numeric data", {
    testServer(downloadFile,
               args = list(logger       = periscope2:::fw_get_user_log(),
                           filenameroot = "my_numeric_data",
                           datafxns     = list(txt = function() {123})),
               expr = {
                   expect_warning(output$txt, "txt could not be processed")
               })
})

test_that("downloadFile - default values", {
    testServer(downloadFile,
               args = list(datafxns = list(txt = function() {"123"})),
               expr = {
                   expect_snapshot_file(output$txt)
               })
})

test_that("downloadFile - invalid type", {
    testServer(downloadFile,
               args = list(datafxns = list(ttt = function() {"123"},
                                           jeg = download_lattice_plot,
                                           tff = download_plot)),
               expr = {
                   expect_error(output$ttt)
                   expect_error(output$jeg)
                   expect_error(output$tff)
               })
})
