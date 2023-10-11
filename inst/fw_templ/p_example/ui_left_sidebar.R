# ----------------------------------------
# --       PROGRAM ui_left_sidebar.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application sidebar (left side on
#      the desktop; contains options) and
#      ATTACH them to the UI by calling
#      add_ui_left_sidebar()
#
# NOTES:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --     SIDEBAR ELEMENT CREATION       --
# ----------------------------------------

# -- Left Sidebar Configurations
# Sidebar skin. "dark" or "light"
skin <- "light"

# Sidebar status
status <- "info"

# Sidebar elevation. 4 by default (until 5).
elevation <- 4

# If TRUE, the sidebar will be collapsed on app startup.
collapsed <- FALSE

# Whether to slightly close the sidebar but still show item icons
minified <- FALSE

# Whether to expand the sidebar om hover
expand_on_hover <- FALSE

# Whether to fix the sidebar
fixed <- TRUE

# -- Create Sidebar Elements
# elements to be placed before any menu
sidebar_elements <- NULL

# sidebar menu items
sidebar_menu <-  sidebarMenu(
    sidebarHeader("Periscope2 Features"),
    menuItem(
        "Application Setup",
        tabName = "application_setup",
        icon    = icon("building")
    ),
    menuItem(
        "Periscope2 Modules",
        tabName = "periscope_modules",
        icon    = icon("cubes")
    ),
    menuItem(
        "User Notifications",
        tabName = "user_notifications",
        icon    = icon("comments")
    ),
    menuItem(
        "Style Guide",
        tabName = "style_guide",
        icon    = icon("file-code")
    )
)

# An area at the bottom of the sidebar to contain elements like buttons
custom_area <- NULL

# -- Register Sidebar Elements in the ORDER SHOWN in the UI
add_ui_left_sidebar(sidebar_elements = sidebar_elements,
                    skin             = skin,
                    status           = status,
                    elevation        = elevation,
                    collapsed        = collapsed,
                    minified         = minified,
                    expand_on_hover  = expand_on_hover,
                    fixed            = fixed,
                    sidebar_menu     = sidebar_menu,
                    custom_area      = custom_area)
