# FRAMEWORK HELPER FUNCTIONS -------
# -- (INTERNAL ONLY - No Exports) --
# .g_opts --------------------
# holds the app options values
.g_opts <- shiny::reactiveValues(
    tt_image           = "img/tooltip.png",
    tt_height          = "16px",
    tt_width           = "16px",
    datetime.fmt       = "%m-%d-%Y %H:%M",
    log.formatter      = function(record) { paste0(record$logger,
                                                   " [", record$timestamp, "] ",
                                                   record$msg) },
    loglevel            = "DEBUG",
    app_title           = "Set using add_ui_header() in program/ui_header.R",
    app_info            = NULL,
    app_version         = "1.0.0",
    loading_indicator   = NULL,
    announcements_file  = NULL,
    data_download_types = c("csv", "xlsx", "tsv", "txt"),
    plot_download_types = c("png", "jpeg", "tiff", "bmp"),
    left_sidebar        = list(disable = TRUE),
    body_elements       = c(),
    header              = NULL,
    right_sidebar       = NULL,
    footer              = NULL)


# Server ----------------------------

# Sets up the logging functionality including archiving out any existing log
# and attaching the file handler.  DEBUG will also attach a console handler.
# NOTE: only one previous log is kept (as <name>.loglast)
.setupUserLogging <- function(logger) {
    logdir    <- "log"
    logfile   <- paste0(paste(logdir, logger$name, sep = .Platform$file.sep),
                        ".log")
    formatter <- .g_opts$log.formatter
    loglevel  <- .g_opts$loglevel

    if (!dir.exists(logdir)) {
        dir.create(logdir)
    }

    if (file.exists(logfile)) {
        # archive out for now, keeping only one for now
        file.rename(logfile, paste(logfile, "last", sep = "."))
    }

    file.create(logfile)

    addHandler(writeToFile,
               file      = logfile,
               level     = loglevel,
               logger    = logger,
               formatter = formatter)

    if (loglevel == "DEBUG") {
        addHandler(writeToConsole,
                   level     = loglevel,
                   logger    = logger,
                   formatter = formatter)
    }

    logfile
}


.setup_logging <- function(session, logger) {
    shiny::reactiveFileReader(
        500, #milliseconds,
        session,
        .setupUserLogging(logger),
        readLines)
}
