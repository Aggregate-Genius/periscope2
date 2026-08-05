# Build Announcement Module Configuration YAML File

Call this as an addin to build valid yaml file that is needed for
running announcements module. The generated file can be used in
periscope2 app using
[load_announcements](https://aggregate-genius.github.io/periscope2/reference/load_announcements.md).

## Usage

``` r
announcementConfigurationsAddin()
```

## Value

launch gadget window

## Details

The method can be called directly via `R` console or via RStudio addins
menu

## See also

[periscope2:load_announcements()](https://aggregate-genius.github.io/periscope2/reference/load_announcements.md)

## Examples

``` r
if (interactive()) {
   periscope2:::announcementConfigurationsAddin()
}
```
