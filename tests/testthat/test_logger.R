context("periscope2 - logging functionality")


writeToConsole     <- periscope2:::writeToConsole
writeToFile        <- periscope2:::writeToFile
loglevels          <- periscope2:::loglevels
set_app_parameters <- periscope2::set_app_parameters
test_file_name     <- file.path(tempdir(), c("1", "2", "3"))
test_file_log      <- file.path(tempdir(), "test_log.txt")

env_setup <- function() {
    test_env        <- new.env(parent = emptyenv())
    test_env$logged <- NULL

    mock_action <- function(msg, handler, ...) {
        if (length(list(...)) && "dry" %in% names(list(...)))
            return(TRUE)
        test_env$logged <- c(test_env$logged, msg)
    }

    mock_formatter <- function(record) {
        paste(record$levelname, record$logger, record$msg, sep = ":")
    }

    periscope2:::logReset()
    periscope2:::addHandler(mock_action,
                           formatter = mock_formatter)
    test_env
}

test_that("Handlers - addHandler(), getHandler() and removeHandler()", {
    periscope2:::logReset()
    periscope2:::basicConfig()

    # looking for handler in RootLogger
    expect_identical(periscope2:::getHandler("basic.stdout"),
                     periscope2:::getLogger()[["handlers"]][[1]])
    # looking for handler in object
    expect_identical(periscope2:::getLogger()$getHandler("basic.stdout"),
                     periscope2:::getLogger()[["handlers"]][[1]])

    # add handler
    periscope2:::addHandler(writeToConsole)

    expect_equal(length(with(periscope2:::getLogger(), names(handlers))), 2)
    expect_true("writeToConsole" %in% with(periscope2:::getLogger(), names(handlers)))

    # get handler
    expect_true(!is.null(periscope2:::getHandler("writeToConsole")))
    expect_true(!is.null(periscope2:::getHandler(writeToConsole)))

    # remove handler
    periscope2:::removeHandler("writeToConsole")
    expect_equal(length(with(periscope2:::getLogger(), names(handlers))), 1)
    expect_false("writeToConsole" %in% with(periscope2:::getLogger(), names(handlers)))

    expect_error(periscope2:::addHandler("handlerName"),
                 regexp = "No action for the handler provided",
                 fixed  = TRUE)
})

test_that("Handlers in Logger object - addHandler(), getHandler() and removeHandler()", {
    periscope2:::logReset()
    periscope2:::basicConfig()

    # add handler
    log <- periscope2:::getLogger("testLogger")
    log$addHandler(writeToConsole)
    expect_equal(length(with(log, names(handlers))), 1)

    # get handler
    expect_true(!is.null(log$getHandler("writeToConsole")))
    expect_true(!is.null(log$getHandler(writeToConsole)))

    # remove handler
    log$removeHandler(writeToConsole)
    expect_equal(length(with(log, names(handlers))), 0)
    expect_false("writeToConsole" %in% with(log, names(handlers)))
})

test_that("Levels - setLevel()", {
    periscope2:::logReset()
    periscope2:::basicConfig()

    expect_error(periscope2:::setLevel("INFO", NULL),
                 regexp = "NULL container provided: cannot set level for NULL container",
                 fixed  = TRUE)

    periscope2:::logReset()
    expect_equal(periscope2:::setLevel(TRUE), loglevels["NOTSET"]) # invalid level

    periscope2:::logReset()
    expect_equal(periscope2:::setLevel("INVALID"), loglevels["NOTSET"]) # invalid level
})

test_that("Levels in Logger object- setLevel() and getLevel()", {
    periscope2:::logReset()
    log <- periscope2:::getLogger("testLogger")

    # invalid level
    log$setLevel(150)
    expect_equal(log$getLevel(), loglevels["NOTSET"])

    log$setLevel(TRUE)
    expect_equal(log$getLevel(), loglevels["NOTSET"])

    log$setLevel("INVALID")
    expect_equal(log$getLevel(), loglevels["NOTSET"])
})

test_that("UpdateOptions - updateOptions()", {
    periscope2:::logReset()
    periscope2:::basicConfig()

    periscope2:::updateOptions.character("", level = "WARN")
    expect_equal(periscope2:::getLogger()$getLevel(), loglevels["WARN"])
})

test_that("LoggingToConsole", {
    periscope2:::logReset()
    periscope2:::basicConfig()

    periscope2:::getLogger()$setLevel("FINEST")
    periscope2:::addHandler(writeToConsole, level = "DEBUG")

    expect_equal(with(periscope2:::getLogger(), names(handlers)), c("basic.stdout", "writeToConsole"))
    logdebug("log generated for testing")
    loginfo("log generated for testing")

    succeed()
})

test_that("LoggingToFile", {
    periscope2:::logReset()
    unlink(test_file_name, force = TRUE)

    periscope2:::getLogger()$setLevel("FINEST")
    periscope2:::addHandler(writeToFile, file = test_file_name[[1]], level = "DEBUG")

    expect_equal(with(periscope2:::getLogger(), names(handlers)), c("writeToFile"))
    logerror("log generated for testing")
    logwarn("log generated for testing")
    loginfo("log generated for testing")
    logdebug("log generated for testing")
    periscope2:::logfinest("log generated for testing")
    periscope2:::logfiner("log generated for testing")
    periscope2:::logfine("log generated for testing")
    periscope2:::levellog("log generated for testing")

    succeed()
})

test_that("LoggingToFile in Logger object", {
    periscope2:::logReset()
    unlink(test_file_name, force = TRUE)

    log <- periscope2:::getLogger()
    log$setLevel("FINEST")
    log$addHandler(writeToFile, file = test_file_name[[1]], level = "DEBUG")
    expect_equal(with(log, names(handlers)), c("writeToFile"))

    log$error("log generated for testing")
    log$warn("log generated for testing")
    log$info("log generated for testing")
    log$debug("log generated for testing")
    log$finest("log generated for testing")
    log$finer("log generated for testing")
    log$fine("log generated for testing")

    succeed()
})

test_that("Msgcomposer - setMsgComposer(), resetMsgComposer()", {
    env <- env_setup()

    periscope2:::setMsgComposer(function(msg, ...) { paste(msg, "comp") })
    loginfo("test")

    expect_equal(env$logged, "INFO::test comp")
    expect_error(periscope2:::setMsgComposer(function(msgX, ...) { paste(msg, "comp") }),
                 regexp = "message composer(passed as composer_f) must be function  with signature function(msg, ...)",
                 fixed = TRUE)
    expect_error(periscope2:::setMsgComposer(container = NULL),
                 regexp = "NULL container provided: cannot set message composer for NULL container")

    # reset_composer
    env <- env_setup()
    periscope2:::resetMsgComposer()
    loginfo("test")

    expect_equal(env$logged, "INFO::test")
    expect_error(periscope2:::resetMsgComposer(NULL),
                 regexp = "NULL container provided: cannot reset message composer for NULL container")

    # set_sublogger_composer
    env <- env_setup()

    periscope2:::setMsgComposer(function(msg, ...) { paste(msg, "comp") }, container = "named")
    loginfo("test")
    loginfo("test", logger = "named")

    expect_equal(env$logged, c("INFO::test", "INFO:named:test comp"))
})

test_that("MsgComposer function - defaultMsgCompose()",{
    expect_equal(periscope2:::defaultMsgCompose(msg = "Message"), "Message")
    expect_error(periscope2:::defaultMsgCompose(msg = paste(rep(LETTERS, 316), collapse = ""), param = 1),
                 "'msg' length exceeds maximal format length 8192")
    expect_equal(periscope2:::defaultMsgCompose(msg = paste(rep(LETTERS, 316), collapse = "")),
                 paste(rep(LETTERS, 316), collapse = ""))
})

# Testing logging levels
test_that("DEBUG level shows all messages", {
    set_app_parameters(log_level = "DEBUG")
    addHandler(writeToConsole)
    expect_output(logdebug("debug message"), "DEBUG::debug message")
    expect_output(loginfo("info message"),   "INFO::info message")
    expect_output(logwarn("warn message"),   "WARNING::warn message")
    expect_output(logerror("error message"), "ERROR::error message")
})
I
test_that("INFO level filters DEBUG", {
    set_app_parameters(log_level = "INFO")
    addHandler(writeToConsole)
    expect_silent(logdebug("debug message"))
    expect_output(loginfo("info message"),   "INFO::info message")
    expect_output(logwarn("warn message"),   "WARNING::warn message")
    expect_output(logerror("error message"), "ERROR::error message")
})

test_that("WARN level filters DEBUG and INFO", {
    set_app_parameters(log_level = "WARN")
    addHandler(writeToConsole)
    expect_silent(logdebug("debug message"))
    expect_silent(loginfo("info message"))
    expect_output(logwarn("warn message"),   "WARNING::warn message")
    expect_output(logerror("error message"), "ERROR::error message")
})

test_that("ERROR level filters all but ERROR", {
    set_app_parameters(log_level = "ERROR")
    addHandler(writeToConsole)
    expect_silent(logdebug("debug message"))
    expect_silent(loginfo("info message"))
    expect_silent(logwarn("warn message"))
    expect_output(logerror("error message"), "ERROR::error message")
})

test_that("File logging level DEBUG", {
    unlink(test_file_log, force  = TRUE)
    set_app_parameters(log_level = "DEBUG")
    addHandler(writeToFile, file = test_file_log)

    logdebug("debug message")
    loginfo("info message")
    logwarn("warn message")
    logerror("error message")

    log_content <- readLines(test_file_log)
    expect_true(any(grepl("debug message", log_content)))
    expect_true(any(grepl("info message",  log_content)))
    expect_true(any(grepl("warn message",  log_content)))
    expect_true(any(grepl("error message", log_content)))
})

test_that("File logging level INFO", {
    unlink(test_file_log, force  = TRUE)
    set_app_parameters(log_level = "INFO")
    addHandler(writeToFile, file = test_file_log)

    logdebug("debug message")
    loginfo("info message")
    logwarn("warn message")
    logerror("error message")

    log_content <- readLines(test_file_log)
    expect_false(any(grepl("debug message", log_content)))
    expect_true(any(grepl("info message",   log_content)))
    expect_true(any(grepl("warn message",   log_content)))
    expect_true(any(grepl("error message",  log_content)))
})

test_that("File logging level WARN", {
    unlink(test_file_log, force  = TRUE)
    set_app_parameters(log_level = "WARN")
    addHandler(writeToFile, file = test_file_log)

    logdebug("debug message")
    loginfo("info message")
    logwarn("warn message")
    logerror("error message")

    log_content <- readLines(test_file_log)
    expect_false(any(grepl("debug message", log_content)))
    expect_false(any(grepl("info message",  log_content)))
    expect_true(any(grepl("warn message",   log_content)))
    expect_true(any(grepl("error message",  log_content)))
})

test_that("File logging level ERROR", {
    unlink(test_file_log, force  = TRUE)
    set_app_parameters(log_level = "ERROR")
    addHandler(writeToFile, file = test_file_log)

    logdebug("debug message")
    loginfo("info message")
    logwarn("warn message")
    logerror("error message")

    log_content <- readLines(test_file_log)
    expect_false(any(grepl("debug message", log_content)))
    expect_false(any(grepl("info message",  log_content)))
    expect_false(any(grepl("warn message",  log_content)))
    expect_true(any(grepl("error message",  log_content)))
})
