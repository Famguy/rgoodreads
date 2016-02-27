book <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/show', id=id)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
