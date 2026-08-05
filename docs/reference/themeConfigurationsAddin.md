# Build application theme configuration YAML file

Call this as an addin to build valid yaml file that is needed for
creating application periscope_style.yaml file. The generated file can
be used in periscope2 app by putting it inside generated app www folder.

## Usage

``` r
themeConfigurationsAddin()
```

## Value

launch gadget window

## Details

The method can be called directly via `R` console or via RStudio addins
menu

## See also

[periscope2:create_application()](https://aggregate-genius.github.io/periscope2/reference/create_application.md)

## Examples

``` r
if (interactive()) {
   periscope2:::themeConfigurationsAddin()
}
```
