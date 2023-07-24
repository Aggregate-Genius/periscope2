library(dplyr)

df <- read.csv("program/data/example.csv",
               strip.white = T,
               comment.char = "#")

app_files <- read.csv("program/data/structure.csv")
files_idx <- read.csv("program/data/struc_indx.csv")

rownames(app_files) <- app_files$X
app_files$X         <- NULL

rownames(files_idx) <- files_idx$X
files_idx$X         <- NULL


load_data1 <- function() {
    ldf <- df %>%
        filter(substr(Geographic.Area, 1, 1) == ".") %>%
        mutate(Geographic.Area = substring(Geographic.Area, 2))

    as.data.frame(ldf)
}


load_data2 <- function() {
    ldf <- df %>%
        filter(substr(Geographic.Area, 1, 1) != ".")

    as.data.frame(ldf)
}


load_data3 <- function() {
    ldf <- df %>%
        select(1:3) %>%
        mutate(Total.Population.Change = as.numeric(gsub(",", "", Total.Population.Change)),
               Natural.Increase = as.numeric(gsub(",", "", Natural.Increase)))

    as.data.frame(ldf)
}


read_themes <- function() {
    theme_settings <- NULL

    if (file.exists("www/periscope_style.yaml")) {
        tryCatch({
            theme_settings <- yaml::read_yaml("www/periscope_style.yaml")
        },
        error = function(e){
            warning("Could not parse 'periscope_style.yaml' due to: ", e$message)
        })
    }
    theme_settings[sapply(theme_settings, is.null)] <- NA

    theme_settings
}

