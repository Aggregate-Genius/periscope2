# downloadableTableUI

    [[1]]
    <span id="myid-dtableButtonDiv" class="periscope-downloadable-table-button" style="">
      <span data-toggle="tooltip" data-placement="top" title="myHoverText">
        <a id="myid-dtableButtonID-csv" class="btn btn-default shiny-download-link periscope-download-btn" href="" target="_blank" download>
          <i class="fas fa-download" role="presentation" aria-label="download icon"></i>
        </a>
      </span>
    </span>
    
    [[2]]
    <div id="myid-dtableOutputID" style="width:100%; height:auto; " class="datatables html-widget html-widget-output"></div>
    
    [[3]]
    <input id="myid-dtableOutputHeight" type="text" class="shiny-input-container hidden" value="200px"/>
    
    [[4]]
    <input id="myid-dtableSingleSelect" type="text" class="shiny-input-container hidden" value="FALSE"/>
    

# downloadableTable - singleSelect_FALSE_selection_enabled

    Code
      output$dtableOutputID
    Output
      {"x":{"filter":"none","vertical":false,"container":"<table class=\"periscope-downloadable-table table-condensed table-striped table-responsive\">\n  <thead>\n    <tr>\n      <th>mpg<\/th>\n      <th>cyl<\/th>\n      <th>disp<\/th>\n      <th>hp<\/th>\n      <th>drat<\/th>\n      <th>wt<\/th>\n      <th>qsec<\/th>\n      <th>vs<\/th>\n      <th>am<\/th>\n      <th>gear<\/th>\n      <th>carb<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"deferRender":false,"paging":false,"scrollX":true,"dom":"<\"periscope-downloadable-table-header\"f>tr","processing":true,"rowId":1,"searchHighlight":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6,7,8,9,10]}],"order":[],"autoWidth":false,"orderClasses":false,"serverSide":true},"selection":{"mode":"multiple","selected":["Mazda RX4","Mazda RX4 Wag","Datsun 710","Hornet 4 Drive","Hornet Sportabout","Valiant"],"target":"row","selectable":null}},"evals":[],"jsHooks":[],"deps":[{"name":"jquery","version":"3.6.0","src":{"href":"jquery-3.6.0"},"meta":null,"script":"jquery-3.6.0.min.js","stylesheet":null,"head":null,"attachment":null,"all_files":true},{"name":"dt-core","version":"1.11.3","src":{"href":"dt-core-1.11.3"},"meta":null,"script":"js/jquery.dataTables.min.js","stylesheet":["css/jquery.dataTables.min.css","css/jquery.dataTables.extra.css"],"head":null,"attachment":null,"package":null,"all_files":false},{"name":"dt-plugin-searchhighlight","version":"1.11.3","src":{"href":"dt-plugin-searchhighlight-1.11.3"},"meta":null,"script":["jquery.highlight.js","source.min.js"],"stylesheet":"source.css","head":null,"attachment":null,"package":null,"all_files":true},{"name":"crosstalk","version":"1.2.0","src":{"href":"crosstalk-1.2.0"},"meta":null,"script":"js/crosstalk.min.js","stylesheet":"css/crosstalk.min.css","head":null,"attachment":null,"all_files":true}]} 

# downloadableTable - null data

    Code
      output$dtableOutputID
    Output
      {"x":null,"evals":[],"jsHooks":[],"deps":[{"name":"jquery","version":"3.6.0","src":{"href":"jquery-3.6.0"},"meta":null,"script":"jquery-3.6.0.min.js","stylesheet":null,"head":null,"attachment":null,"all_files":true},{"name":"dt-core","version":"1.11.3","src":{"href":"dt-core-1.11.3"},"meta":null,"script":"js/jquery.dataTables.min.js","stylesheet":["css/jquery.dataTables.min.css","css/jquery.dataTables.extra.css"],"head":null,"attachment":null,"package":null,"all_files":false},{"name":"dt-plugin-searchhighlight","version":"1.11.3","src":{"href":"dt-plugin-searchhighlight-1.11.3"},"meta":null,"script":["jquery.highlight.js","source.min.js"],"stylesheet":"source.css","head":null,"attachment":null,"package":null,"all_files":true},{"name":"crosstalk","version":"1.2.0","src":{"href":"crosstalk-1.2.0"},"meta":null,"script":"js/crosstalk.min.js","stylesheet":"css/crosstalk.min.css","head":null,"attachment":null,"all_files":true}]} 

# downloadableTable - invalid download option

    Code
      output$dtableOutputID
    Output
      {"x":{"filter":"none","vertical":false,"container":"<table class=\"periscope-downloadable-table table-condensed table-striped table-responsive\">\n  <thead>\n    <tr>\n      <th>mpg<\/th>\n      <th>cyl<\/th>\n      <th>disp<\/th>\n      <th>hp<\/th>\n      <th>drat<\/th>\n      <th>wt<\/th>\n      <th>qsec<\/th>\n      <th>vs<\/th>\n      <th>am<\/th>\n      <th>gear<\/th>\n      <th>carb<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"deferRender":false,"paging":false,"scrollX":true,"dom":"<\"periscope-downloadable-table-header\"f>tr","processing":true,"rowId":1,"searchHighlight":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6,7,8,9,10]}],"order":[],"autoWidth":false,"orderClasses":false,"serverSide":true},"selection":{"mode":"multiple","selected":["Mazda RX4","Mazda RX4 Wag","Datsun 710","Hornet 4 Drive","Hornet Sportabout","Valiant"],"target":"row","selectable":null}},"evals":[],"jsHooks":[],"deps":[{"name":"jquery","version":"3.6.0","src":{"href":"jquery-3.6.0"},"meta":null,"script":"jquery-3.6.0.min.js","stylesheet":null,"head":null,"attachment":null,"all_files":true},{"name":"dt-core","version":"1.11.3","src":{"href":"dt-core-1.11.3"},"meta":null,"script":"js/jquery.dataTables.min.js","stylesheet":["css/jquery.dataTables.min.css","css/jquery.dataTables.extra.css"],"head":null,"attachment":null,"package":null,"all_files":false},{"name":"dt-plugin-searchhighlight","version":"1.11.3","src":{"href":"dt-plugin-searchhighlight-1.11.3"},"meta":null,"script":["jquery.highlight.js","source.min.js"],"stylesheet":"source.css","head":null,"attachment":null,"package":null,"all_files":true},{"name":"crosstalk","version":"1.2.0","src":{"href":"crosstalk-1.2.0"},"meta":null,"script":"js/crosstalk.min.js","stylesheet":"css/crosstalk.min.css","head":null,"attachment":null,"all_files":true}]} 

# downloadableTable - singleSelect_TRUE_selection_enabled

    Code
      output$dtableOutputID
    Output
      {"x":{"filter":"none","vertical":false,"container":"<table class=\"periscope-downloadable-table table-condensed table-striped table-responsive\">\n  <thead>\n    <tr>\n      <th>mpg<\/th>\n      <th>cyl<\/th>\n      <th>disp<\/th>\n      <th>hp<\/th>\n      <th>drat<\/th>\n      <th>wt<\/th>\n      <th>qsec<\/th>\n      <th>vs<\/th>\n      <th>am<\/th>\n      <th>gear<\/th>\n      <th>carb<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"deferRender":false,"paging":false,"scrollX":true,"dom":"<\"periscope-downloadable-table-header\"f>tr","processing":true,"rowId":1,"searchHighlight":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6,7,8,9,10]}],"order":[],"autoWidth":false,"orderClasses":false,"serverSide":true},"selection":{"mode":"single","selected":"Mazda RX4","target":"row","selectable":null}},"evals":[],"jsHooks":[],"deps":[{"name":"jquery","version":"3.6.0","src":{"href":"jquery-3.6.0"},"meta":null,"script":"jquery-3.6.0.min.js","stylesheet":null,"head":null,"attachment":null,"all_files":true},{"name":"dt-core","version":"1.11.3","src":{"href":"dt-core-1.11.3"},"meta":null,"script":"js/jquery.dataTables.min.js","stylesheet":["css/jquery.dataTables.min.css","css/jquery.dataTables.extra.css"],"head":null,"attachment":null,"package":null,"all_files":false},{"name":"dt-plugin-searchhighlight","version":"1.11.3","src":{"href":"dt-plugin-searchhighlight-1.11.3"},"meta":null,"script":["jquery.highlight.js","source.min.js"],"stylesheet":"source.css","head":null,"attachment":null,"package":null,"all_files":true},{"name":"crosstalk","version":"1.2.0","src":{"href":"crosstalk-1.2.0"},"meta":null,"script":"js/crosstalk.min.js","stylesheet":"css/crosstalk.min.css","head":null,"attachment":null,"all_files":true}]} 

# downloadableTable - null rownames

    Code
      output$dtableOutputID
    Output
      {"x":{"filter":"none","vertical":false,"container":"<table class=\"periscope-downloadable-table table-condensed table-striped table-responsive\">\n  <thead>\n    <tr>\n      <th>mpg<\/th>\n      <th>cyl<\/th>\n      <th>disp<\/th>\n      <th>hp<\/th>\n      <th>drat<\/th>\n      <th>wt<\/th>\n      <th>qsec<\/th>\n      <th>vs<\/th>\n      <th>am<\/th>\n      <th>gear<\/th>\n      <th>carb<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"deferRender":false,"paging":false,"scrollX":true,"dom":"<\"periscope-downloadable-table-header\"f>tr","processing":true,"rowId":1,"searchHighlight":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6,7,8,9,10]}],"order":[],"autoWidth":false,"orderClasses":false,"serverSide":true},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[],"deps":[{"name":"jquery","version":"3.6.0","src":{"href":"jquery-3.6.0"},"meta":null,"script":"jquery-3.6.0.min.js","stylesheet":null,"head":null,"attachment":null,"all_files":true},{"name":"dt-core","version":"1.11.3","src":{"href":"dt-core-1.11.3"},"meta":null,"script":"js/jquery.dataTables.min.js","stylesheet":["css/jquery.dataTables.min.css","css/jquery.dataTables.extra.css"],"head":null,"attachment":null,"package":null,"all_files":false},{"name":"dt-plugin-searchhighlight","version":"1.11.3","src":{"href":"dt-plugin-searchhighlight-1.11.3"},"meta":null,"script":["jquery.highlight.js","source.min.js"],"stylesheet":"source.css","head":null,"attachment":null,"package":null,"all_files":true},{"name":"crosstalk","version":"1.2.0","src":{"href":"crosstalk-1.2.0"},"meta":null,"script":"js/crosstalk.min.js","stylesheet":"css/crosstalk.min.css","head":null,"attachment":null,"all_files":true}]} 

# build_datatable_arguments

    Code
      build_datatable_arguments(table_options)
    Message <simpleMessage>
      DT option 'width' is not supported. Ignoring it.
      DT option 'height' is not supported. Ignoring it.
      DT option 'editable' is not supported. Ignoring it.
    Output
      $rownames
      [1] FALSE
      
      $class
      [1] "periscope-downloadable-table table-condensed table-striped table-responsive"
      
      $callback
      [1] "table.order([2, 'asc']).draw();"
      
      $caption
      [1] " Very Important Information"
      
      $colnames
      [1] "Area"     "Delta"    "Increase"
      
      $filter
      [1] "bottom"
      
      $extensions
      [1] "Buttons"
      
      $plugins
      [1] "natural"
      
      $options
      $options$order
      $options$order[[1]]
      $options$order[[1]][[1]]
      [1] 2
      
      $options$order[[1]][[2]]
      [1] "asc"
      
      
      $options$order[[2]]
      $options$order[[2]][[1]]
      [1] 3
      
      $options$order[[2]][[2]]
      [1] "desc"
      
      
      
      $options$deferRender
      [1] FALSE
      
      $options$paging
      [1] FALSE
      
      $options$scrollX
      [1] TRUE
      
      $options$dom
      [1] "<\"periscope-downloadable-table-header\"f>tr"
      
      $options$processing
      [1] TRUE
      
      $options$rowId
      [1] 1
      
      $options$searchHighlight
      [1] TRUE
      
      

# format_columns

    Code
      format_columns(DT::datatable(dt), list(formatCurrency = list(columns = c("A",
        "C")), formatPercentage = list(columns = c("D"), 2)))

