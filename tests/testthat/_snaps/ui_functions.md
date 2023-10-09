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
            <li>Predefined but flexible template for new Shiny applications with a default dashboard layout</li>
            <li>Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local.</li>
            <li>Off-the-shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'</li>
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
            <li>Predefined but flexible template for new Shiny applications with a default dashboard layout</li>
            <li>Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local.</li>
            <li>Off-the-shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'</li>
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
      Demonstrate periscope features and generated application layout

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

# theme - parsing error

    Code
      nchar(suppressWarnings(periscope2:::create_theme()))
    Output
      [1] 669361

# theme - invalid theme settings

    Code
      nchar(create_theme())
    Warning <simpleWarning>
      primary has invalid color value. Setting default color.
      -300 must be positive value. Setting default value.
    Output
      [1] 669423

# dashboard - create default dashboard

    Code
      periscope2:::create_application_dashboard()
    Output
      [[1]]
      <div class="row">
        <div class="col-sm-12">
          <div id="announceAlert"></div>
        </div>
      </div>
      
      [[2]]
      <div class="row">
        <div class="col-sm-12">
          <div id="headerAlert"></div>
        </div>
      </div>
      
      [[3]]
      <div class="row">
        <div class="col-sm-12">
          <body data-help="0" data-fullscreen="0" data-dark="0" data-scrollToTop="0">
            <div class="wrapper">
              <nav data-fixed="false" class="main-header navbar navbar-expand navbar-white navbar-light">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#">
                      <i class="fas fa-bars" role="presentation" aria-label="bars icon"></i>
                    </a>
                  </li>
                </ul>
                <div class="row" style="width:100%">
                  <div class="col-sm-4">
                    <div class="periscope-busy-ind">
                      Working
                      <img alt="Working..." hspace="5px" src="img/loader.gif"/>
                    </div>
                  </div>
                  <div class="col-sm-4">
                    <div id="app_header">Set using set_app_parameters() in program/global.R</div>
                  </div>
                  <div class="col-sm-4"></div>
                </div>
                <ul class="navbar-nav ml-auto navbar-right">
                  <li class="nav-item">
                    <a id="controlbar-toggle" class="nav-link" data-widget="control-sidebar" href="#">
                      <i class="fas fa-table-cells" role="presentation" aria-label="table-cells icon"></i>
                    </a>
                  </li>
                </ul>
              </nav>
              <aside id="sidebarId" data-fixed="true" data-minified="FALSE" data-collapsed="FALSE" data-disable="FALSE" class="main-sidebar sidebar-light-primary elevation-4">
                <div class="sidebar" id="sidebarItemExpanded">
                  <nav class="mt-2" expand_on_hover="FALSE">
                    <div id="sidebarBasicAlert"></div>
                    <ul class="nav nav-pills nav-sidebar flex-column sidebar-menu nav-child-indent" data-widget="treeview" role="menu" data-accordion="true">
                      <li class="nav-header">Periscope2 Features</li>
                      <li class="nav-item">
                        <a class="nav-link" id="tab-application_setup" href="#" data-target="#shiny-tab-application_setup" data-toggle="tab" data-value="application_setup">
                          <i class="far fa-building nav-icon" role="presentation" aria-label="building icon"></i>
                          <p>Application Setup</p>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="tab-periscope_modules" href="#" data-target="#shiny-tab-periscope_modules" data-toggle="tab" data-value="periscope_modules">
                          <i class="fas fa-cubes nav-icon" role="presentation" aria-label="cubes icon"></i>
                          <p>Periscope2 Modules</p>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="tab-user_notifications" href="#" data-target="#shiny-tab-user_notifications" data-toggle="tab" data-value="user_notifications">
                          <i class="far fa-comments nav-icon" role="presentation" aria-label="comments icon"></i>
                          <p>User Notifications</p>
                        </a>
                      </li>
                      <div id="features_id" class="sidebarMenuSelectedTabItem" data-value="null"></div>
                    </ul>
                  </nav>
                </div>
              </aside>
              <div class="content-wrapper">
                <section class="content">
                  <div id="bodyAlert"></div>
                  <div id="head"></div>
                  <div>more elements</div>
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
                          <li>Predefined but flexible template for new Shiny applications with a default dashboard layout</li>
                          <li>Separation by file of functionality that exists in one of the three shiny scopes: global, server-global, and server-local.</li>
                          <li>Off-the-shelf and ready to be used modules ('Announcements', 'Table Downloader', 'Plot Downloader', 'File Downloader', 'Application Logger' and 'Reset Application'</li>
                          <li>Different methods to notify user and add useful information about application UI and server operations</li>
                        </ul>
                      </dl>
                    </p>
                    <a class="btn btn-secondary btn-lg" href="https://periscopeapps.org/" target="_blank" role="button">More</a>
                  </div>
                </section>
              </div>
              <aside class="control-sidebar control-sidebar-light" id="controlbarId" data-collapsed="true" data-overlay="true" data-show="true" data-pin="false" data-slide="true">
                <button id="controlbarPin" class="m-2 p-1 btn btn-xs btn-outline-secondary" type="button">
                  <i class="fas fa-thumbtack" role="presentation" aria-label="thumbtack icon"></i>
                </button>
                <div class="control-sidebar-content" id="controlbarTitle">
                  <div id="sidebarRightAlert"></div>
                  <div style="margin-left:20px">
                    <div class="form-group shiny-input-container">
                      <div class="checkbox">
                        <label>
                          <input id="hideFileOrganization" type="checkbox" class="shiny-input-checkbox"/>
                          <span>Show Files Organization</span>
                        </label>
                      </div>
                    </div>
                  </div>
                </div>
              </aside>
              <footer class="main-footer" data-fixed="false">
                <div class="float-right d-none d-sm-inline">2022</div>
                <div id="footerAlert"></div>
                <a href="https://periscopeapps.org/" target="_blank">periscope2</a>
              </footer>
            </div>
          </body>
        </div>
      </div>
      

