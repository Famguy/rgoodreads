#' Query author by name from the Goodreads API 
#'
#' Query for Goodreads authors based on names.
#' @param name Name of the author
#' @return A \code{data.frame} of author with corresponding information
#'
#' @export
author_by_name <- function(name) {
    d <- NULL
    ggr <- goodreads_GET (paste0('api/author_url/',RCurl::curlEscape(name)))
    text <- httr::content(ggr, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    k <- regexpr('author id=\"(\\d+)\"',text, TRUE)
    l <- substr(text,k,k+attr(k,"match.length")-1)
    m <- gsub("author id=", "", l)
    n <- gsub("\"","",m)
    author(n)
}

