book_by_title <- function(title) {
    tbl <- NULL
    ggr <- goodreads_GET ('book/title', title=title)
    tbl <- goodreads_parse_book(ggr)
    tbl
}
