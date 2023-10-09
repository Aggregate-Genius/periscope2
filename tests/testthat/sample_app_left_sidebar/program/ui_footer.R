# ----------------------------------------
# --     PROGRAM ui_footer.R     --
# ----------------------------------------
# USE: Create UI elements for the
#      application footer and
#      ATTACH them to the UI by calling
#      add_ui_footer()
#
# NOTES:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --   FOOTER ELEMENT CREATION   --
# ----------------------------------------

# -- Create Elements
# Left text
left <- div("Visit the ", a(
    href   = "https://periscopeapps.org/",
    target = "_blank",
    "hosted gallery"
), "for additional example applications using periscope and periscope2.")

# Right text
right <- div("To contribute, visit package ",  a(
    href   = "https://github.com/Aggregate-Genius/periscope2",
    target = "_blank",
    tags$i(class = "fa fa-github")))

# Whether to fix the footer
fixed <- TRUE

# -- Register Elements in the ORDER SHOWN in the UI
add_ui_footer(left  = left,
              right = right,
              fixed = fixed)
