# Display app logs

Display app log data in downloadableReactTable table containing logged
user actions. Table contents are auto updated whenever a user action is
logged. User can search for logs, sort them by time and download them in
CSV or TSV format. The id must match the same id configured in
**server.R** file upon calling `fw_server_setup` method

## Usage

``` r
logViewerOutput(id = "logViewer")
```

## Arguments

- id:

  character id for the object(default = "logViewer")

## Value

downloadableReactTableUI instance

## Table columns

- action - the action that id logged in any place in app

- time - action time

## Example

`logViewerOutput('logViewer')`

## Shiny Usage

Add the log viewer box to your box list

It is paired with a call to `fw_server_setup` method in **server.R**
file

## See also

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

[downloadFile_ValidateTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_ValidateTypes.md)

[downloadFile_AvailableTypes](https://aggregate-genius.github.io/periscope2/reference/downloadFile_AvailableTypes.md)

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[downloadableTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableTableUI.md)

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

## Examples

``` r
# Inside ui_body add the log viewer box to your box list

logViewerOutput('logViewerId')
#> [[1]]
#> <div class="shiny-panel-conditional" data-display-if="output.displayButton" data-ns-prefix="logViewerId-logViewerId-">
#>   <span id="logViewerId-logViewerId-reactTableButtonDiv" class="periscope-downloadable-react-table-button" style="">
#>     <span class="btn-group" data-toggle="tooltip" data-placement="top" title="Download application logs">
#>       <button aria-expanded="false" aria-haspopup="true" class="btn btn-default action-button dropdown-toggle periscope-download-btn" data-toggle="dropdown" id="logViewerId-logViewerId-reactTableButtonID-downloadFileList" type="button action">
#>         <i class="far fa-copy" role="presentation" aria-label="copy icon"></i>
#>       </button>
#>       <ul class="dropdown-menu" id="logViewerId-logViewerId-reactTableButtonID-testList">
#>         <li>
#>           <a aria-disabled="true" class="shiny-download-link disabled periscope-download-choice" download href="" id="logViewerId-logViewerId-reactTableButtonID-csv" tabindex="-1" target="_blank">csv</a>
#>         </li>
#>         <li>
#>           <a aria-disabled="true" class="shiny-download-link disabled periscope-download-choice" download href="" id="logViewerId-logViewerId-reactTableButtonID-tsv" tabindex="-1" target="_blank">tsv</a>
#>         </li>
#>       </ul>
#>     </span>
#>   </span>
#> </div>
#> 
#> [[2]]
#> <div class="reactable html-widget html-widget-output shiny-report-size html-fill-item" data-reactable-output="logViewerId-logViewerId-reactTableOutputID" id="logViewerId-logViewerId-reactTableOutputID" style="width:auto;height:auto;"></div>
#> 

```
