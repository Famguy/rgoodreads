user <- function(id) {
    tbl <- NULL
    ggr <- goodreads_GET ('user/show', id=id)
    tbl <- goodreads_parse_user(ggr)
    tbl
}
