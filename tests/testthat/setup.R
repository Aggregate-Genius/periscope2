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

reset_g_opts <- function() {
  .g_opts$tt_image           <- "img/tooltip.png"
  .g_opts$tt_height          <- "16px"
  .g_opts$tt_width           <- "16px"
  .g_opts$datetime.fmt       <- "%m-%d-%Y %H:%M"
  .g_opts$log.formatter      <- function(record) { paste0(record$logger, " [", record$timestamp, "] ", record$msg) }
  .g_opts$loglevel           <- "DEBUG"
  .g_opts$app_title          <- "Set using add_ui_header() in program/ui_header.R"
  .g_opts$app_info           <- NULL
  .g_opts$app_version        <- "1.0.0"
  .g_opts$loading_indicator  <- NULL
  .g_opts$announcements_file <- NULL
  .g_opts$data_download_types <- c("csv", "xlsx", "tsv", "txt")
  .g_opts$plot_download_types <- c("png", "jpeg", "tiff", "bmp")
  .g_opts$left_sidebar       <- list(disable = TRUE)
  .g_opts$body_elements      <- c()
  .g_opts$header             <- NULL
  .g_opts$right_sidebar      <- NULL
  .g_opts$footer             <- NULL
}
