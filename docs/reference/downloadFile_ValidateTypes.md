# Check passed file types against downloadFile module allowed file types list

It is a downloadFile module helper to return periscope2 defined file
types list and warns user if an invalid type is included

## Usage

``` r
downloadFile_ValidateTypes(types)
```

## Arguments

- types:

  list of types to test

## Value

the list input given in types

## See also

[downloadFileButton](https://aggregate-genius.github.io/periscope2/reference/downloadFileButton.md)

[downloadFile](https://aggregate-genius.github.io/periscope2/reference/downloadFile.md)

[logViewerOutput](https://aggregate-genius.github.io/periscope2/reference/logViewerOutput.md)

[downloadablePlot](https://aggregate-genius.github.io/periscope2/reference/downloadablePlot.md)

[downloadableTableUI](https://aggregate-genius.github.io/periscope2/reference/downloadableTableUI.md)

[downloadableTable](https://aggregate-genius.github.io/periscope2/reference/downloadableTable.md)

## Examples

``` r
  #inside console
  ## Check valid types
  result <- periscope2::downloadFile_AvailableTypes()
  identical(result, c("csv", "xlsx", "tsv", "txt", "png", "jpeg", "tiff", "bmp"))
#> [1] TRUE

  ## check invalid type
  testthat::expect_warning(downloadFile_ValidateTypes(types = "csv_invalid"),
                           "file download list contains an invalid type <csv_invalid>")

```
