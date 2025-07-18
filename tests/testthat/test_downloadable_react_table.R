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
