library(testthat)
library(periscope2)



# Disable ANSI colors that are causing the issue
options(crayon.enabled = FALSE, cli.ansi = FALSE)
Sys.setenv(NO_COLOR = "1")

cat("=== Running tests with detailed output ===\n")

# Get all test files
test_files <- list.files("testthat", pattern = "^test.*\\.R$", full.names = TRUE)
cat("Found", length(test_files), "test files\n")

failed_tests <- character(0)

# Run each test file individually
for (i in seq_along(test_files)) {
  test_file <- test_files[i]
  cat("\n========================================\n")
  cat("Running test file", i, "of", length(test_files), ":", basename(test_file), "\n")
  cat("========================================\n")

  result <- try({
    testthat::test_file(test_file, reporter = "progress")
  }, silent = FALSE)

  if (inherits(result, "try-error")) {
    cat("❌ FAILED:", basename(test_file), "\n")
    cat("Error:", as.character(result), "\n")
    failed_tests <- c(failed_tests, basename(test_file))
    break  # Stop at first failure
  } else {
    cat("✅ PASSED:", basename(test_file), "\n")
  }
}

if (length(failed_tests) > 0) {
  cat("\n❌ Failed test files:", paste(failed_tests, collapse = ", "), "\n")
  quit(status = 1)
} else {
  cat("\n✅ All test files passed!\n")
}
