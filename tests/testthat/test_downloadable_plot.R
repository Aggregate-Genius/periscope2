# context("periscope2 - downloadablePlot")
#
# test_that("downloadablePlotUI - default values", {
#     plot_ui <- downloadablePlotUI(id = "myid")
#     expect_equal(length(plot_ui), 2)
#     expect_true(grepl('id="myid-dplotOutputID"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('style="width:100%;height:400px;"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonDiv"', plot_ui[[2]], fixed = TRUE))
#     expect_false(grepl('title="myhovertext"', plot_ui[[2]], fixed = TRUE))
#     expect_true(grepl('"myid-dplotButtonID-png"', plot_ui[[2]], fixed = TRUE))
# })
#
# test_that("downloadablePlotUI - no downloadable types", {
#     plot_ui <- downloadablePlotUI(id            = "myid",
#                                   downloadtypes = NULL)
#     expect_equal(length(plot_ui), 2)
#     expect_true(grepl('id="myid-dplotOutputID"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('style="width:100%;height:400px;"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonDiv"', plot_ui[[2]], fixed = TRUE))
#     expect_false(grepl('title="myhovertext"', plot_ui[[2]], fixed = TRUE))
#     expect_false(grepl('"myid-dplotButtonID"', plot_ui[[2]], fixed = TRUE))
# })
#
# test_that("downloadablePlotUI btn_overlap=true btn_halign=left btn_valign=bottom", {
#     plot_ui <- downloadablePlotUI(id                 = "myid",
#                                   downloadtypes      = c("png"),
#                                   download_hovertext = "myhovertext",
#                                   width              = "80%",
#                                   height             = "300px",
#                                   btn_halign         = "left",
#                                   btn_valign         = "bottom",
#                                   btn_overlap        = TRUE,
#                                   clickOpts          = NULL,
#                                   hoverOpts          = NULL,
#                                   brushOpts          = NULL)
#     expect_equal(length(plot_ui), 2)
#     expect_true(grepl('id="myid-dplotOutputID"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('style="width:80%;height:300px;"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonDiv"', plot_ui[[2]], fixed = TRUE))
#     expect_true(grepl('title="myhovertext"', plot_ui[[2]], fixed = TRUE))
#     expect_true(grepl('"myid-dplotButtonID-png"', plot_ui[[2]], fixed = TRUE))
# })
#
# test_that("downloadablePlotUI btn_overlap=false btn_halign=center btn_valign=top", {
#     plot_ui <- downloadablePlotUI(id                 = "myid",
#                                   downloadtypes      = c("png"),
#                                   download_hovertext = "myhovertext",
#                                   width              = "80%",
#                                   height             = "300px",
#                                   btn_halign         = "center",
#                                   btn_valign         = "top",
#                                   btn_overlap        = FALSE,
#                                   clickOpts          = NULL,
#                                   hoverOpts          = NULL,
#                                   brushOpts          = NULL)
#     expect_equal(length(plot_ui), 2)
#     expect_true(grepl('id="myid-dplotButtonDiv"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('style="display:inherit; padding: 5px;float:none;margin-left:45%;top: -5px"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonID-png"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('title="myhovertext"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotOutputID"', plot_ui[[2]], fixed = TRUE))
# })
#
# test_that("downloadablePlotUI invalid btn_halign", {
#     expect_warning(downloadablePlotUI(id                 = "myid",
#                                       downloadtypes      = c("png"),
#                                       download_hovertext = "myhovertext",
#                                       width              = "80%",
#                                       height             = "300px",
#                                       btn_halign         = "bottom",
#                                       btn_valign         = "top",
#                                       btn_overlap        = FALSE,
#                                       clickOpts          = NULL,
#                                       hoverOpts          = NULL,
#                                       brushOpts          = NULL),
#                    "bottom  is not a valid btn_halign input - using default value. Valid values: <'left', 'center', 'right'>")
# })
#
# test_that("downloadablePlotUI invalid btn_valign", {
#     download_warnings <- capture_warnings(plot_ui <- downloadablePlotUI(id                 = "myid",
#                                                                         downloadtypes      = c("png"),
#                                                                         download_hovertext = "myhovertext",
#                                                                         width              = "80%",
#                                                                         height             = "300px",
#                                                                         btn_halign         = "bottom",
#                                                                         btn_valign         = "center",
#                                                                         btn_overlap        = FALSE,
#                                                                         clickOpts          = NULL,
#                                                                         hoverOpts          = NULL,
#                                                                         brushOpts          = NULL))
#     expect_equal(length(download_warnings), 2)
#     expect_equal("bottom  is not a valid btn_halign input - using default value. Valid values: <'left', 'center', 'right'>",
#                  download_warnings[1])
#     expect_equal("center  is not a valid btn_valign input - using default value. Valid values: <'top', 'bottom'>",
#                  download_warnings[2])
#     expect_equal(length(plot_ui), 2)
#     expect_true(grepl('id="myid-dplotOutputID"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('style="width:80%;height:300px;"', plot_ui[[1]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonDiv"', plot_ui[[2]], fixed = TRUE))
#     expect_true(grepl('title="myhovertext"', plot_ui[[2]], fixed = TRUE))
#     expect_true(grepl('id="myid-dplotButtonID-png"', plot_ui[[2]], fixed = TRUE))
# })
#
#
# download_plot <- function() {
#     ggplot2::ggplot(data = download_data(), aes(x = wt, y = mpg)) +
#         geom_point(aes(color = cyl)) +
#         theme(legend.justification   = c(1, 1),
#               legend.position.inside = c(1, 1),
#               legend.title           = element_blank()) +
#         ggtitle("GGPlot Example w/Hover") +
#         xlab("wt") +
#         ylab("mpg")
# }
#
# download_data <- function() {
#     head(mtcars)
# }
#
# test_that("downloadablePlot", {
#     testServer(downloadablePlot,
#                args = list(logger = periscope2:::fw_get_user_log(),
#                            filenameroot = "mydownload1",
#                            aspectratio  = 2,
#                            downloadfxns = list(png  = download_plot,
#                                                png2 = download_plot,
#                                                tiff = download_plot,
#                                                txt  = download_data,
#                                                tsv  = download_data),
#                            visibleplot  = download_plot),
#                expr = {
#                    session$setInputs(visibleplot = download_plot)
#                    session$setInputs(downloadfxns = list(png  = download_plot,
#                                                          png2 = download_plot,
#                                                          tiff = download_plot,
#                                                          txt  = download_data,
#                                                          tsv  = download_data))
#                    expect_equal(output$dplotOutputID$width, 600)
#                })
# })
#
#
# test_that("downloadablePlot- default values", {
#     testServer(downloadablePlot,
#                args = list(visibleplot = download_plot),
#                expr = {
#                    session$setInputs(visibleplot = download_plot)
#                    expect_equal(output$dplotOutputID$width, 600)
#                })
# })
