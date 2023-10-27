context("periscope2 - package addins")
local_edition(3)

test_that("announcement addin - UI", {
    ui_output <- gsub(pattern = paste0(",\"minDate\":\"", Sys.Date(), "\""), x =  announcement_addin_UI(), replacement = "")
    expect_snapshot_output(cat(ui_output))
})


test_that("announcement addin - server", {
    testServer(announcement_addin_server,
               expr = {
                   session$setInputs(startPicker       = "2023-10-27",
                                     endPicker         = "2023-10-28",
                                     announcement_text = "test body",
                                     auto_close        = 30,
                                     style             = "info",
                                     title             = "test title")
                   session$setInputs(downloadConfig = 0)
                   announce <- yaml::read_yaml(output$downloadConfig)
                   expect_equal(announce[["start_date"]], "2023-10-27")
                   expect_equal(announce[["end_date"]], "2023-10-28")
                   expect_null(announce[["start_date_format"]])
                   expect_null(announce[["end_date_format"]])
                   expect_equal(announce[["auto_close"]], 30)
                   expect_equal(announce[["style"]], "info")
                   expect_equal(announce[["title"]], "test title")
                   expect_equal(announce[["text"]], "test body")

                   session$setInputs(announcement_text = "test body2",
                                     auto_close        = 10)
                   session$setInputs(downloadConfig = 1)

                   announce <- yaml::read_yaml(output$downloadConfig)
                   expect_equal(announce[["start_date"]], "2023-10-27")
                   expect_equal(announce[["end_date"]], "2023-10-28")
                   expect_null(announce[["start_date_format"]])
                   expect_null(announce[["end_date_format"]])
                   expect_equal(announce[["auto_close"]], 10)
                   expect_equal(announce[["style"]], "info")
                   expect_equal(announce[["title"]], "test title")
                   expect_equal(announce[["text"]], "test body2")

                   session$setInputs(announcement_text = NA,
                                     auto_close        = -10)
                   session$setInputs(downloadConfig = 2)
                   announce <- yaml::read_yaml(output$downloadConfig)
                   expect_equal(announce[["text"]], "NA")
                   expect_equal(announce[["auto_close"]], -10)
                   session$setInputs(done = 1)
               })
})
