# add_ui_left_sidebar no left sidebar

    $disable
    [1] TRUE
    

# add_ui_left_sidebar empty left sidebar

    [[1]]
    [[1]][[1]]
    <div id="sidebarBasicAlert"></div>
    
    [[1]][[2]]
    NULL
    
    
    $skin
    [1] "light"
    
    $status
    [1] "primary"
    
    $elevation
    [1] 4
    
    $collapsed
    [1] FALSE
    
    $minified
    [1] FALSE
    
    $expand_on_hover
    [1] FALSE
    
    $fixed
    [1] TRUE
    
    $custom_area
    NULL
    
    [[10]]
    NULL
    

# add_ui_left_sidebar example left sidebar

    [[1]]
    [[1]][[1]]
    <div id="sidebarBasicAlert"></div>
    
    [[1]][[2]]
    NULL
    
    
    $skin
    [1] "light"
    
    $status
    [1] "primary"
    
    $elevation
    [1] 4
    
    $collapsed
    [1] FALSE
    
    $minified
    [1] FALSE
    
    $expand_on_hover
    [1] FALSE
    
    $fixed
    [1] TRUE
    
    $custom_area
    NULL
    

# add_ui_footer empty footer

    <footer class="main-footer" data-fixed="false">
      <div class="float-right d-none d-sm-inline"></div>
      <div id="footerAlert"></div>
    </footer>

# add_ui_footer example footer

    <footer class="main-footer" data-fixed="false">
      <div class="float-right d-none d-sm-inline">2022</div>
      <div id="footerAlert"></div>
      <a href="https://periscopeapps.org/" target="_blank">periscope2</a>
    </footer>

# add_ui_body empty body

    Code
      shiny::isolate(periscope2:::.g_opts$body_elements)
    Output
      [[1]]
      <div id="bodyAlert"></div>
      
      [[2]]
      <div id="head"></div>
      
      [[3]]
      NULL
      

# add_ui_body example body

    [[1]]
    <div id="bodyAlert"></div>
    
    [[2]]
    <div id="head"></div>
    
    [[3]]
    [[3]][[1]]
    <div class="jumbotron bg-info">
      <h1 class="display-4">periscope2: Enterprise Streamlined 'Shiny' Application Framework</h1>
      <p class="lead">
        <p>
          periscope2 is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience
          functions with the goal of both streamlining robust application development and assisting in creating a consistent
           user experience regardless of application or developer.
        </p>
      </p>
      <hr class="my-4"/>
      <p>
        <dl>
          <dt>Features</dt>
          <ul>
            <li>A predefined but flexible template for new Shiny applications with a default dashboard layout</li>
            <li>Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local.</li>
            <li>Six off shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'</li>
            <li>Different methods to notify user and add useful information about application UI and server operations</li>
          </ul>
        </dl>
      </p>
      <a class="btn btn-secondary btn-lg" href="https://periscopeapps.org/" target="_blank" role="button">More</a>
    </div>
    
    

---

    [[1]]
    <div id="bodyAlert"></div>
    
    [[2]]
    <div id="head"></div>
    
    [[3]]
    <div>more elements</div>
    
    [[4]]
    [[4]][[1]]
    <div class="jumbotron bg-info">
      <h1 class="display-4">periscope2: Enterprise Streamlined 'Shiny' Application Framework</h1>
      <p class="lead">
        <p>
          periscope2 is a scalable and UI-standardized 'shiny' framework including a variety of developer convenience
          functions with the goal of both streamlining robust application development and assisting in creating a consistent
           user experience regardless of application or developer.
        </p>
      </p>
      <hr class="my-4"/>
      <p>
        <dl>
          <dt>Features</dt>
          <ul>
            <li>A predefined but flexible template for new Shiny applications with a default dashboard layout</li>
            <li>Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local.</li>
            <li>Six off shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'</li>
            <li>Different methods to notify user and add useful information about application UI and server operations</li>
          </ul>
        </dl>
      </p>
      <a class="btn btn-secondary btn-lg" href="https://periscopeapps.org/" target="_blank" role="button">More</a>
    </div>
    
    

# set_app_parameters update values

    Code
      shiny::isolate(periscope2:::.g_opts$app_info)
    Output
      Demonstrat periscope features and generated application layout

---

    Code
      shiny::isolate(periscope2:::.g_opts$loading_indicator)
    Output
      $html
      <div>Loading ...</div>
      

# load_theme_settings - null settings

    Code
      load_theme_settings()
    Output
      NULL

# create_theme - full settings

    Code
      nchar(create_theme())
    Output
      [1] 669361

# create_theme - invalid color settings

    Code
      nchar(create_theme())
    Output
      [1] 669361

# create_theme - invalid measure settings

    Code
      nchar(create_theme())
    Output
      [1] 669361

# ui_tooltip

    <span class="periscope-input-label-with-tt">
      mylabel
      <img id="id" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="top" title="mytext"/>
    </span>

---

    <span class="periscope-input-label-with-tt">
      mylabel2
      <img id="id2" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="left" title="mytext2"/>
    </span>

---

    'arg' should be one of "top", "bottom", "left", "right"

# theme - valid theme

    Code
      nchar(create_theme())
    Output
      [1] 669399

