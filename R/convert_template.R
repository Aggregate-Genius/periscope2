# Conversion functions for existing applications.


ui_filename <- "ui.R"


# Checks if the location contains a periscope application by checking mandatory structure
.is_periscope_app <- function(location = ".") {
    all(file.exists(file.path(location, c("server.R", "ui.R", "global.R", "program"))))
}


#' Add the left sidebar to an existing application
#'
#' User can update an existing application that does not have a left side bar and add a new empty one using this function.
#'
#' If conversion is successful, the following message will be returned
#' \emph{"Add left sidebar conversion was successful. File(s) updated: ui.R, ui_left_sidebar.R"}
#'
#' If the function called on an application with an existing left bar, message
#' \emph{"Left sidebar already available, no conversion needed"}
#' will be returned with no conversion
#'
#' If the passed location is invalid, empty, not exist or not a valid periscope2 application, nothing will be added
#' and a related error message will be printed in console
#'
#'
#' @param location path of the existing periscope2 application.
#'
#' @export
#' @seealso \link[periscope2]{create_right_sidebar}
create_left_sidebar <- function(location) {
    assertthat::assert_that(!is.null(location),
                            location != "",
                            msg = "Add left sidebar conversion could not proceed, location cannot be empty!")
    assertthat::assert_that(dir.exists(location),
                            msg = paste0("Add left sidebar conversion could not proceed, location=<", location, "> does not exist!"))
    assertthat::assert_that(.is_periscope_app(location),
                            msg = paste0("Add left sidebar conversion could not proceed, location=<",
                                         location,
                                         "> does not contain a valid periscope application!"))
    tryCatch({
        left_sidebar_file <- "ui_left_sidebar.R"
        usersep           <- .Platform$file.sep
        files_updated     <- c()
        ui_content        <- readLines(con = paste(location, ui_filename, sep = usersep))

        # update ui if needed
        if (!any(grepl("ui_left_sidebar.R", ui_content))) {
            ui_content <- gsub(pattern     = "create_application_dashboard()",
                               replacement = paste("source(paste(\"program\", \"ui_left_sidebar.R\", sep = .Platform$file.sep), local = TRUE)",
                                                   "\ncreate_application_dashboard()"),
                               x           = ui_content)


            writeLines(ui_content, con = paste(location, ui_filename, sep = usersep))

            # add left_sidebar file
            writeLines(readLines(con = system.file("fw_templ",  "p_blank", left_sidebar_file, package = "periscope2")),
                       con = paste(location, "program", left_sidebar_file, sep = usersep))

            files_updated <- c(files_updated, c(ui_filename, left_sidebar_file))
        }

        if (length(files_updated) > 0) {
            message(paste("Add left sidebar conversion was successful. File(s) updated:",  paste(files_updated, collapse = ", ")))
        } else {
            message("Left sidebar already available, no conversion needed")
        }
    },
    warning = function(w) {
        warning(w$message, call. = FALSE)
    })
}


#' Add the right sidebar to an existing application
#'
#' User can update an existing application that does not have a right side bar and add a new empty one using this function.
#'
#' If conversion is successful, the following message will be returned
#' \emph{"Add right sidebar conversion was successful. File(s) updated: ui.R, ui_right_sidebar.R"}
#'
#' If the function called on an application with an existing right bar, message
#' \emph{"Right sidebar already available, no conversion needed"}
#' will be returned with no conversion
#'
#' If the passed location is invalid, empty, not exist or not a valid periscope2 application, nothing will be added
#' and a related error message will be printed in console
#'
#'
#' @param location path of the existing periscope2 application.
#' @export
#' @seealso \link[periscope2]{create_left_sidebar}
create_right_sidebar <- function(location) {
    assertthat::assert_that(!is.null(location),
                            location != "",
                            msg = "Add right sidebar conversion could not proceed, location cannot be empty!")
    assertthat::assert_that(dir.exists(location),
                            msg = paste0("Add right sidebar conversion could not proceed, location=<", location, "> does not exist!"))
    assertthat::assert_that(.is_periscope_app(location),
                            msg = paste0("Add right sidebar conversion could not proceed, location=<",
                                         location,
                                         "> does not contain a valid periscope application!"))
    tryCatch({
        right_sidebar_file <- "ui_right_sidebar.R"
        usersep            <- .Platform$file.sep
        files_updated      <- c()
        ui_content         <- readLines(con = paste(location, ui_filename, sep = usersep))
        # update ui if needed
        if (!any(grepl("ui_right_sidebar.R", ui_content))) {
            ui_content <- gsub(pattern     = "create_application_dashboard()",
                               replacement = paste("source(paste(\"program\", \"ui_right_sidebar.R\", sep = .Platform$file.sep), local = TRUE)",
                                                   "\ncreate_application_dashboard()"),
                               x           = ui_content)
            writeLines(ui_content, con = paste(location, ui_filename, sep = usersep))

            # add right_sidebar file
            writeLines(readLines(con = system.file("fw_templ",  "p_blank", right_sidebar_file, package = "periscope2")),
                       con = paste(location, "program", right_sidebar_file, sep = usersep))

            files_updated <- c(files_updated, c(ui_filename, right_sidebar_file))
        }

        if (length(files_updated) > 0) {
            message(paste("Add right sidebar conversion was successful. File(s) updated:",  paste(files_updated, collapse = ", ")))
        } else {
            message("Right sidebar already available, no conversion needed")
        }
    },
    warning = function(w) {
        warning(w$message, call. = FALSE)
    })
}
