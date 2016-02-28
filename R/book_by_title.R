#' Query book from the Goodreads API by title
#'
#' Query for Goodreads books based on titles.
#' @param title Title of the book
#' @return A \code{data.frame} of book with corresponding information
#'
#' @export
book_by_title <- function(title) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/title', title=title)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
