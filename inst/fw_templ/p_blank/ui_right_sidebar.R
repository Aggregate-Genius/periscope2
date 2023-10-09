# ----------------------------------------
# --       PROGRAM ui_right_sidebar.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application right sidebar and
#      ATTACH them to the UI by calling
#      add_ui_right_sidebar()
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

# -- Configure Right Sidebar

# Whether the control bar on the right side is collapsed or not at start.
collapsed <- TRUE

# Whether the sidebar covers the content when expanded
overlay <- TRUE

# Control bar skin. "dark" or "light".
skin <- "light"

# Whether to block the control bar state
pinned <- FALSE


# -- Create Right Sidebar Elements
# elements to be placed before any menu
sidebar_elements <- NULL
sidebar_menu     <- NULL

# -- Register Right Sidebar Elements in the ORDER SHOWN in the UI
add_ui_right_sidebar(sidebar_elements = sidebar_elements,
                     collapsed        = collapsed,
                     overlay          = overlay,
                     skin             = skin,
                     pinned           = pinned,
                     sidebar_menu     = sidebar_menu)
