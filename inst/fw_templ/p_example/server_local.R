# ----------------------------------------
# --       PROGRAM server_local.R       --
# ----------------------------------------
# USE: Session-specific variables and
#      functions for the main reactive
#      shiny server functionality.  All
#      code in this file will be put into
#      the framework inside the call to
#      shinyServer(function(input, output, session)
#      in server.R
#
# NOTEs:
#   - All variables/functions here are
#     SESSION scoped and are ONLY
#     available to a single session and
#     not to the UI
#
#   - For globally scoped session items
#     put var/fxns in server_global.R
#
# FRAMEWORK VARIABLES
#     input, output, session - Shiny
#     ss_userAction.Log - Reactive Logger S4 object
# ----------------------------------------

# -- IMPORTS --
source(paste("program", "fxn", "program_helpers.R", sep = .Platform$file.sep))
source(paste("program", "fxn", "plots.R", sep = .Platform$file.sep))

# -- VARIABLES --

orignal_theme_settings <- list()
orignal_theme_settings[["primary"]]                  <- "#EBCDFC"
orignal_theme_settings[["secondary"]]                <- "#CD9489"
orignal_theme_settings[["success"]]                  <- "#2ED610"
orignal_theme_settings[["info"]]                     <- "#7BDFF2"
orignal_theme_settings[["warning"]]                  <- "#FFF200"
orignal_theme_settings[["danger"]]                   <- "#CE0900"
orignal_theme_settings[["sidebar_background_color"]] <- "#FFFFE6"

# -- FUNCTIONS --
appReset(id     = "appResetId",
         logger = ss_userAction.Log)

downloadFile("exampleDownload1",
             ss_userAction.Log,
             "examplesingle",
             list(csv = load_data1))
downloadFile("exampleDownload2",
             ss_userAction.Log,
             "examplemulti",
             list(csv = load_data2, xlsx = load_data2, tsv = load_data2))

sketch <- htmltools::withTags(
    table(
        class = "display",
        thead(
            tr(
                th(rowspan = 2, "Location"),
                th(colspan = 2, "Statistics")),
            tr(
                th("Change"),
                th("Increase")))
    ))


downloadableTable("exampleDT1",
                  ss_userAction.Log,
                  "exampletable",
                  list(csv = load_data3, tsv = load_data3),
                  load_data3,
                  table_options = list(colnames    = c("Area", "Delta", "Increase"),
                                       filter      = "bottom",
                                       callback    = htmlwidgets::JS("table.order([1, 'asc']).draw();"),
                                       container   = sketch,
                                       formatStyle = list(columns = c("Total.Population.Change"),
                                                          color   = DT::styleInterval(0, c("red", "green"))),
                                       formatStyle = list(columns         = c("Natural.Increase"),
                                                          backgroundColor = DT::styleInterval(c(7614, 15914, 34152),
                                                                                              c("lightgray", "gray", "cadetblue", "#808000")))))
downloadablePlot("examplePlot2",
                 ss_userAction.Log,
                 filenameroot = "plot2_ggplot",
                 downloadfxns = list(jpeg = plot2ggplot,
                                     csv  = plot_data),
                 aspectratio  = 1.5,
                 visibleplot  = plot2ggplot)

downloadablePlot("examplePlot3",
                 ss_userAction.Log,
                 filenameroot = "plot3_lattice",
                 aspectratio  = 2,
                 downloadfxns = list(png  = plot3lattice,
                                     tiff = plot3lattice,
                                     txt  = plot_data,
                                     tsv  = plot_data),
                 visibleplot  = plot3lattice)

# ----------------------------------------
# --          SHINY SERVER CODE         --
# ----------------------------------------

# -- Observe UI Changes
observeEvent(input$rightAlert, {
    loginfo("Right Sidebar Alert Button Pushed",
            logger = ss_userAction.Log)
    periscope2::createAlert(id      = "sidebarRightAlert",
                            options = list(title    = "Right Side",
                                           status   = "success",
                                           closable = TRUE,
                                           content  = "Example Basic Sidebar Alert"))
})

observeEvent(input$leftAlert, {
    logwarn("Left Sidebar Alert Example Button Pushed",
            logger = ss_userAction.Log)
    periscope2::createAlert(id      = "sidebarBasicAlert",
                            options = list(title    = "Left Side",
                                           status   = "warning",
                                           closable = TRUE,
                                           content  = "Example Advanced Sidebar Alert"))

})

observeEvent(input$bodyAlertBtn, {
    logdebug("Body Alert Example Button Pushed",
             logger = ss_userAction.Log)
    periscope2::createAlert(id      = "bodyAlert",
                            options = list(title    = "Body",
                                           status   = "info",
                                           closable = TRUE,
                                           content  = paste("Example Body Alert")))
})

observeEvent(input$footerAlertbtn, {
    logerror("Footer Alert Example Button Pushed",
             logger = ss_userAction.Log)
    periscope2::createAlert(id      = "footerAlert",
                            options = list(title    = "Footer",
                                           status   = "danger",
                                           closable = TRUE,
                                           content  = paste("Example Footer Alert")))
})

observeEvent(input$headerAlertbtn, {
    loginfo("Header Alert Example Button Pushed",
            logger = ss_userAction.Log)
    periscope2::createAlert(id      = "headerAlert",
                            options = list(title    = "Header",
                                           status   = "primary",
                                           closable = TRUE,
                                           content  = "Example Header Alert"))
})

observeEvent(input$showWorking, {
    loginfo("Show Busy Indicator Button Pushed",
            logger = ss_userAction.Log)
    Sys.sleep(5)
})


observeEvent(input$showAppLoading, {
    loginfo("Show App Loading Page Button Pushed",
            logger = ss_userAction.Log)
    loginfo(getwd())
    source("./ui.R", local = T)
    session$reload()
})


output$hover_info <- renderUI({
    output_panel <- NULL
    hover        <- input$examplePlot2_hover
    point        <- nearPoints(mtcars, hover,
                               xvar = "wt", yvar = "mpg",
                               maxpoints = 1)

    if (NROW(point) > 0) {
        left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
        left_px  <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
        top_pct  <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
        top_px   <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)

        style <- paste0("position:absolute;",
                        "z-index:100;",
                        "background-color: rgba(245, 245, 245, 0.85); ",
                        "left:", left_px - 20, "px; top:", top_px + 300, "px;")

        output_panel <- wellPanel(class = "well-sm",
                                  style = style,
                                  HTML("<b> Car: </b>", rownames(point)))
    }

    output_panel
})

output$file_structure_plot <- renderCanvasXpress({
    canvasXpress(
        data             = files_idx,
        smpAnnot         = app_files,
        graphType        = "Tree",
        hierarchy        = list("App_Root", "L1"),
        title            = "Empty Application Files",
        graphOrientation = "horizontal",
        events           = node_event
    )
})

observeEvent(input$node_name, {
    node_name <- gsub(pattern     = "Tree:| \\(\\d*\\)",
                      replacement = "",
                      x           = input$node_name) %>%
        trimws()
    output$file_description <- renderText({
        node_description[[node_name]]
    })
})


observeEvent(input$hideFileOrganization, {
    updateBox("files_organization", action = "toggle")
})


observeEvent(TRUE,{
    output$app_theme <- renderUI(fresh::use_theme(periscope2:::create_theme()))
    theme_settings   <- read_themes()

    updateColourInput(session,
                      inputId = "primary_picker",
                      value   = theme_settings[["primary"]])
    updateColourInput(session,
                      inputId = "secondary_picker",
                      value   = theme_settings[["secondary"]])
    updateColourInput(session,
                      inputId = "success_picker",
                      value   = theme_settings[["success"]])
    updateColourInput(session,
                      inputId = "info_picker",
                      value   = theme_settings[["info"]])
    updateColourInput(session,
                      inputId = "warning_picker",
                      value   = theme_settings[["warning"]])
    updateColourInput(session,
                      inputId = "danger_picker",
                      value   = theme_settings[["danger"]])
    updateNumericInput(session,
                       inputId = "left_width",
                       value   = ifelse(is.null(theme_settings[["sidebar_width"]]), NA, theme_settings[["sidebar_width"]]))
    updateNumericInput(session,
                       inputId = "right_width",
                       value   = ifelse(is.null(theme_settings[["right_sidebar_width"]]), NA, theme_settings[["right_sidebar_width"]]))
    updateColourInput(session,
                      inputId = "background_color_picker",
                      value   = theme_settings[["main_background_color"]])
    updateColourInput(session,
                      inputId = "sidebar_background_color_picker",
                      value   = theme_settings[["sidebar_background_color"]])
    updateColourInput(session,
                      inputId = "sidebar_background_hover_color_picker",
                      value   = theme_settings[["sidebar_background_hover_color"]])
    updateColourInput(session,
                      inputId = "sidebar_hover_color_picker",
                      value   = theme_settings[["sidebar_hover_color"]])
    updateColourInput(session,
                      inputId = "sidebar_color_picker",
                      value   = theme_settings[["sidebar_color"]])
    updateColourInput(session,
                      inputId = "sidebar_active_color_picker",
                      value   = theme_settings[["sidebar_active_color"]])
}, once = TRUE)


observeEvent(input$update_app_theme, {
    theme_settings <- list()
    theme_settings[["primary"]]   <- input$primary_picker
    theme_settings[["secondary"]] <- input$secondary_picker
    theme_settings[["success"]]   <- input$success_picker
    theme_settings[["info"]]      <- input$info_picker
    theme_settings[["warning"]]   <- input$warning_picker
    theme_settings[["danger"]]    <- input$danger_picker

    left_width  <- input$left_width
    right_width <- input$right_width

    if (is.na(left_width) ||
        is.null(left_width) ||
        (left_width <= 0)) {
        theme_settings[["sidebar_width"]] <- NULL
    } else {
        theme_settings[["sidebar_width"]] <- left_width
    }

    if (is.na(right_width) ||
        is.null(right_width) ||
        (right_width <= 0)) {
        theme_settings[["right_sidebar_width"]] <- NULL
    } else {
        theme_settings[["right_sidebar_width"]] <- right_width
    }

    background_color_picker               <- NULL
    sidebar_background_hover_color_picker <- NULL
    sidebar_hover_color_picker            <- NULL
    sidebar_color_picker                  <- NULL
    sidebar_active_color_picker           <- NULL

    if (input$background_color_picker != "#FFFFFF") {
        background_color_picker <- input$background_color_picker
    }

    if (input$sidebar_background_hover_color_picker != "#FFFFFF") {
        sidebar_background_hover_color_picker <- input$sidebar_background_hover_color_picker
    }

    if (input$sidebar_hover_color_picker != "#FFFFFF") {
        sidebar_hover_color_picker <- input$sidebar_hover_color_picker
    }

    if (input$sidebar_color_picker != "#FFFFFF") {
        sidebar_color_picker <- input$sidebar_color_picker
    }

    if (input$sidebar_active_color_picker != "#FFFFFF") {
        sidebar_active_color_picker <- input$sidebar_active_color_picker
    }

    theme_settings[["main_background_color"]]          <- background_color_picker
    theme_settings[["sidebar_background_color"]]       <- input$sidebar_background_color_picker
    theme_settings[["sidebar_background_hover_color"]] <- sidebar_background_hover_color_picker
    theme_settings[["sidebar_hover_color"]]            <- sidebar_hover_color_picker
    theme_settings[["sidebar_color"]]                  <- sidebar_color_picker
    theme_settings[["sidebar_active_color"]]           <- sidebar_active_color_picker

    write_yaml(theme_settings, "www/periscope_style.yaml")
    session$reload()
})


observeEvent(input$restore_app_theme, {
    write_yaml(orignal_theme_settings, "www/periscope_style.yaml")
    session$reload()
})
