#' Query author from the Goodreads API 
#'
#' Query for Goodreads authors based on IDs.
#' @param id Goodreads ID of the author
#' @return A \code{data.frame} of author with corresponding information
#'
#' @export
author <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('author/show', id=id)
    tbl <- goodreads_parse_author(ggr)
    tbl
}
