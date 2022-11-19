# ----------------------------------------
# --     PROGRAM ui_footer.R     --
# ----------------------------------------
# USE: Create UI elements for the
#      application footer and
#      ATTACH them to the UI by calling
#      add_ui_footer()
#
# NOTEs:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --   RIGHT SIDEBAR ELEMENT CREATION   --
# ----------------------------------------

# -- Create Elements
# Left text
left  <- ""

# Right text
right <- ""

# Whether to fix the foote
fixed <- FALSE

# -- Register Elements in the ORDER SHOWN in the UI
add_ui_footer(left, right, fixed)
