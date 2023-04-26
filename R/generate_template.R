# TEMPLATE SETUP FUNCTIONS ------

#' Create a new templated framework application
#'
#' Creates ready-to-use templated application files using the periscope2
#' framework. The application can be created either empty (default) or with a
#' sample/documented example application.\cr \cr
#'
#' @param name          - name for the new application and directory
#' @param location      - base path for creation of \code{name}
#' @param sample_app    - whether to create a sample shiny application
#' @param left_sidebar  - whether the left sidebar should be enabled. It can be TRUE/FALSE
#' @param right_sidebar - parameter to set the right sidebar. It can be TRUE/FALSE
#'
#' @section Name:
#' The \code{name} directory must not exist in \code{location}.  If the code
#' detects that this directory exists it will abort the creation process with
#' a warning and will not create an application template.
#'
#' Use only filesystem-compatible characters in the name (ideally w/o spaces)
#'
#' @section Directory Structure:
#'
#' \preformatted{
#' name
#'  -- log (log files)
#'  -- program (user application)
#'  -- -- config   (application configuration files)
#'  -- -- data     (user application data)
#'  -- -- fxn      (user application function)
#'  -- -- modules  (application modules files)
#'  -- www (supporting shiny files)
#'  -- -- css  (application css files)
#'  -- -- img  (application image files)
#'  -- -- js   (application js files)
#' }
#'
#' @section File Information:
#'
#' All user application creation and modifications will be done in
#' the \strong{program} directory.  The names & locations
#' of the framework-provided .R files should not be changed or the framework
#' will fail to work as expected. \cr
#' \cr
#' \strong{\emph{name/program/config}} directory :\cr
#' Use this location for configuration files.\cr
#' \cr
#' \strong{\emph{name/program/data}} directory :\cr
#' Use this location for data files.  There is a \strong{.gitignore} file
#' included in this directory to prevent accidental versioning of data\cr
#' \cr
#' \strong{\emph{name/program/fxn}} directory :\cr
#' Use this location for supporting and helper R files.\cr
#' \cr
#' \strong{\emph{name/program/modules}} directory :\cr
#' Use this location for application new modules files.\cr
#' \cr
#' \strong{\emph{name/program}/global.R} :\cr
#' Use this location for code that would have previously resided in global.R
#' and for setting application parameters using
#' \link[periscope2]{set_app_parameters}.  Anything placed in this file will
#' be accessible across all user sessions as well as within the UI context. \cr
#' \cr
#' \strong{\emph{name/program}/server_global.R} :\cr
#' Use this location for code that would have previously resided in server.R
#' above (i.e. outside of) the call to \code{shinyServer(...)}. Anything placed
#' in this file will be accessible across all user sessions. \cr
#' \cr
#' \strong{\emph{name/program}/server_local.R} :\cr
#' Use this location for code that would have previously resided in server.R
#' inside of the call to \code{shinyServer(...)}.  Anything placed in this
#' file will be accessible only within a single user session.\cr
#' \cr
#' \strong{\emph{name/program}/ui_body.R} :\cr
#' Create body UI elements in this file and register them with the
#' framework using a call to \link[periscope2]{add_ui_body} \cr
#' \cr
#' \strong{\emph{name/program}/ui_footer.R} :\cr
#' Create footer UI elements in this file and register them with the
#' framework using a call to \link[periscope2]{add_ui_footer} \cr
#' \cr
#' \strong{\emph{name/program}/ui_header.R} :\cr
#' Create header UI elements in this file and register them with the
#' framework using a call to \link[periscope2]{add_ui_header} \cr
#' \cr
#' \strong{\emph{name/program}/ui_left_sidebar.R} :\cr
#' Create sidebar UI elements in this file and register them with the
#' framework using a call to \link[periscope2]{add_ui_left_sidebar} \cr
#' \cr
#' \strong{\emph{name/program}/ui_right_sidebar.R} :\cr
#' Create right sidebar UI elements in this file and register them with the
#' framework using a call to \link[periscope2]{add_ui_right_sidebar} \cr
#' \cr
#' \strong{\emph{name}/www/css/custom.css} :\cr
#' This is the application custom styling css file. User can update
#' application different parts style using this file.\cr
#' \cr
#' \strong{\emph{name}/www/js/custom.js} :\cr
#' This is the application custom javascript file.\cr
#' \cr
#' \strong{\emph{name}/www/periscope_style.yaml} :\cr
#' This is the application custom styling yaml file. User can update
#' application different parts style using this file.\cr
#' \cr
#' \cr
#' \strong{Do not modify the following files}: \cr
#' \preformatted{
#' name\\global.R
#' name\\server.R
#' name\\ui.R
#' name\\www\\img\\loader.gif
#' name\\www\\img\\tooltip.png
#' }
#'
#' @seealso \link[bs4Dash:dashboardPage]{bs4Dash:dashboardPage()}
#' @seealso \link[waiter:waiter]{waiter:waiter_show()}
#'
#'@examples
#' # sample app named 'mytestapp' created in a temp dir
#' location <- tempdir()
#' create_application(name = 'mytestapp', location = location, sample_app = TRUE)
#' unlink(paste0(location,'/mytestapp'), TRUE)
#'
#' # sample app named 'mytestapp' with a right sidebar using a custom icon created in a temp dir
#' location <- tempdir()
#' create_application(name = 'mytestapp', location = location, sample_app = TRUE, right_sidebar = TRUE)
#' unlink(paste0(location,'/mytestapp'), TRUE)
#'
#' # blank app named 'myblankapp' created in a temp dir
#' location <- tempdir()
#' create_application(name = 'myblankapp', location = location)
#' unlink(paste0(location,'/myblankapp'), TRUE)
#'
#' # blank app named 'myblankapp' without a left sidebar created in a temp dir
#' location <- tempdir()
#' create_application(name = 'myblankapp', location = location, left_sidebar = FALSE)
#' unlink(paste0(location,'/myblankapp'), TRUE)
#'
#' @export
create_application <- function(name,
                               location,
                               sample_app    = FALSE,
                               left_sidebar  = TRUE,
                               right_sidebar = FALSE) {
    assertthat::assert_that(!missing(name),
                            length(name) > 0,
                            !is.na(name),
                            name != "",
                            is.character(name),
                            msg = "Framework creation could not proceed, please provide valid character application name")

    assertthat::assert_that(!missing(location),
                            length(location) > 0,
                            !is.na(location),
                            location != "",
                            is.character(location),
                            msg = "Framework creation could not proceed, please provide valid character application location")
    assertthat::assert_that(dir.exists(location),
                            msg = paste0("Framework creation could not proceed, path=<", location, "> does not exists!"))
    assertthat::assert_that(assertthat::is.writeable(location),
                            msg = paste0("Framework creation could not proceed, path=<", location, "> is not writeable!"))
    if (is.na(sample_app) || !is.logical(sample_app)) {
        warning("'sample_app' must have valid boolean value. Setting 'sample_app' to default value 'FALSE'")
        sample_app <- FALSE
    }

    if (is.na(right_sidebar) || !is.logical(right_sidebar)) {
        warning("'right_sidebar' must have valid boolean value. Setting 'right_sidebar' to default value 'FALSE'")
        right_sidebar <- FALSE
    }

    if (is.na(left_sidebar) || !is.logical(left_sidebar)) {
        warning("'left_sidebar' must have valid boolean value. Setting 'left_sidebar' to default value 'TRUE'")
        left_sidebar <- TRUE
    }

    usersep <- .Platform$file.sep
    newloc  <- paste(location, name, sep = usersep)

    assertthat::assert_that(!dir.exists(newloc),
                            msg = paste0("Framework creation could not proceed, path=<", newloc, "> already exists!"))

    application_created <- FALSE

    tryCatch({
        .create_dirs(newloc  = newloc,
                     usersep = usersep)
        .copy_fw_files(newloc        = newloc,
                       usersep       = usersep,
                       left_sidebar  = left_sidebar,
                       right_sidebar = right_sidebar,
                       sample_app    = sample_app)
        .copy_program_files(newloc        = newloc,
                            usersep       = usersep,
                            sample_app    = sample_app,
                            left_sidebar  = left_sidebar,
                            right_sidebar = right_sidebar)
        application_created <- TRUE
    },
    error = function(e) {
        warning("Framework creation could not proceed due to:", e$message)
    })

    if (application_created) {
        message(paste("Periscope2 application", name, "is created successfully at location", location))
    }
}


#' .create_dirs
#'   Create new application directories
#'
#' @param newloc  - string represents new application location
#' @param usersep - string represents path separator based on running OS
#'
#' @return nothing
#' @keywords internal
#' @noRd
.create_dirs <- function(newloc, usersep) {
    dir.create(newloc)
    dir.create(paste(newloc, "www", sep = usersep))
    dir.create(paste(newloc, "www", "css", sep = usersep))
    dir.create(paste(newloc, "www", "js", sep = usersep))
    dir.create(paste(newloc, "www", "img", sep = usersep))

    dir.create(paste(newloc, "program", sep = usersep))
    dir.create(paste(newloc, "program", "data", sep = usersep))
    dir.create(paste(newloc, "program", "fxn", sep = usersep))
    dir.create(paste(newloc, "program", "modules", sep = usersep))
    dir.create(paste(newloc, "program", "config", sep = usersep))

    dir.create(paste(newloc, "log", sep = usersep))

    #safety for data directory - create .gitignore
    writeLines(c("*", "*/", "!.gitignore"),
               con = paste(newloc, "program", "data", ".gitignore",
                           sep = usersep))
}


#' .copy_fw_files
#'   Create new application standard files
#'
#' @param newloc        - string represents new application location
#' @param usersep       - string represents path separator based on running OS
#' @param left_sidebar  - boolean to control copying left ui sidebar (default = TRUE)
#' @param right_sidebar - boolean to control copying right ui sidebar (default = FALSE)
#' @param sample_app    - boolean to control copying sample app files (default = FALSE)
#'
#' @return nothing
#' @keywords internal
#' @noRd
.copy_fw_files <- function(newloc,
                           usersep,
                           left_sidebar  = TRUE,
                           right_sidebar = FALSE,
                           sample_app    = FALSE) {
    files <- c("global.R", "server.R", "ui.R")

    for (file in files) {
        file_contents <- readLines(con = system.file("fw_templ", file, package = "periscope2"))

        if (file == "ui.R") {
            if (left_sidebar) {
                file_contents <- append(file_contents,
                                        "source(paste(\"program\", \"ui_left_sidebar.R\", sep = .Platform$file.sep), local = TRUE)")
            }

            if (right_sidebar) {
                file_contents <- append(file_contents,
                                        "source(paste(\"program\", \"ui_right_sidebar.R\", sep = .Platform$file.sep), local = TRUE)")

            }


            file_contents <- append(file_contents, "create_application_dashboard()")
        }

        ui_file <- file(paste(newloc, file, sep = usersep), open = "w+")
        writeLines(file_contents, con = ui_file)
        close(ui_file)
    }

    #subdir copies
    imgs <- c("loader.gif", "tooltip.png")

    for (file in imgs) {
        writeBin(readBin(
            con = system.file("fw_templ", "www", file,
                              package = "periscope2"),
            what = "raw", n = 1e6),
            con = paste(newloc, "www", "img", file, sep = usersep))
    }

    file.copy(system.file("fw_templ", "www", "custom.js", package = "periscope2"),
              paste(newloc, "www", "js", "custom.js", sep = usersep))

    if (sample_app) {
        file.copy(system.file("fw_templ", "p_example", "periscope_style.yaml", package = "periscope2"),
                  paste(newloc, "www", "periscope_style.yaml", sep = usersep))
        file.copy(system.file("fw_templ", "p_example", "custom.css", package = "periscope2"),
                  paste(newloc, "www", "css", "custom.css", sep = usersep))
    } else {
        file.copy(system.file("fw_templ", "www", "periscope_style.yaml", package = "periscope2"),
                  paste(newloc, "www", "periscope_style.yaml", sep = usersep))
        file.copy(system.file("fw_templ", "www", "custom.css", package = "periscope2"),
                  paste(newloc, "www", "css", "custom.css", sep = usersep))
    }
}


#' .copy_program_files
#'   Copy program folder files
#'
#' @param newloc        - string represents new application location
#' @param usersep       - string represents path separator based on running OS
#' @param sample_app    - boolean to control copying sample app files (default = FALSE)
#' @param left_sidebar  - boolean to control copying left ui sidebar (default = TRUE)
#' @param right_sidebar - boolean to control copying right ui sidebar (default = FALSE)
#'
#' @return nothing
#' @keywords internal
#' @noRd
.copy_program_files <- function(newloc,
                                usersep,
                                sample_app,
                                left_sidebar  = TRUE,
                                right_sidebar = FALSE) {
    file.copy(system.file("fw_templ", "announce.yaml", package = "periscope2"),
              paste(newloc, "program", "config", "announce.yaml", sep = usersep))

    files <- list("global.R"        = "global.R",
                  "server_global.R" = "server_global.R",
                  "server_local.R"  = "server_local.R",
                  "ui_body.R"       = "ui_body.R",
                  "ui_header.R"     = "ui_header.R",
                  "ui_footer.R"     = "ui_footer.R")

    if (left_sidebar) {
        files["ui_left_sidebar.R"] <- "ui_left_sidebar.R"
    }

    if (right_sidebar) {
        files["ui_right_sidebar.R"] <- "ui_right_sidebar.R"
    }

    targetdir <- paste(newloc, "program", sep = usersep)
    sourcedir <- paste("fw_templ",
                       ifelse(sample_app, "p_example", "p_blank"),
                       sep = usersep)

    if (sample_app && !left_sidebar) {
        files["ui_body.R"] <- "ui_body_no_left_sidebar.R"
    }

    for (file in names(files)) {
        file_contents <- readLines(con = system.file(paste(sourcedir, files[[file]], sep = usersep), package = "periscope2"))
        program_file  <- file(paste(targetdir, file, sep = usersep), open = "w+")
        writeLines(file_contents, con = program_file)
        close(program_file)
    }

    #subdir copies for sample_app
    if (sample_app) {
        supporting_files <- list("example.csv"       = "data",
                                 "structure.csv"     = "data",
                                 "struc_indx.csv"    = "data",
                                 "program_helpers.R" = "fxn",
                                 "plots.R"           = "fxn")
        for (file in names(supporting_files)) {
            writeLines(readLines(
                con = system.file(sourcedir, file,
                                  package = "periscope2")),
                con = paste(targetdir,
                            unlist(supporting_files[file], use.names = FALSE),
                            file,
                            sep = usersep))
        }
    }
}
