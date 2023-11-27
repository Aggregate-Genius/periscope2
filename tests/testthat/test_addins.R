context("periscope2 - package addins")
local_edition(3)

test_that("theme builder addin - UI", {
    ui_output <- periscope2:::themeBuilder_addin_UI()
    expect_true(grepl("Status Colors", ui_output))
    expect_true(grepl("Sidebars Colors", ui_output))
    expect_true(grepl("Sidebars Layout", ui_output))
    expect_true(grepl("Main Colors", ui_output))
    expect_true(grepl("Color Contrast", ui_output))
    expect_true(grepl("Other Variables", ui_output))
    expect_true(grepl("Add Variable", ui_output))
    expect_true(grepl("Cancel", ui_output))
    expect_true(grepl("Done", ui_output))
    expect_true(grepl("Download", ui_output))
})


test_that("theme builder addin - server", {
    testServer(themeBuilder_addin_server,
               expr = {
                   session$setInputs(primary               = "#B221DD",
                                     secondary             = "#6C757D",
                                     success               = "#2ED610",
                                     info                  = "#7BDFF2",
                                     warning               = "#FFF200",
                                     danger                = "#CE0900",
                                     light                 = "#F8F9FA",
                                     dark                  = "#343A40",
                                     bg                    = "#D67E7CD1",
                                     hover_bg              = "#B0B818F7",
                                     color                 = "#CA39D4ED",
                                     hover_color           = "#000000E4",
                                     active_color          = "#BF8DF0EE",
                                     submenu_bg            = "#084D66BF",
                                     submenu_color         = "#B33634D3",
                                     submenu_hover_color   = "#0303038F",
                                     submenu_hover_bg      = "#BE25CFF2",
                                     submenu_active_color  = "#1FAB9DC2",
                                     submenu_active_bg     = "#401487E8",
                                     header_color          = "#D91F1CAF",
                                     sidebar_width         = "350",
                                     control_sidebar_width = "250",
                                     sidebar_padding_x     = "15",
                                     sidebar_padding_y     = "20",
                                     sidebar_mini_width    = "25",
                                     blue                  = "#007BFF",
                                     lightblue             = "#3C8DBC",
                                     navy                  = "#001F3F",
                                     cyan                  = "#17A2B8",
                                     teal                  = "#39CCCC",
                                     olive                 = "#3D9970",
                                     green                 = "#28A745",
                                     lime                  = "#01FF70",
                                     orange                = "#FF851B",
                                     yellow                = "#FFC107",
                                     fuchsia               = "#F012BE",
                                     purple                = "#605CA8",
                                     maroon                = "#D81B60",
                                     red                   = "#DC3545",
                                     black                 = "#111111",
                                     gray_x_light          = "#D2D6DE",
                                     gray_600              = "#6C757D",
                                     white                 = "#FFFFFF",
                                     contrasted_threshold  = "12",
                                     text_dark             = "#701110D0",
                                     text_light            = "#2F515EBA")
                   ids(2)
                   session$setInputs(addVariable = 1)
                   session$setInputs("1-variableName"  = "main-bg",
                                     "1-variableValue" = "#FFC107",
                                     "2-variableName"  = "navbar-light-color",
                                     "2-variableValue" = "#bec5cb",
                                     `1-removeVariableBtn` = 1,
                                     downloadConfig = 1)
                   expect_snapshot(yaml::read_yaml(output$downloadConfig))
                   session$setInputs(done = 1)
               }
    )

    testServer(themeBuilder_addin_server,
               expr = {
                   expect_warning(session$setInputs(cancel = 1))
               }
    )
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
