context("periscope2 optional dependencies")

test_that(".missing_packages returns only the packages that are not installed", {
    expect_equal(.missing_packages(c("shiny", "periscope2NotInstalledPackage")), "periscope2NotInstalledPackage")
    expect_length(.missing_packages(c("shiny", "methods")), 0)
})

test_that("downloadableTable stops with an install message when DT is not installed", {
    local_mocked_bindings(.missing_packages = function(packages) packages)
    dt_missing_error <- "Package 'DT' is required to use the downloadableTable module. Install it with: install.packages(\"DT\")"

    expect_error(downloadableTableUI("myid", c("csv")), dt_missing_error, fixed = TRUE)
    expect_error(downloadableTable(id = "myid", tabledata = function() { mtcars }), dt_missing_error, fixed = TRUE)
})

test_that("create_application warns about missing sample application packages", {
    local_mocked_bindings(.missing_packages = function(packages) intersect(packages, c("DT", "waiter")))
    app_dir  <- tempfile(pattern = "OptionalDepsApp")
    dir.create(app_dir)
    on.exit(unlink(app_dir, recursive = TRUE), add = TRUE)

    expect_warning(
        suppressMessages(create_application(name = "sampleapp", location = app_dir, sample_app = TRUE)),
        "The sample application needs the following package(s) that are not installed: DT, waiter. Install them with: install.packages(c(\"DT\", \"waiter\"))",
        fixed = TRUE)
    expect_true(dir.exists(file.path(app_dir, "sampleapp")))
})

test_that("create_application does not check sample application packages for an empty application", {
    local_mocked_bindings(.missing_packages = function(packages) packages)
    app_dir <- tempfile(pattern = "OptionalDepsApp")
    dir.create(app_dir)
    on.exit(unlink(app_dir, recursive = TRUE), add = TRUE)

    expect_no_warning(suppressMessages(create_application(name = "emptyapp", location = app_dir, sample_app = FALSE)))
})
