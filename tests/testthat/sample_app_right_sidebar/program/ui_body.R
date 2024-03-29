# ----------------------------------------
# --          PROGRAM ui_body.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application body (right side on the
#      desktop; contains output) and
#      ATTACH them to the UI by calling
#      add_ui_body()
#
# NOTES:
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
    id          = "about_box",
    width       = 12,
    status      = "info",
    solidHeader = TRUE,
    title       = "About periscope2",
    tags$dl(tags$p("periscope2 is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience",
                   "functions with the goal of both streamlining robust application development and assisting in creating a consistent",
                   " user experience regardless of application or developer."),
            tags$dt("Features"),
            tags$ul(tags$li("Predefined but flexible template for new Shiny applications with a default dashboard layout"),
                    tags$li("Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local."),
                    tags$li("Off-the-shelf and ready to be used modules ('Table Downloader', 'Plot Downloader', 'File Downloader' and 'Reset Application'"),
                    tags$li("Different methods and tools to alert users and add useful information about application UI and server operations"),
                    tags$li("Application logger with different levels and a UI tool to display and review recorded application logs"),
                    tags$li("Application look and feel can be customized easily via 'www/periscope_style.yaml' or more advanced via 'www/css/custom.cs'"),
                    tags$li("Application can make use of JS power by customizing 'www/js/custom.js'")))
)


announcements_box <- box(
    id          = "announcements",
    title       = "Announcements",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$li("'Announcement' feature is a user friendly method to announce a recently added feature, initiate a shutdown warning, or ",
                                    "broadcast any news to your users at once"),
                            tags$li("Announcements feature aim to alert app user with customized admin messages upon application start for a predefined time"),
                            tags$li("Announcement can be either a simple text or a fully rich HTML text."),
                            tags$li("Announcement location is on the application header"),
                            tags$li("Announcement status (body color) can be: 'primary', 'success', 'warning', 'danger' or 'info'"),
                            tags$li("Application admin can control when an 'Announcement' should start to be seen and when it should be expire"),
                            tags$li("Application admin can control how long an 'Announcement' stay visible for users or let each user close it manually"))),
             column(width = 6,
                    tags$dl(tags$dt("Setup"),
                            tags$li("No development is needed to launch or control 'Announcements' feature, only configurations"),
                            tags$li("Default feature generated configuration file is called ", tags$b("announce.yaml")),
                            tags$li("Default configuration file path is: ", tags$i("'program/config/announce.yaml'")),
                            tags$li("Configuration file path can be changed based on admin preference. Only update ",
                                    tags$b("'announcements_file_path'"), " parameter in ", tags$b("'load_announcements'"), " method in ",
                                    tags$b("'server.R'"), " file with the new config file path"),
                            tags$li("Check generated configuration file self-documentation for each config variable usage details"),
                            tags$li("Review current application example configuration for more details on how to configure/disable announcements`"))))
)


logger_box <- box(
    id          = "logger",
    title       = "Logger",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$li("Logger feature presents a developer and an admin friendly method to record different user or internal actions ",
                                    "in their recoded time and using different logging levels"),
                            tags$li("There are 4 different available log levels: 'logdebug', 'loginfo', 'logwarn' and 'logerror' in that order"),
                            tags$li("Each log level is displayed in different text color in R console"),
                            tags$li("User can control which log levels to be excluded from being displayed or recorded"),
                            tags$ul(style = "list-style-type: circle;",
                                    tags$li("The log rolls over for each session"),
                                    tags$li("The log files are kept in the ", tags$b("/log"), "directory and named ",  tags$b("'actions.log'")),
                                    tags$li("ONE old copy of the log is kept as ", tags$b("'actions.log.last'"))),
                            tags$li("Beside reviewing the log files directly, admins can review logs in application via ", tags$b("logViewer UI"), " module"))),
             column(width = 6,
                    tags$dl(tags$dt("Setup"),
                            tags$ul(tags$li("To create actions to the framework call one of the logging ",
                                            "functions like: "),
                                    blockQuote(p(pre("S: logXXXX('Your Log Message with %s, %s parameters', parm1, parm2, logger = ss_userAction.Log)")),
                                               color = "info"),
                                    tags$li(p("The XXXX should be replaced by an actual log level like ", tags$b("'debug'"), ", ",
                                              tags$b("'info'"), ", ", tags$b("'warn'"), ", ",  "or ", tags$b("'error'"),
                                              " The framework will handle updating LogViewer UI module every time the log is added to.")),
                                    tags$li("'ss_userAction.Log' is a periscope framework logger that is defined automatically under server.R and",
                                            tags$b(" should not be altered")),
                                    tags$li("Log level can be changed based on admin preference. Only update ",
                                            tags$b("'log_level'"), " parameter in ", tags$b("'set_app_parameters'"), " method in ",
                                            tags$b("'program/global.R'"), " file with the required log level ",
                                            tags$b("'DEBUG'"), ", ", tags$b("'INFO'"), ", ", tags$b("'WARN'"), " or ", tags$b("'ERROR'")),
                                    tags$li("To display application logs like below portlet add the following logViewer table to any of 'ui_body.R' boxes",
                                            blockQuote(p(pre("U: logViewerOutput('logViewerId')")),
                                                       color = "info")))))),
    fluidRow(column(width = 12,
                    tags$dl(tags$dt("Example"),
                            tags$p("Click different button in the example application and compare console with below output"),
                            br(),
                            br(),
                            div(logViewerOutput("logViewerId2"), style = "min-width: 'auto';"))))
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
                             announcements_box,
                             logger_box,
                             files_organization_box)

### Application Modules Elements
plot2_hover <- hoverOpts(id = "examplePlot2_hover")


table_downloader_box <- box(
    id          = "table_downloader",
    title       = "Table Downloader",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$ul(tags$li("Table downloader module display tabular data in rich formatted tables using `DT` package"),
                                    tags$li("Selected rows in the table are returned as a reactive variable that can be used in application different areas"),
                                    tags$li("Table data can be downloaded in different formats such as: ", tags$b("'csv'"),
                                            ", ", tags$b("'tsv'"), ", ", tags$b("'txt'"), "and/or ", tags$b("'xlsx'")),
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
                            ))),
             column(width = 6,
                    tags$dl(tags$dt("Setup"),
                            tags$li("Module should be configured in both UI and Server code"),
                            tags$li("In your 'body_ui.R', place module UI part as follow: ",
                                    blockQuote("downloadableTableUI('exampleDT1',
                                                                    list('csv', 'tsv'),
                                                                    'Download table data'))", color = "info")),
                            tags$li("In your 'server_local.R', place module server part, ", tags$em("with the same id used with UI part"), ", as follow: ",
                                    blockQuote("downloadableTable('exampleDT1',
                                                                  ss_userAction.Log,
                                                                  'exampletable',
                                                                  list(csv = load_data3, tsv = load_data3))", color = "info")),
                            tags$li("Review ", tags$b("?downloadableTableUI"), " and ", tags$b("?downloadableTable"), " for more information"),
                            tags$li("Review below table for detailed example code")))),
    fluidRow(column(width = 12,
                    downloadableTableUI("exampleDT1",
                                        list("csv", "tsv"),
                                        "Download table data")))

)

file_downloader_box <- box(
    id          = "file_downloader",
    title       = "File Downloader",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$ul(tags$li("File downloader module provides the user with the ability to download any server generated data"),
                                    tags$li("Data can be downloaded in any format available for both 'Table Downloader' and 'Plot Downloader' modules"),
                                    tags$li("Data can be downloaded in single format or in multiple formats, based on module configurations")))),
             column(width = 6,
                    tags$dl(
                        tags$dt("Setup"),
                        tags$ul(tags$li("Module should be configured in both UI and Server code",
                                        blockQuote(p(pre("U: downloadFileButton('uiID', list(extensions))"),
                                                     pre("S: downloadFile('uiID', logger, 'filenameroot', list(datafxns)")),
                                                   color = "info")),
                                tags$li("Review ", tags$b("?downloadFileButton"), " and ", tags$b("?downloadFile"), " for more information"),
                                tags$li("Review below file downloaders for detailed example code"))))),
    fluidRow(column(width = 12,
                    tags$dl(tags$dt("Example"),
                            "Single Download: ",
                            downloadFileButton("exampleDownload1", c("csv"), "csv"),
                            "Multiple-choice Download: ",
                            downloadFileButton("exampleDownload2",
                                               c("csv", "xlsx", "tsv"), "Download options"))))
)

plot_downloader_box <- box(
    id          = "plot_downloader",
    title       = "Plot Downloader - ggplot2 & lattice",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$ul(tags$li("This module creates a custom plot output that provide download capability",
                                            "to plot tools that have no internal download ability like ggplot2 & lattice."),
                                    tags$li("Plot can be downloaded in different formats such as: ", tags$b("'png'"),
                                            ", ", tags$b("'jpeg'"), ", ", tags$b("'tiff'"), "and/or ", tags$b("'bmp'")),
                                    tags$li("Plot data itself can be downloaded in different formats such as: ", tags$b("'csv'"),
                                            ", ", tags$b("'tsv'"), ", ", tags$b("'txt'"), "and/or ", tags$b("'xlsx'")),
                                    tags$li("To enrich user experience, plot downloader module also can take advanced shiny parameters as 'clickOpts', 'hoverOpts' or 'brushOpts'"),
                                    tags$li("Plot dimensions can be easily adapted"),
                                    tags$li("plot download button location can be easily controlled")))),
             column(width = 6,
                    tags$dl(tags$dt("Setup"),
                            tags$ul(tags$li("Module should be configured in both the UI and Server code"),
                                    tags$li("In your 'body_ui.R', place module UI part as follow: ",
                                            blockQuote("downloadablePlotUI('myplotID', c('png', 'csv'), 'Download Plot or Data', '300px'))", color = "info")),
                                    tags$li("In your 'server_local.R', place module server part, ", tags$em("with the same id used with UI part"), ", as follow: ",
                                            blockQuote("downloadablePlot('myplotID',
                                                                  ss_userAction.Log,
                                                                  filenameroot = 'mydownload1',
                                                                  downloadfxns = list(png = myplotfxn, tsv = mydatafxn))", color = "info")),
                                    tags$li(blockQuote("Run '?periscope2::downloadablePlot' for more info", color = "info")),
                                    tags$li("Review below table for detailed example code"))))),
    fluidRow(column(width = 12,
                    tags$h3("Example")),
             tags$br(),
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
                                                  "Download plot or data"))),
    uiOutput("hover_info")
)

reset_application_box <- box(
    id          = "reset_application",
    title       = "Reset Application",
    status      = "info",
    solidHeader = TRUE,
    collapsible = TRUE,
    width       = 12,
    fluidRow(column(width = 6,
                    tags$dl(tags$dt("Features"),
                            tags$ul(tags$li("appReset module provides the ability to:"),
                                    tags$ul(tags$li("Resets a user's session"),
                                            tags$li("Rolls over their log.")),
                                    tags$li("It creates a toggle button to reset application session"),
                                    tags$li("Upon pressing on the button, its state is flipped to 'cancel application reload'",
                                            " with application and console warning messages indicating that the application will be reloaded "),
                                    tags$li("User can either resume reloading application session or cancel reloading process,",
                                            tags$em(" which will also generate application and console messages to indicate reloading status and result.")),
                                    tags$li("Waiting time before actual session reset is configurable in milliseconds"),
                                    tags$li("Generated module alerts location can be customized to be displayed in any place, default is application body")))),
             column(width = 6,
                    tags$dl(tags$dt("Setup"),
                            tags$ul(tags$li("Functionality can be added with the following code:",
                                            blockQuote(p(pre("U: appResetButton('appResetId')"),
                                                         pre("S: appReset(id = 'appResetId', reset_wait = 5000, logger = logger)")),
                                                       color = "info")),
                                    tags$li(blockQuote("Run '?periscope2::appResetButton' and '?periscope2::appReset' for more info", color = "info")),
                                    tags$li("Review example below for detailed code"))))),
    fluidRow(tags$dl(tags$dt("Example"),
                     appResetButton("appResetId")))
)


periscope_modules <- tabItem(tabName = "periscope_modules",
                             table_downloader_box,
                             plot_downloader_box,
                             file_downloader_box,
                             reset_application_box)

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
            tags$li("Any 'waiter' package loading screen indicator that displayed upon application start up or reload."),
            tags$li("Loading screen can be changed by updating ",
                    tags$b("'loading_indicator'"), " parameter in ", tags$b("'set_app_parameters'"), " method in ",
                    tags$b("'program/global.R'"), " 'waiter' package loading screen"),
            tags$li("For more information about loadnig screens options please visit the",
                    tags$a("waiter documentation", target = "_blank", href = "https://waiter.john-coene.com/"),
                    "site"),
            tags$li("Check example below:"),
            br(),
            br(),
            tags$dd(actionButton("showAppLoading",
                                 label  = "Show application Loading",
                                 status = "danger")),
            hr(),
            tags$dt("Busy Session"),
            tags$li("An automatic wait indicator in the navbar when the shiny server session is busy."),
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
    blockQuote(tags$pre("S:periscope2::createPSAlert(id = 'alert place',
                         options  = list(title    = 'alert title',
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
                                  width  = "15%"),
                     style = "display: inline;"),
    actionButton("bodyAlertBtn",
                 label  = "Body",
                 status = "info",
                 width  = "15%"),
    conditionalPanel("$('.control-sidebar').length > 0",
                     actionButton("rightAlert",
                                  label  = "Right Alert",
                                  status = "success",
                                  width  = "15%"),
                     style = "display: inline;"),
    conditionalPanel("$('.main-footer').length > 0",
                     actionButton("footerAlertbtn",
                                  label  = "Footer Alert",
                                  status = "danger",
                                  width  = "15%"),
                     style = "display: inline;"),
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
               text      = "Left tooltip",
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
