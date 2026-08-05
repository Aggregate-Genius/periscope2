# load_announcements

Reads and parses application announcements configurations in
`config/announce.yaml`, then display announcements in application
header.

## Usage

``` r
load_announcements(
  announcements_file_path = NULL,
  announcement_location_id = "announceAlert"
)
```

## Arguments

- announcements_file_path:

  The path to announcements configuration file.  
  Use
  [announcementConfigurationsAddin](https://aggregate-genius.github.io/periscope2/reference/announcementConfigurationsAddin.md)
  to generate that file.

- announcement_location_id:

  Announcement target location div id (default = "announceAlert")

## Value

number of seconds an announcement should be staying in caller
application

## Details

If announce.yaml does not exist or contains invalid configurations.
Nothing will be displayed. Closing announcements is caller application
responsibility

## See also

[periscope2:announcementConfigurationsAddin()](https://aggregate-genius.github.io/periscope2/reference/announcementConfigurationsAddin.md)

## Examples

``` r
    load_announcements(system.file("fw_templ/announce.yaml", package = "periscope2"))
#> [1] 30000
```
