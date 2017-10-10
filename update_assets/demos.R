library(magrittr)
library(jsonlite)
library(htmlwidgets)
library(highcharter)

opts <- '
{"title":{"text":"Solar Employment Growth by Sector, 2010-2016"},"subtitle":{"text":"Source: thesolarfoundation.com"},"yAxis":{"title":{"text":"Number of Employees"}},"xAxis":{"categories":[2010,2011,2012,2013,2014,2015,2016,2017]},"legend":{"layout":"vertical","align":"right","verticalAlign":"middle"},"plotOptions":{"series":{"label":{"connectorAllowed":true}}},"series":[{"name":"Installation","data":[43934,52503,57177,69658,97031,119931,137133,154175]},{"name":"Manufacturing","data":[24916,24064,29742,29851,32490,30282,38121,40434]},{"name":"Sales & Distribution","data":[11744,17722,16005,19771,20185,24377,32147,39387]},{"name":"Project Development","data":[null,null,7988,12169,15112,22452,34400,34227]},{"name":"Other","data":[12908,5948,8105,11248,8989,11816,18274,18111]}],"responsive":{"rules":[{"condition":{"maxWidth":500},"chartOptions":{"legend":{"layout":"horizontal","align":"center","verticalAlign":"bottom"}}}]}}
'
opts_parsed <- fromJSON(opts, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
h <- highchart(opts_parsed)

#highcharter:::.join_hc_opts() %>% toJSON(pretty = TRUE)
opts1 <- fromJSON('update_assets/highcharts-demo-up-1.json', simplifyVector = TRUE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
h1 <- highchart(opts1)
h1

opts2 <- fromJSON('update_assets/highcharts-demo-up-2.json', simplifyVector = TRUE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
h2 <- highchart(opts2)
h2

opts3 <- fromJSON('update_assets/highcharts-demo-up-3.json', simplifyVector = TRUE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
h3 <- highchart(opts3)
h3

#highchart
function (hc_opts = list(), theme = getOption("highcharter.theme"),
          type = "chart", width = NULL, height = NULL, elementId = NULL)
{
    assertthat::assert_that(type %in% c("chart", "stock", "map"))
    opts <- .join_hc_opts()
    if (identical(hc_opts, list()))
        hc_opts <- opts$chart
    unfonts <- unique(c(.hc_get_fonts(hc_opts), .hc_get_fonts(theme)))
    opts$chart <- NULL
    x <- list(hc_opts = hc_opts, theme = theme, conf_opts = opts,
              type = type, fonts = unfonts, debug = getOption("highcharter.debug"))
    attr(x, "TOJSON_ARGS") <- list(pretty = getOption("highcharter.debug"))
    htmlwidgets::createWidget(name = "highchart", x, width = width,
                              height = height, package = "highcharter", elementId = elementId,
                              sizingPolicy = htmlwidgets::sizingPolicy(defaultWidth = "100%",
                                                                       knitr.figure = FALSE, knitr.defaultWidth = "100%",
                                                                       browser.fill = TRUE))
}
#<bytecode: 0x5796f68>
#<environment: namespace:highcharter>
hc_opts <- list()
theme <- getOption("highcharter.theme")
type <- "chart"

opts <- highcharter:::.join_hc_opts()
hc_opts <- opts$chart
#toJSON(opts, pretty=TRUE, auto_unbox = TRUE)
unfonts <- unique(c(highcharter:::.hc_get_fonts(hc_opts), highcharter:::.hc_get_fonts(theme)))
opts$chart <- NULL
x <- list(hc_opts = hc_opts, theme = theme, conf_opts = opts, type = type, fonts = unfonts, getOption("highcharter.debug"))


#highcharter:::.join_hc_opts
function ()
{
    list(global = getOption("highcharter.global"), lang = getOption("highcharter.lang"),
         chart = getOption("highcharter.chart"))
}
#<environment: namespace:highcharter>
#highcharter:::.hc_get_fonts
function (lst)
{
    unls <- unlist(lst)
    unls <- unls[grepl("fontFamily", names(unls))]
    fonts <- unls %>% str_replace_all(",\\\\s+sans-serif|,\\\\s+serif",
                                      "") %>% str_replace_all("\\\\s+", "+") %>% str_trim() %>%
        unlist()
    fonts
}
#<environment: namespace:highcharter>


library(leaflet)

m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map
