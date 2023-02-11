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

