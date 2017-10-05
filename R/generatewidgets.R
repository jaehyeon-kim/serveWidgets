#' Unpack data
#'
#' \code{unpack_data} assigns class to widget meta data
#'
#' @param x widget meta data
#' @return widget meta data given class
#' @export
unpack_data <- function(x) {
    structure(
        class = x$package,
        x
    )
}

#' Update sizing policy
#'
#' \code{update_sizing_policy} updates browser sizing policy of a widget
#'
#' @param x widget meta data
#' @return widget meta data given class
update_sizing_policy <- function(x) {
    x$sizingPolicy$browser$padding <- 10
    x$sizingPolicy$browser$fill <- TRUE
    x
}

#' Generate widget
#'
#' S3 generic method of generating a widget
#'
#' @param x unpacked widget meta data
#' @param ... additional arguments to be passed in generating individual widgets
#' @return htmlwidget object
#' @rdname generate_widget
#' @export
#' @examples
#' ## DT examples
#' library(magrittr)
#' opts <- list(scrollY = 300, scroller = TRUE)
#' list(package = 'DT', type = 'table', data = 'iris') %>%
#'     unpack_data() %>% generate_widget(update_size = TRUE)
#' list(package = 'DT', type = 'table', data = 'iris', options = opts) %>%
#'     unpack_data() %>% generate_widget(update_size = TRUE)
generate_widget <- function(x, ...) {
    UseMethod('generate_widget')
}

#' @return \code{NULL}
#'
#' @rdname generate_widget
#' @method generate_widget default
#' @export
generate_widget.default <- function(x, ...) {
    UseMethod('generate_widget')
}
