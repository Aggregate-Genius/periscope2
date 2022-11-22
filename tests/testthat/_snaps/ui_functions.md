# add_ui_header

    [[1]]
    <nav data-fixed="false" class="main-header navbar navbar-expand navbar-white navbar-light">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#">
            <i class="fas fa-bars" role="presentation" aria-label="bars icon"></i>
          </a>
        </li>
      </ul>
      <div class="row" style="width:100%">
        <div class="col-sm-12">
          <div id="announceAlert"></div>
        </div>
        <div class="col-sm-12">
          <div id="headerAlert"></div>
        </div>
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
    
    [[2]]
    NULL
    

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
    
    [[10]]
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
    

# add_ui_right_sidebar empty right sidebar

    <aside class="control-sidebar control-sidebar-light" id="controlbarId" data-collapsed="true" data-overlay="true" data-show="true" data-pin="false" data-slide="true">
      <button id="controlbarPin" class="m-2 p-1 btn btn-xs btn-outline-secondary" type="button">
        <i class="fas fa-thumbtack" role="presentation" aria-label="thumbtack icon"></i>
      </button>
      <div class="control-sidebar-content" id="controlbarTitle">
        <div id="sidebarRightAlert"></div>
      </div>
    </aside>

# add_ui_right_sidebar example right sidebar

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
                <input id="hideFileOrganization" type="checkbox"/>
                <span>Show Files Organization</span>
              </label>
            </div>
          </div>
        </div>
      </div>
    </aside>

