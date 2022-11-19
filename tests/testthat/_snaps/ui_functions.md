# fw_create_header

    [[1]]
    <nav data-fixed="false" class="main-header navbar navbar-expand navbar-white navbar-light">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#">
            <i class="fa fa-bars" role="presentation" aria-label="bars icon"></i>
          </a>
        </li>
      </ul>
      <script>$("<div class='periscope-title'> Set using set_app_parameters() in program/global.R </div>").insertAfter($("a.sidebar-toggle"));</script>
      <ul class="navbar-nav ml-auto navbar-right">
        <li class="nav-item">
          <a id="controlbar-toggle" class="nav-link" data-widget="control-sidebar" href="#">
            <i class="fa fa-th" role="presentation" aria-label="th icon"></i>
          </a>
        </li>
      </ul>
    </nav>
    
    [[2]]
    <div class="periscope-busy-ind">
      Working
      <img alt="Working..." hspace="5px" src="img/loader.gif"/>
    </div>
    

# fw_create_sidebar no sidebar

    <aside id="sidebarId" data-fixed="true" data-minified="false" data-collapsed="true" data-disable="FALSE" class="main-sidebar sidebar-dark-primary elevation-4">
      <div class="sidebar" id="sidebarItemExpanded">
        <nav class="mt-2">
          <script>$("<div class='periscope-title'> Set using set_app_parameters() in program/global.R </div>").insertAfter($("a.sidebar-toggle"));</script>
          <script>$('[class~="sidebar-toggle"]').remove();</script>
        </nav>
      </div>
    </aside>

# fw_create_sidebar empty

    <aside id="sidebarId" data-fixed="true" data-minified="false" data-collapsed="false" data-disable="FALSE" class="main-sidebar sidebar-dark-primary elevation-4">
      <div class="sidebar" id="sidebarItemExpanded">
        <nav class="mt-2"></nav>
      </div>
    </aside>

# fw_create_sidebar only basic

    <aside id="sidebarId" data-fixed="true" data-minified="false" data-collapsed="false" data-disable="FALSE" class="main-sidebar sidebar-dark-primary elevation-4">
      <div class="sidebar" id="sidebarItemExpanded">
        <nav class="mt-2">
          <div class="notab-content">
            <p></p>
          </div>
        </nav>
      </div>
    </aside>

# fw_create_sidebar only advanced

    <aside id="sidebarId" data-fixed="true" data-minified="false" data-collapsed="false" data-disable="FALSE" class="main-sidebar sidebar-dark-primary elevation-4">
      <div class="sidebar" id="sidebarItemExpanded">
        <nav class="mt-2">
          <div class="notab-content">
            <p></p>
            <div align="center">
              <div id="appResetId-app_reset_alerts"></div>
              <div class="form-group shiny-input-container" style="width: 90%;">
                <div class="pretty p-toggle p-default p-round p-fill">
                  <input id="appResetId-resetButton" type="checkbox"/>
                  <div class="state p-on p-danger">
                    <label>
                      <span>Cancel Application Reset</span>
                    </label>
                  </div>
                  <div class="state p-off p-warning">
                    <label>
                      <span>Reset Application</span>
                    </label>
                  </div>
                </div>
              </div>
              <span class="invisible">
                <div class="form-group shiny-input-container">
                  <div class="pretty p-toggle p-default">
                    <input id="appResetId-resetPending" type="checkbox"/>
                    <div class="state p-on p-success">
                      <label>
                        <span></span>
                      </label>
                    </div>
                    <div class="state p-off p-danger">
                      <label>
                        <span></span>
                      </label>
                    </div>
                  </div>
                </div>
              </span>
            </div>
          </div>
        </nav>
      </div>
    </aside>

# fw_create_sidebar basic and advanced

    Code
      result$attribs
    Output
      $id
      [1] "sidebarId"
      
      $`data-fixed`
      [1] "true"
      
      $`data-minified`
      [1] "false"
      
      $`data-collapsed`
      [1] "false"
      
      $`data-disable`
      [1] FALSE
      
      $class
      [1] "main-sidebar sidebar-dark-primary elevation-4"
      

