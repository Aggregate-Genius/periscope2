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

# UI Testing
test_that("downloadFileButton", {
    expect_snapshot_output(downloadFileButton(id            = "myid",
                                              downloadtypes = c("csv"),
                                              hovertext     = "myhovertext"))
})

test_that("downloadFileButton multiple types", {
    expect_snapshot_output(downloadFileButton(id            = "myid",
                                              downloadtypes = c("csv", "tsv"),
                                              hovertext     = "myhovertext"))
})

test_that("downloadFileButton invalid type", {
    expect_snapshot_output(downloadFileButton(id            = "myid",
                                              downloadtypes = c("sv"),
                                              hovertext     = "myhovertext"))
})

# Server Testing
test_that("downloadFile_ValidateTypes invalid", {
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
                           datafxns     = list(txt = function() {"123"})),
               expr = {
                   expect_snapshot_file(output$txt)
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

test_that("downloadFile - unknown type", {
    ui <- fluidPage(downloadFileButton("objecid",
                                       downloadtypes = c("sv"),
                                       hovertext     = "Button 2 Tooltip"))
    server <- function(input, output, session) {
        downloadFile("objecid",
                     logger       = periscope2:::fw_get_user_log(),
                     filenameroot = "sv",
                     datafxns     = list(txt = function() {"data"}))
    }

    app <- shinytest::ShinyDriver$new(shinyApp(ui, server))
    app$click("objecid-sv")
    print(app$getValue("objecid-sv"))
})
