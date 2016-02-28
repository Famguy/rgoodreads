#' Query book from the Goodreads API 
#'
#' Query for Goodreads books based on IDs.
#' @param id Goodreads ID of the book
#' @return A \code{data.frame} of book with corresponding information
#'
#' @export
book <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/show', id=id)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
