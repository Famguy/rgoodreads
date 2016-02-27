book_by_isbn <- function(isbn) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/isbn', isbn=isbn)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
