context("periscope2 - package addins")
local_edition(3)

test_that("theme builder addin - UI", {
    ui_output <- periscope2:::themeBuilder_addin_UI()
    expect_snapshot()
})

test_that("announcement addin - UI", {
    ui_output <- announcement_addin_UI()
    expect_true(grepl(Sys.Date(), ui_output, fixed = TRUE))
    expect_true(grepl("startPicker", ui_output, fixed = TRUE))
    expect_true(grepl("endPicker", ui_output, fixed = TRUE))
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

                   session$setInputs(startPicker       = "2023-10-29",
                                     endPicker         = "2023-10-28")
                   announce <- yaml::read_yaml(output$downloadConfig)
                   expect_equal(announce[["start_date"]], "2023-10-29")
                   # the value is updated in live app to "2023-10-29",
                   # but it has this value for limited unit test capabilities
                   expect_equal(announce[["end_date"]], "2023-10-28")

                   session$setInputs(done = 1)
               })

    testServer(announcement_addin_server,
               expr = {
                   expect_warning(session$setInputs(cancel = 1))
               })
})
