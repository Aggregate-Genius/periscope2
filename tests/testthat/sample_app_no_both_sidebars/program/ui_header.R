# ----------------------------------------
# --       PROGRAM ui_header.R          --
# ----------------------------------------
# USE: Create UI elements for the
#      application header and
#      ATTACH them to the UI by calling
#      add_ui_header()
#
# NOTES:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --     HEADER ELEMENT CREATION       --
# ----------------------------------------

# -- Header Configurations

# Navbar skin. "dark" or "light"
skin <- "light"

# Navbar status
status <- "white"

# Whether to separate the navbar and body by a border.
border <- TRUE

# Whether items should be compacted
compact <- FALSE

# Icon of the main sidebar toggle
left_sidebar_icon <- shiny::icon("bars")

# Icon to toggle the right sidebar
right_sidebar_icon <- shiny::icon("th")

# Whether to fix the navbar to the top
fixed <- FALSE

# -- Create Header Elements

# Custom left menu content
left_menu  <- NULL

# Custom right menu content
right_menu <- NULL

# -- Register Header Elements in the ORDER SHOWN in the UI
add_ui_header(title              = "periscope2 Example Application",
              left_menu          = left_menu,
              right_menu         = right_menu,
              skin               = skin,
              status             = status,
              border             = border,
              compact            = compact,
              left_sidebar_icon  = left_sidebar_icon,
              right_sidebar_icon = right_sidebar_icon,
              fixed              = fixed)

