# ### basic - line, bubble, scatter, heatmap, bar, area
# ## line
# plot_ly(x = c(1,2,3), y = c(5,6,7), type = 'scatter', mode = 'lines')
# ## bubble
# plot_ly(x = c(1,2,3), y = c(5,6,7), type = 'scatter', mode = 'markers',
#         size = c(1, 10, 20), markers = list(color = c('red', 'blue', 'green')))
# ## scatter
# plot_ly(x = c(1,2,3), y = c(5,6,7), type = 'scatter', mode = 'markers')
#
# ## heatmap
# plot_ly(z = volcano, type = 'heatmap')
#
# ## bar
# plot_ly(x = c(1,2,3), y = c(5,6,7), type = 'bar', mode = 'markers')
#
# ## area
# plot_ly(x = c(1,2,3), y = c(5,6,7), type = 'scatter', mode = 'lines', fill = 'tozeroy')
#
# ### statistical - histogram, box, histogram2d
# ## histogram
# plot_ly(x = rnorm(100), type = 'histogram')
#
# ## box
# plot_ly(y = rnorm(100), type = 'box') %>%
#     add_trace(y = rnorm(100, 1))
#
# ## histogram2d
# plot_ly(x = rnorm(1000, sd = 10), y = rnorm(1000, sd = 5), type = 'histogram2d')
#
# ### map - bubble, scatter, choropleth
# ## bubble
# plot_ly(type = 'scattergeo', lon = c(-73.5, 151.2), lat = c(45.5, -33.8),
#         markers = list(color = c('red', 'blue'), size = c(30, 50), mode = 'markers'))
#
# ## scatter
# plot_ly(type = 'scattergeo', lon = c(42, 39), lat = c(12, 22),
#         text = c('Rome', 'Greece'), mode = 'markers')
#
# ## choropleth
# plot_ly(type = 'choropleth', locations = c('AZ', 'CA', 'VT'), locationmode = 'USA-states',
#         colorscale = 'Viridis', z = c(1, 20, 40)) %>%
#     layout(geo = list(scope = 'usa'))
#
# ### 3d - surface, scatter3d - line, scatter3d
# ## surface
# plot_ly(type = 'surface', z = volcano)
#
# ## scatter3d - line
# plot_ly(type = 'scatter3d', x = c(9, 8, 5, 1), y = c(1, 2, 4, 8), z = c(11, 8, 15, 3), mode = 'lines')
#
# ## scatter3d
# plot_ly(type = 'scatter3d', x = c(9, 8, 5, 1), y = c(1, 2, 4, 8), z = c(11, 8, 15, 3), mode = 'markers')
