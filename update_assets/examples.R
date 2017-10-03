library(htmlwidgets)
library(DT)
library(highcharter)
library(plotly)

libdir <- file.path(getwd(), 'lib')
libdir <- getwd()
selfcontained <- FALSE

p <- hchart(ggplot2::mpg, "scatter", hcaes(x = displ, y = hwy, group = class))
p$sizingPolicy$browser$padding <- 10
p$sizingPolicy$browser$fill <- TRUE
#htmlwidgets::saveWidget(p, "plot.html", selfcontained, libdir)

dt <- datatable(iris, extensions = 'Responsive', class = 'display compact', rownames = FALSE, options = list(
    dom = 'lftip',
    scrollY = 300,
    scroller = TRUE,
    pageLength = 10,
    lengthMenu = c(10, 15, 20)
))
dt$sizingPolicy$browser$padding <- 10
dt$sizingPolicy$browser$fill <- TRUE
#htmlwidgets::saveWidget(dt, "table.html", selfcontained, libdir)

p1 <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
p1$sizingPolicy$browser$padding <- 10
p1$sizingPolicy$browser$fill <- TRUE
#htmlwidgets::saveWidget(p1, "plot1.html", selfcontained, libdir)

get_plot <- function(selfcontained = selfcontained, libdir = libs) {
    p <- hchart(mpg, "scatter", hcaes(x = displ, y = hwy, group = class))
    p$sizingPolicy$browser$padding <- 15
    p$sizingPolicy$browser$fill <- TRUE
    htmlwidgets::saveWidget(p, "plot.html", selfcontained, libdir)
}


get_dt <- function(selfcontained = selfcontained, libdir = libs) {
    ##dt <- datatable(iris, rownames = FALSE)
    dt <- datatable(iris, extensions = 'Responsive', class = 'display compact', rownames = FALSE, options = list(
        dom = 'lftip',
        scrollY = 300,
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = c(10, 15, 20)
    ))
    dt$sizingPolicy$browser$padding <- 10
    dt$sizingPolicy$browser$fill <- TRUE
    htmlwidgets::saveWidget(dt, "table.html", selfcontained, libdir)
}

widgets <- list(dt, p, p1)
lapply(1:length(widgets), function(i) {
    f <- write_widget(widgets[[i]], cdn='https://assets.jaehyeon.me', output_option = 'saved')
    file.copy(f, file.path(getwd(), 'update_assets', paste0('demo', i, '.html')))
})


