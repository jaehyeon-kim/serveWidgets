#' @return \code{NULL}
#'
#' @rdname generate_widget
#' @method generate_widget DT
#' @export
generate_widget.DT <- function(x, ...) {
    args <- list(...)
    opts <- if (is.null(x$options)) list() else x$options

    w <- DT::datatable(data = eval(parse(text = x$data)), extensions = 'Responsive',
                       class = 'display compact', rownames = FALSE, options = opts)

    if (!is.null(args$update_size) && args$update_size) {
        w <- update_sizing_policy(w)
    }

    return(w)
}
