# ----------------------------------------
# --          PROGRAM ui_body.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application body (right side on the
#      desktop; contains output) and
#      ATTACH them to the UI by calling
#      add_ui_body()
#
# NOTEs:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --      BODY ELEMENT CREATION         --
# ----------------------------------------

# -- Create Elements

### Application Setup Elements
about_box <- box(
    id     = "about_box",
    width  = 12,
    status = "info",
    solidHeader = TRUE,
    title  = "About periscope2",
    tags$dl(tags$p("periscope2 is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience",
                   "functions with the goal of both streamlining robust application development and assisting in creating a consistent",
                   " user experience regardless of application or developer."),
            tags$dt("Features"),
            tags$ul(tags$li("A predefined but flexible template for new Shiny applications with a default dashboard layout"),
                    tags$li("Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local."),
                    tags$li("Six off shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'"),
                    tags$li("Different methods to notify user and add useful information about application UI and server operations")))
)

files_organization_box <- box(
    id          = "files_organization",
    title       = "Files Organization",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    canvasXpressOutput("file_structure_plot", height = "88vh"),
    htmlOutput("file_description")
)

application_setup <- tabItem(tabName = "application_setup",
                             about_box,
                             files_organization_box)

### Application Modules Elements
plot2_hover <- hoverOpts(id = "examplePlot2_hover")

announcements_box <- box(
    id          = "announcements",
    title       = "Announcements",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    tags$dl(tags$dt("Features"),
            tags$dd("- Announcements module aim to alert app user with customized admin messages upon application start for predefined time."),
            tags$dt("Setup"),
            tags$dd("- Module can be configured via 'program/config/announce.yaml'"),
            tags$dd("- Review current application example configuration for more details on how to configure/disable announcements`"))
)

table_downloader_box <- box(
    id          = "table_downloader",
    title       = "Table Downloader",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    tags$dl(tags$dt("Features"),
            tags$ul(tags$li("Data can downloaded in different formats"),
                    tags$li("User can customize downloadableTable modules using DT options such as:",
                            tags$ul(tags$li("labels:", HTML("&nbsp;"),
                                            tags$b(tags$i("i.e. 'colnames', 'caption', ..."))),
                                    tags$li("layout and columns styles:", HTML("&nbsp;"),
                                            tags$b(tags$i("i.e. 'container', 'formatStyle', ..."))),
                                    tags$li("other addons:", HTML("&nbsp;"),
                                            tags$b(tags$i("i.e. 'filter', 'callback', ..."))))),
                    tags$li("For more information about table options please visit the",
                            tags$a("DT documentation", target = "_blank", href = "https://rstudio.github.io/DT/"),
                            "site")
            ),
            tags$dt("Setup"),
            tags$li("Module should be configured in both UI and Server code",
                    blockQuote("Run '?periscope2::downloadableTable' for more info", color = "info")),
            tags$dt("Example")),
    downloadableTableUI("exampleDT1",
                        list("csv", "tsv"),
                        "Download table data")
)

file_downloader_box <- box(
    id          = "file_downloader",
    title       = "File Downloader",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 6,
    tags$dl(tags$dt("Features"),
            tags$ul(tags$li("Data download buttons for single-option (no choice of format) or ",
                            "multiple choices of formats can be added by specifying the ",
                            "extensions and corresponding data functions with the ",
                            "following code:")),
            tags$dt("Setup"),
            tags$ul(tags$li("Module should be configured in both UI and Server code",
                            blockQuote(p(pre("U: downloadFileButton('uiID', list(extensions))"),
                                         pre("S: downloadFile('uiID', logger, 'filenameroot', list(datafxns)")),
                                       color = "info"))),
            tags$dl(tags$dt("Example"),
                    "Single Download: ",
                    downloadFileButton("exampleDownload1", c("csv"), "csv"),
                    "Multiple-choice Download: ",
                    downloadFileButton("exampleDownload2",
                                       c("csv", "xlsx", "tsv"), "Download options")))
)

plot_downloader_box <- box(
    id          = "plot_downloader",
    title       = "Plot Downloader - ggplot2 & lattice",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    tags$dl(tags$dt("Features"),
            tags$ul(tags$li("Periscope2 offers this module to download plots that have no internal download ability like ggplot2 & lattice."),
                    tags$li("User can download both data and plot itself in different format"),),
            tags$dt("Setup"),
            tags$ul(tags$li("Module should be configured in both UI and Server code",
                    blockQuote("Run '?periscope2::downloadablePlot' for more info", color = "info"))),
            tags$dt("Example")),
    fluidRow(
        column(width = 6, downloadablePlotUI("examplePlot2",
                                             list("jpeg", "csv"),
                                             "Download plot or data",
                                             btn_halign  = "left",
                                             btn_valign  = "top",
                                             btn_overlap = FALSE,
                                             hoverOpts   = plot2_hover)),
        column(width = 6, downloadablePlotUI("examplePlot3",
                                             list("png", "tiff",
                                                  "txt", "tsv"),
                                             btn_overlap = FALSE,
                                             "Download plot or data")) ),
    uiOutput("hover_info")
)

reset_application_box <- box(
    id = "reset_application",
    title = "Reset Application",
    status = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width = 6,
    tags$dl(tags$dt("Features"),
            tags$ul(tags$li("Resets a user's session"),
                    tags$li("Rolls over their log."))),
    tags$dl(tags$dt("Setup"),
            tags$ul(tags$li("Functionality can be added with the following code:"),
                    blockQuote(p(pre("U: appResetButton('appResetId')"),
                                         pre("S: appReset(id = 'appResetId', logger = logger)")),
                                       color = "info"))),
    tags$dl(tags$dt("Example"),
            appResetButton("appResetId"))
)


logger_box <- box(
    id          = "logger",
    title       = "Logging Information",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    tags$dl(tags$dt("Features"),
            tags$ul(tags$li(p("The collapsed ",
                              strong("User Action Log"), em("below"),
                              "is the standardized footer added by the framework.")),
                    tags$li(p("It is important to note that the log ",
                              "rolls over for each session.  The log files are kept in the ",
                              "/log directory and named 'actions.log'.  ONE old copy of ",
                              "the log is kept as 'actions.log.last")))),
    tags$dl(tags$dt("Setup"),
            tags$ul(tags$li("To create actions to the framework call one of the logging ",
                            "functions like: "),
                    blockQuote(p(pre("S: logXXXX('Your Log Message with %s, %s parameters', parm1, parm2, logger = ss_userAction.Log)")),
                               color = "info"),
                    tags$li(p("The XXXX should be replaced by an actual log level like 'info', 'debug', 'warn' or 'error'.
                              The framework will handle updating the footer UI element every time the log is added to.")),
                    tags$li("To display application logs like below portlet add the following logViewer table to your box",
                            blockQuote(p(pre("U: logViewerOutput('logViewerId')")),
                                       color = "info")))),
    tags$dl(tags$dt("Example"),
            logViewerOutput("logViewerId"))
)


periscope_modules <- tabItem(tabName = "periscope_modules",
                             announcements_box,
                             table_downloader_box,
                             plot_downloader_box,
                             fluidRow(file_downloader_box,
                                      reset_application_box),
                             logger_box)

### User Notifications Elements
busy_indicator_box <- box(
    id          = "busy_indicator",
    title       = "Busy Indicators",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    p("Periscope2 has two application busy indicators"),
    tags$dl(tags$dt("Application Loading"),
            tags$dd("- Indicator that displayed upon application start up or reload."),
            tags$dd("- It can be set in 'program/global.R'"),
            tags$dd(actionButton("showAppLoading",
                                 label  = "Show application Loading",
                                 status = "danger")),
            hr(),
            tags$dt("Busy Session"),
            tags$dd("- An automatic wait indicator in the navbar when the shiny server session is busy."),
            tags$dd(actionButton("showWorking",
                                 label  = "Show application busy indicator for 5 seconds",
                                 status = "info")))
)

alerts_box <- box(
    id          = "alerts",
    title       = "Alerts",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    p("Alerts can be added with the following code in the server:"),
    blockQuote(tags$pre("S:periscope2::createAlert(id = 'alert place',
                         options = list(title    = 'alert title',
                         status   = 'alert status'',
                         closable = TRUE,
                         content  = alert contents))"), color = "info"),
    hr(),
    tags$h5("Examples"),
    p("LOCATION can be: 'sidebarRightAlert', 'sidebarBasicAlert', 'bodyAlert', 'footerAlert' and 'headerAlert'"),
    conditionalPanel("$('.main-sidebar').length > 0",
                     actionButton("leftAlert",
                                  label  = "Left Alert",
                                  status = "warning",
                                  width  = "15%")),
    actionButton("bodyAlertBtn",
                 label  = "Body",
                 status = "info",
                 width  = "15%"),
    conditionalPanel("$('.control-sidebar').length > 0",
                     actionButton("rightAlert",
                                  label  = "Right Alert",
                                  status = "success",
                                  width  = "15%")),
    conditionalPanel("$('.main-footer').length > 0",
                     actionButton("footerAlertbtn",
                                  label  = "Footer Alert",
                                  status = "danger",
                                  width  = "15%")),
    actionButton("headerAlertbtn",
                 label  = "Header Alert",
                 status = "primary",
                 width  = "15%")
)

tooltips_box <- box(
    id          = "tooltips",
    title       = "Tooltips",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    p("Tooltips can be added with the following code in the UI:"),
    blockQuote("U: ui_tooltip('tooltipID', 'label text (optional)', 'text content', 'placement' (optional))", color = "info"),
    tags$h5("Examples"),
    ui_tooltip(id    = "top_tip",
               label = "Top Tooltips",
               text  = "Top tooltip"),
    ui_tooltip(id        = "left_tip",
               label     = "Left Tooltips",
               text      = "left tooltip",
               placement = "left"),
    ui_tooltip(id        = "bottom_tip",
               label     = "Bottom Tooltips",
               text      = "Bottom tooltip",
               placement = "bottom"),
    ui_tooltip(id        = "right_tip",
               label     = "Right Tooltips",
               text      = "Right tooltip",
               placement = "right")
)

user_notifications <- tabItem(tabName = "user_notifications",
                              busy_indicator_box,
                              alerts_box,
                              tooltips_box)


# -- Register Elements in the ORDER SHOWN in the UI
add_ui_body(list(about_box,
                 files_organization_box,
                 announcements_box,
                 table_downloader_box,
                 plot_downloader_box,
                 fluidRow(file_downloader_box,
                          reset_application_box),
                 logger_box,
                 busy_indicator_box,
                 alerts_box,
                 tooltips_box))
