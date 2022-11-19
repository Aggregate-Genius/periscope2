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
sidebarIcon    <-  shiny::icon("bars")

# Icon to toggle the controlbar
controlbarIcon <-  shiny::icon("th")

# Whether to fix the navbar to the top
fixed          <-  FALSE

# -- Create Header Elements

# Custom left Ui content
left_ui  <- NULL

# Custom right Ui content
right_ui <- NULL

# -- Register Header Elements in the ORDER SHOWN in the UI
add_ui_header(skin, status, border, compact, sidebarIcon, controlbarIcon, fixed, left_ui, right_ui)
