# Entry points for logging actions

Generate a log record and pass it to the logging system.  

## Usage

``` r
logdebug(msg, ..., logger = "")

loginfo(msg, ..., logger = "")

logwarn(msg, ..., logger = "")

logerror(msg, ..., logger = "")
```

## Arguments

- msg:

  the textual message to be output, or the format for the ... arguments

- ...:

  if present, msg is interpreted as a format and the ... values are
  passed to it to form the actual message.

- logger:

  the name of the logger to which we pass the record

## Value

no return value, prints log contents into R console and app log file

## Details

A log record gets timestamped and will be independently formatted by
each of the handlers handling it.  

Leading and trailing whitespace is stripped from the final message.
