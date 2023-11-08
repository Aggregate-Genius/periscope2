# announcement addin - UI

    <div class="gadget-container">
      <style type="text/css">span.periscope-input-label-with-tt, #star, .periscope-input-label-with-tt div {
        display: inline-flex;
    }
    
    .dialogTop  img {
        display: none;
    }
    
    #star {
        color:red;
    }</style>
      <div class="gadget-title">
        <h1>Announcement Configuration YAML File Builder</h1>
        <button class="btn btn-default btn-sm action-button pull-left" id="cancel" type="button">Cancel</button>
        <button class="btn btn-primary btn-sm action-button pull-right" id="done" type="button">Done</button>
      </div>
      <div class="gadget-scroll">
        <div class="gadget-content">
          <div class="gadget-absfill" style="position: absolute; top:15px;right:15px;bottom:15px;left:15px;;">
            <div class="row">
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width:100%;">
                  <label class="control-label" id="startPicker-label" for="startPicker">
                    <span class="periscope-input-label-with-tt">
                      Start Date
                      <img id="startPickerTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="First date the announcement will be shown in the application. Missing or blank value indicates that the announcement will show immediately. Both missing or blank start and end values indicates that the announcement will be always be on."/>
                    </span>
                  </label>
                  <div class="input-group">
                    <input id="startPicker" class="sw-air-picker form-control" type="text" autocomplete="off" data-timepicker="false"/>
                    <div class="btn action-button input-group-addon dp-addon btn-outline-secondary" id="startPicker_button">
                      <i class="far fa-calendar-days" role="presentation" aria-label="calendar-days icon"></i>
                    </div>
                  </div>
                  <script type="application/json" data-for="startPicker">{"updateOn":"change","todayButtonAsDate":false,"language":"EN","options":{"autoClose":false,"timepicker":false,"range":false,"dateFormat":"yyyy-MM-dd","multipleDates":false,"multipleDatesSeparator":" - ","view":"days","minView":"days","clearButton":false,"todayButton":false,"buttons":false,"monthsField":"monthsShort","onlyTimepicker":false,"toggleSelected":true}}</script>
                </div>
              </div>
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width:100%;">
                  <label class="control-label" id="endPicker-label" for="endPicker">
                    <span class="periscope-input-label-with-tt">
                      End Date
                      <img id="endPickerTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="Last date the announcement will be shown in the application. Missing or blank value indicates that the announcement will be shown indefinitely Both missing or blank start and end values indicates that the announcement will be always be on."/>
                    </span>
                  </label>
                  <div class="input-group">
                    <input id="endPicker" class="sw-air-picker form-control" type="text" autocomplete="off" data-timepicker="false"/>
                    <div class="btn action-button input-group-addon dp-addon btn-outline-secondary" id="endPicker_button">
                      <i class="far fa-calendar-days" role="presentation" aria-label="calendar-days icon"></i>
                    </div>
                  </div>
                  <script type="application/json" data-for="endPicker">{"updateOn":"change","todayButtonAsDate":false,"language":"EN","options":{"autoClose":false,"timepicker":false,"range":false,"dateFormat":"yyyy-MM-dd","multipleDates":false,"multipleDatesSeparator":" - ","view":"days","minView":"days","clearButton":false,"todayButton":false,"buttons":false,"monthsField":"monthsShort","onlyTimepicker":false,"toggleSelected":true}}</script>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width:100%;">
                  <label class="control-label" id="auto_close-label" for="auto_close">
                    <span class="periscope-input-label-with-tt">
                      Close after (sec)
                      <img id="autoCloseTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="Time, in seconds, to auto close announcement banner after that time elapsed Leave value blank or zero to leave announcement bar open until user closes it manually."/>
                    </span>
                  </label>
                  <input id="auto_close" type="number" class="shiny-input-number form-control" value="30" min="0" max="100"/>
                </div>
              </div>
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width:100%;">
                  <label class="control-label" id="style-label" for="style">
                    <span class="periscope-input-label-with-tt">
                      <div>
                        Style
                        <div id="star">*</div>
                      </div>
                      <img id="styleTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="Color for the announcement banner, possible values are {&#39;primary&#39;, &#39;success&#39;, &#39;warning&#39;, &#39;danger&#39; or &#39;info&#39;}. It is a mandatory value."/>
                    </span>
                  </label>
                  <div>
                    <select class="shiny-input-select form-control" id="style"><option value="primary" selected>primary</option>
    <option value="success">success</option>
    <option value="warning">warning</option>
    <option value="danger">danger</option>
    <option value="info">info</option></select>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width:100%;">
                  <label class="control-label" id="title-label" for="title">
                    <span class="periscope-input-label-with-tt">
                      Title
                      <img id="titleTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="Optional banner title. Leave it empty to disable it"/>
                    </span>
                  </label>
                  <input id="title" type="text" class="shiny-input-text form-control" value="" placeholder="Announcement Banner Title"/>
                </div>
              </div>
              <div class="col-xs-6 col-md-6">
                <div class="form-group shiny-input-container" style="width: 100%;">
                  <label class="control-label" id="announcement_text-label" for="announcement_text">
                    <span class="periscope-input-label-with-tt">
                      <div>
                        Announcement Text
                        <div id="star">*</div>
                      </div>
                      <img id="textTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="bottom" title="The announcement text. Text can contain html tags and is a mandatory value"/>
                    </span>
                  </label>
                  <textarea id="announcement_text" class="shiny-input-textarea form-control" placeholder="Announcement Text" style="width:100%;height:100%;"></textarea>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12 col-md-12">
                <a id="downloadConfig" class="btn btn-default shiny-download-link " href="" target="_blank" download disabled="TRUE">
                  <i class="fas fa-download" role="presentation" aria-label="download icon"></i>
                  <span class="periscope-input-label-with-tt">
                    Download
                    <img id="downloadTip" src="img/tooltip.png" height="16px" width="16px" data-toggle="tooltip" data-placement="top" title="Download announcement configuration file"/>
                  </span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

