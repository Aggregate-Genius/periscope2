# downloadablePlotUI btn_overlap=true btn_halign=left btn_valign=bottom

    [[1]]
    <div class="shiny-plot-output html-fill-item" id="myid-dplotOutputID" style="width:80%;height:300px;"></div>
    
    [[2]]
    <span id="myid-dplotButtonDiv" class="periscope-downloadable-plot-button" style="display:inherit; padding: 5px;float:left;top: -50px">
      <span data-toggle="tooltip" data-placement="top" title="myhovertext">
        <a id="myid-dplotButtonID-png" class="btn btn-default shiny-download-link periscope-download-btn" href="" target="_blank" download>
          <i class="fas fa-download" role="presentation" aria-label="download icon"></i>
        </a>
      </span>
    </span>
    

# downloadablePlotUI btn_overlap=false btn_halign=center btn_valign=top

    [[1]]
    <span id="myid-dplotButtonDiv" class="periscope-downloadable-plot-button" style="display:inherit; padding: 5px;float:none;margin-left:45%;top: -5px">
      <span data-toggle="tooltip" data-placement="top" title="myhovertext">
        <a id="myid-dplotButtonID-png" class="btn btn-default shiny-download-link periscope-download-btn" href="" target="_blank" download>
          <i class="fas fa-download" role="presentation" aria-label="download icon"></i>
        </a>
      </span>
    </span>
    
    [[2]]
    <div class="shiny-plot-output html-fill-item" id="myid-dplotOutputID" style="width:80%;height:300px;"></div>
    

# downloadablePlotUI invalid btn_valign

    Code
      downloadablePlotUI(id = "myid", downloadtypes = c("png"), download_hovertext = "myhovertext",
      width = "80%", height = "300px", btn_halign = "bottom", btn_valign = "center",
      btn_overlap = FALSE, clickOpts = NULL, hoverOpts = NULL, brushOpts = NULL)
    Warning <simpleWarning>
      bottom  is not a valid btn_halign input - using default value. Valid values: <'left', 'center', 'right'>
      center  is not a valid btn_valign input - using default value. Valid values: <'top', 'bottom'>
    Output
      [[1]]
      <div class="shiny-plot-output html-fill-item" id="myid-dplotOutputID" style="width:80%;height:300px;"></div>
      
      [[2]]
      <span id="myid-dplotButtonDiv" class="periscope-downloadable-plot-button" style="display:inherit; padding: 5px;top: 5px">
        <span data-toggle="tooltip" data-placement="top" title="myhovertext">
          <a id="myid-dplotButtonID-png" class="btn btn-default shiny-download-link periscope-download-btn" href="" target="_blank" download>
            <i class="fas fa-download" role="presentation" aria-label="download icon"></i>
          </a>
        </span>
      </span>
      

