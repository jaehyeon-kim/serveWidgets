### function to create/update CDN
library(htmlwidgets)
library(ggplot2)
library(highcharter)
library(plotly)
library(DT)

'%+%' <- function(x, y) {
    paste(x, y, collapse = ' ')
}

generate_demos <- function(wd = '/tmp') {
    current <- getwd()
    setwd(wd)
    cdn_path <- file.path(wd, 'cdn')
    if (dir.exists(cdn_path)) {
        message('removing folder - ', cdn_path)
        unlink(cdn_path, recursive = TRUE, force = TRUE)
    }
    hc <- hchart(mpg, "scatter", highcharter::hcaes(x = displ, y = hwy, group = class))
    pl <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
    dt <- datatable(iris, extensions = 'Responsive', class = 'display compact')
    widgets <- list(hc, pl, dt)

    lapply(1:length(widgets), function(w) {
        message('writing demo ', w, ' of ', length(widgets))
        file_name <- file.path(wd, paste0('demo', w, '.html'))
        htmlwidgets::saveWidget(widgets[[w]], file_name, selfcontained = FALSE, libdir = cdn_path)
    })

    demos <- list.files(getwd())[grepl('demo[0-9]+.html', list.files(getwd()))]
    message('removing demo files...')
    lapply(demos, function(d) {
        file.remove(file.path(wd, d))
    })
    setwd(current)
    return(paste0(cdn_path, '/'))
}

cdn_path <- generate_demos()
sync_bucket <- function (cdn_path, bucket = Sys.getenv('S3_BUCKET')) {
    bucket_url <- paste0('s3://', bucket)
    cmd <- 'aws s3 sync' %+% cdn_path %+% bucket_url
    system(cmd, intern = TRUE)
}
