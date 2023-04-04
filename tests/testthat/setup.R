require(testthat)
require(shiny)
require(bs4Dash)
require(periscope2)
require(ggplot2)

if (interactive()) {
    test_source_path <- "periscope2/R"
    invisible(
        lapply(list.files(test_source_path),
               FUN = function(x) source(file.path(test_source_path, x))))
    rm(test_source_path)
}
