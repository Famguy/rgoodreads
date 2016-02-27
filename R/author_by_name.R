author_by_name <- function(name) {
    tbl <- NULL
    ggr <- goodreads_GET (paste0('api/author_url/',name))
    tbl <- goodreads_parse_user(ggr)
    tbl
}

