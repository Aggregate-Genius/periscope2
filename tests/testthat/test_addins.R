context("periscope2 - package addins")
local_edition(3)

test_that("create alert - announcement addin", {
    expect_snapshot_output(announcement_addin_UI())
})
