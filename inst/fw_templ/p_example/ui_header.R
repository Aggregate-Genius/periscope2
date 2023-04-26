# ----------------------------------------
# --       PROGRAM ui_header.R          --
# ----------------------------------------
# USE: Create UI elements for the
#      application header and
#      ATTACH them to the UI by calling
#      add_ui_header()
#
# NOTEs:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --     SIDEBAR ELEMENT CREATION       --
# ----------------------------------------

# -- Header Configurations

# Navbar skin. "dark" or "light"
skin           <-  "light"

# Navbar status
status         <-  "white"

# Whether to separate the navbar and body by a border.
border         <-  TRUE

# Whether items should be compacted
compact        <-  FALSE

# Icon of the main sidebar toggle
left_sidebar_icon <-  shiny::icon("bars")

# Icon to toggle the right sidebar
right_sidebar_icon <-  shiny::icon("th")

# Whether to fix the navbar to the top
fixed          <-  FALSE

# -- Create Header Elements

# Custom left UI content
left_ui        <- NULL

# Custom right UI content
right_ui       <- NULL

# -- Register Header Elements in the ORDER SHOWN in the UI
add_ui_header(skin               = skin,
              status             = status,
              border             = border,
              compact            = compact,
              left_sidebar_icon  = left_sidebar_icon,
              right_sidebar_icon = right_sidebar_icon,
              fixed              = fixed,
              left_ui            = left_ui,
              right_ui           = right_ui)
