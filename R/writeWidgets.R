#' Update dependency path
#'
#' \code{update_dep_path} updates dependency path
#'
#' @param dep dep
#' @param libdir libdir
#' @return dep
#' @export
#' @examples
#' \dontrun{
#'
#' }
update_dep_path <- function(dep, libdir = 'lib') {
    dir <- dep$src$file
    if (!is.null(dep$package))
        dir <- system.file(dir, package = dep$package)

    if (length(libdir) != 1 || libdir %in% c("", "/"))
        stop("libdir must be of length 1 and cannot be '' or '/'")

    target <- if (getOption('htmltools.dir.version', TRUE)) {
        paste(dep$name, dep$version, sep = '-')
    } else {
        dep$name
    }
    dep$src$file <- file.path(libdir, target)
    dep
}
# https://github.com/r-lib
# https://github.com/r-lib/desc

#' Write widget
#'
#' \code{write_widget} write widgets
#'
#' @param widget widget
#' @param cdn cdn
#' @param output_option option
#' @param background background
#' @return widget
#' @export
#' @examples
#' \dontrun{
#'
#' }
write_widget <- function(widget, cdn = NULL, output_option=NULL, background = 'white') {
    libdir <- tempdir()

    html <- htmlwidgets:::toHTML(widget, standalone = TRUE, knitrOptions = list())
    html_tags <- htmltools::renderTags(html)
    deps <- lapply(html_tags$dependencies, update_dep_path, libdir = libdir)
    deps <- htmltools::renderDependencies(dependencies = deps, srcType = c('hred', 'file'))
    deps_up <- if (!is.null(cdn)) {
        gsub(libdir, cdn, deps)
    } else {
        deps
    }

    html <- c(
        "<!DOCTYPE html>",
        "<html>",
            "<head>",
                "<meta charset='utf-8'/>",
                deps_up,
                html_tags$head,
            "</head>",
            sprintf("<body style='background-color:%s;'>", htmltools::htmlEscape(background)),
                html_tags$html,
            "</body>",
        "</html>"
    )

    output_option <- match.arg(output_option, c("html", "raw", "saved"))
    switch(
        output_option,
        html = paste(html, collapse = ''),
        raw = charToRaw(paste(html, collapse = '')),
        saved = {
            file <- tempfile()
            writeLines(html, file, useBytes = TRUE)
            file
        }
    )
}
