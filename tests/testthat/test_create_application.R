context("periscope2 create new application")

expect_cleanup_create_new_application <- function(full_name,
                                                  sample_app    = FALSE,
                                                  left_sidebar  = TRUE,
                                                  right_sidebar = FALSE) {
    expect_true(dir.exists(full_name))
    expect_true(file.exists(paste0(full_name, "/global.R")))
    expect_true(file.exists(paste0(full_name, "/server.R")))
    expect_true(file.exists(paste0(full_name, "/ui.R")))
    expect_true(dir.exists(paste0(full_name, "/www")))
    expect_true(file.exists(paste0(full_name, "/www/css/custom.css")))
    expect_true(file.exists(paste0(full_name, "/www/js/custom.js")))
    expect_true(file.exists(paste0(full_name, "/www/periscope_style.yaml")))
    expect_true(dir.exists(paste0(full_name, "/www/img")))
    expect_true(file.exists(paste0(full_name, "/www/img/loader.gif")))
    expect_true(file.exists(paste0(full_name, "/www/img/tooltip.png")))
    expect_true(dir.exists(paste0(full_name, "/program")))
    expect_true(file.exists(paste0(full_name, "/program/global.R")))
    expect_true(file.exists(paste0(full_name, "/program/server_global.R")))
    expect_true(file.exists(paste0(full_name, "/program/server_local.R")))
    expect_true(file.exists(paste0(full_name, "/program/ui_body.R")))
    expect_true(file.exists(paste0(full_name, "/program/ui_header.R")))
    expect_true(file.exists(paste0(full_name, "/program/ui_footer.R")))
    expect_true(dir.exists(paste0(full_name, "/program/data")))
    expect_true(dir.exists(paste0(full_name, "/program/fxn")))
    expect_true(file.exists(paste0(full_name, "/program/config/announce.yaml")))
    expect_true(dir.exists(paste0(full_name, "/program/modules")))
    expect_true(dir.exists(paste0(full_name, "/log")))

    if (left_sidebar) {
        expect_true(file.exists(paste0(full_name, "/program/ui_left_sidebar.R")))
    } else {
        expect_true(!file.exists(paste0(full_name, "/program/ui_left_sidebar.R")))
    }

    if (right_sidebar) {
        expect_true(file.exists(paste0(full_name, "/program/ui_right_sidebar.R")))
    } else {
        expect_true(!file.exists(paste0(full_name, "/program/ui_right_sidebar.R")))
    }

    if (sample_app) {
        expect_true(file.exists(paste0(full_name, "/program/data/example.csv")))
        expect_true(file.exists(paste0(full_name, "/program/data/struc_indx.csv")))
        expect_true(file.exists(paste0(full_name, "/program/data/structure.csv")))
        expect_true(file.exists(paste0(full_name, "/program/fxn/program_helpers.R")))
        expect_true(file.exists(paste0(full_name, "/program/fxn/plots.R")))
    }

    # clean up
    unlink(full_name, TRUE)
}

test_that("create_application empty full app", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name          = appTemp_name,
                                                        location      = appTemp_dir,
                                                        sample_app    = FALSE,
                                                        right_sidebar = TRUE))$message

    expect_equal(create_app_msg,
                 paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name     = appTemp,
                                          right_sidebar = TRUE)
})

test_that("create_application sample", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name       = appTemp_name,
                                                         location   = appTemp_dir,
                                                         sample_app = TRUE))$message

    expect_equal(create_app_msg,
                 paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name  = appTemp,
                                          sample_app = TRUE)
})

test_that("create_application sample full app", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name          = appTemp_name,
                                                         location      = appTemp_dir,
                                                         sample_app    = TRUE,
                                                         right_sidebar = TRUE))$message

    expect_equal(create_app_msg,
                   paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name     = appTemp,
                                          sample_app    = TRUE,
                                          right_sidebar = TRUE)
})

test_that("create_application sample right_sidebar without left_sidebar", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name          = appTemp_name,
                                                         location      = appTemp_dir,
                                                         sample_app    = TRUE,
                                                         right_sidebar = TRUE,
                                                         left_sidebar  = FALSE))$message

    expect_equal(create_app_msg,
                 paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name     = appTemp,
                                          sample_app    = TRUE,
                                          right_sidebar = TRUE,
                                          left_sidebar  = FALSE)
})

test_that("create_application sample without bars", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name          = appTemp_name,
                                                         location      = appTemp_dir,
                                                         sample_app    = TRUE,
                                                         left_sidebar  = FALSE))$message

    expect_equal(create_app_msg,
                 paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name     = appTemp,
                                          sample_app    = TRUE,
                                          left_sidebar  = FALSE)
})

test_that("create_application empty app without bars", {
    appTemp_dir    <- tempdir()
    appTemp        <- tempfile(pattern = "TestThatApp", tmpdir = appTemp_dir)
    appTemp_name   <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    create_app_msg <- capture_message(create_application(name          = appTemp_name,
                                                         location      = appTemp_dir,
                                                         sample_app    = FALSE,
                                                         left_sidebar  = FALSE))$message

    expect_equal(create_app_msg,
                 paste0("periscope2 application ", appTemp_name, " was created successfully at ", appTemp_dir, "\n"))
    expect_cleanup_create_new_application(full_name     = appTemp,
                                          sample_app    = FALSE,
                                          left_sidebar  = FALSE)
})

test_that("create_application invalid name", {
    expect_error(create_application(location = tempfile(), sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application name")
    expect_error(create_application(name = NULL, location = tempfile(), sample_app = FALSE),
                   "Framework creation could not proceed, please provide valid character application name")
    expect_error(create_application(name = "", location = tempfile(), sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application name")
    expect_error(create_application(name = 123, location = tempfile(), sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application name")
    expect_error(create_application(name = NA, location = tempfile(), sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application name")
})

test_that("create_application invalid location", {
    expect_error(create_application(name = "Invalid", location = NULL, sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application location")
    expect_error(create_application(name = "Invalid", sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application location")
    expect_error(create_application(name = "Invalid", location = "", sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application location")
    expect_error(create_application(name = "Invalid", location = NA, sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application location")
    expect_error(create_application(name = "Invalid", location = 123, sample_app = FALSE),
                 "Framework creation could not proceed, please provide valid character application location")
    expect_error(create_application(name = "Invalid", location = "invalid", sample_app = FALSE),
                 "Framework creation could not proceed, path=<invalid> does not exists!")
    appTemp_dir <- tempdir()
    test_folder <- paste0(appTemp_dir, "/", "testFolder")
    dir.create(path = test_folder)
    expect_true(assertthat::is.writeable(test_folder))
    Sys.chmod(test_folder, mode = "0000", use_umask = FALSE)
    system(paste("chmod 000",  test_folder))
    expect_false(assertthat::is.writeable(test_folder))

    # expect_error(create_application(name = "Invalid", location = appTemp_dir, sample_app = FALSE),
    #              regexp = "(is not writeable)")
    # unlink(paste0(appTemp_dir, "/", "testFolder"))
    # unlink(appTemp_dir)

})

test_that("create_application existing location", {
    appTemp_dir  <- tempdir()
    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))

    create_application(name = appTemp_name, location = appTemp_dir, sample_app = FALSE)
    create_error_msg <- capture_message(create_application(name = appTemp_name, location = appTemp_dir, sample_app = FALSE))$message

    expect_equal(create_error_msg,
                 paste0("Framework creation could not proceed, path=<", appTemp_dir, .Platform$file.sep, appTemp_name,"> already exists!"))

    expect_cleanup_create_new_application(appTemp)
})

test_that("create_application invalid sample app", {
    appTemp_dir <- tempdir()

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, sample_app = "FALSE"),
                   "'sample_app' must have valid boolean value. Setting 'sample_app' to default value 'FALSE'")
    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, sample_app = NULL),
                   "'sample_app' must have valid boolean value. Setting 'sample_app' to default value 'FALSE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, sample_app = NA),
                   "'sample_app' must have valid boolean value. Setting 'sample_app' to default value 'FALSE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, sample_app = 123),
                   "'sample_app' must have valid boolean value. Setting 'sample_app' to default value 'FALSE'")
    expect_cleanup_create_new_application(appTemp)
})

test_that("create_application invalid left sidebar", {
    appTemp_dir <- tempdir()

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, left_sidebar = "FALSE"),
                   "'left_sidebar' must have valid boolean value. Setting 'left_sidebar' to default value 'TRUE'")
    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, left_sidebar = NULL),
                   "'left_sidebar' must have valid boolean value. Setting 'left_sidebar' to default value 'TRUE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, left_sidebar = NA),
                   "'left_sidebar' must have valid boolean value. Setting 'left_sidebar' to default value 'TRUE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, left_sidebar = 123),
                   "'left_sidebar' must have valid boolean value. Setting 'left_sidebar' to default value 'TRUE'")
    expect_cleanup_create_new_application(appTemp)
})

test_that("create_application invalid right sidebar", {
    appTemp_dir <- tempdir()

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, right_sidebar = "FALSE"),
                   "'right_sidebar' must have valid boolean value. Setting 'right_sidebar' to default value 'FALSE'")
    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, right_sidebar = NULL),
                   "'right_sidebar' must have valid boolean value. Setting 'right_sidebar' to default value 'FALSE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, right_sidebar = NA),
                   "'right_sidebar' must have valid boolean value. Setting 'right_sidebar' to default value 'FALSE'")

    appTemp      <- tempfile(pattern = "InvalidApp", tmpdir = appTemp_dir)
    appTemp_name <- gsub('\\\\|/', '', (gsub(appTemp_dir, "", appTemp, fixed = TRUE)))
    expect_warning(create_application(name = appTemp_name, location = appTemp_dir, right_sidebar = 123),
                   "'right_sidebar' must have valid boolean value. Setting 'right_sidebar' to default value 'FALSE'")
    expect_cleanup_create_new_application(appTemp)
})
