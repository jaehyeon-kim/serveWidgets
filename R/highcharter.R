library(jsonlite)
library(htmlwidgets)
library(highcharter)

opts <- '
{"title":{"text":"Solar Employment Growth by Sector, 2010-2016"},"subtitle":{"text":"Source: thesolarfoundation.com"},"yAxis":{"title":{"text":"Number of Employees"}},"xAxis":{"categories":[2010,2011,2012,2013,2014,2015,2016,2017]},"legend":{"layout":"vertical","align":"right","verticalAlign":"middle"},"plotOptions":{"series":{"label":{"connectorAllowed":true}}},"series":[{"name":"Installation","data":[43934,52503,57177,69658,97031,119931,137133,154175]},{"name":"Manufacturing","data":[24916,24064,29742,29851,32490,30282,38121,40434]},{"name":"Sales & Distribution","data":[11744,17722,16005,19771,20185,24377,32147,39387]},{"name":"Project Development","data":[null,null,7988,12169,15112,22452,34400,34227]},{"name":"Other","data":[12908,5948,8105,11248,8989,11816,18274,18111]}],"responsive":{"rules":[{"condition":{"maxWidth":500},"chartOptions":{"legend":{"layout":"horizontal","align":"center","verticalAlign":"bottom"}}}]}}
'

opts_parsed <- fromJSON(opts, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
h <- highchart(opts_parsed)


trace1 <- '{"x":[1,2,3,4],"y":[10,15,13,17],"type":"scatter","mode":"lines"}'
trace2 <- '{"x":[1,2,3,4],"y":[16,5,11,9],"type":"scatter","mode":"lines"}'

t1_parsed <- fromJSON(trace1, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
t2_parsed <- fromJSON(trace2, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
data <- data.frame(x = unlist(t1_parsed$x), y1 = unlist(t1_parsed$y), y2 = unlist(t2_parsed$y))

excl_data <- function(json_parsed) {
    json_parsed[!names(json_parsed) %in% c('x', 'y')]
}

plot_ly(data, x = ~x) %>%
    add_trace(y = ~y1, type='scatter') %>%
    add_trace(y = ~y2, type='scatter')

f_add_trace <- function(f, vec)

plot_ly(data, x = ~x) %>%
    add_trace(y = ~y1, type='scatter') %>%
    add_trace(y = ~y2, type='scatter')


x <- 1:10
a <- 1:3

fun <- function( x, a, b, c ) {
    sin( x * a ) * exp( -x * b ) + x * c
}

fixVector <- function( f, vec, args) {
    do.call(f, c(list(vec), as.list(args)))
}

fixVector(fun, x, a)



trace_0 <- rnorm(100, mean = 0)
trace_1 <- rnorm(100, mean = 0)
trace_2 <- rnorm(100, mean = 0)
x <- c(1:100)

data <- data.frame(x, trace_0, trace_1, trace_2)

p <- plot_ly(data, x = ~x) %>%
    add_trace(y = ~trace_0, name = 'trace 0',mode = 'lines') %>%
    add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines+markers') %>%
    add_trace(y = ~trace_2, name = 'trace 2', mode = 'markers')


library(leaflet)

m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map
