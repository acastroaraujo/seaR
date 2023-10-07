

#' Risk Set
#'
#' @param size a numeric vector
#' @param ... vectors of identities
#' @param sep a string
#'
#' @return a risk set data frame
#' @export
#'
risk_set <- function(size, ..., sep = "|") {

  identities <- expand.grid(..., stringsAsFactors = FALSE) |>
    apply(1, \(x) paste(x, collapse = ""))

  id <- purrr::map(size, \(k) {
    arrangements::combinations(identities, k = k, replace = TRUE) |>
      apply(1, paste, collapse = sep)
  })

  out <- tibble::tibble(id, size) |>
    tidyr::unnest_longer(id)

  return(out)

}

#' Risk Set Sizes
#'
#' @param size a numeric vector
#' @param ... vectors of identities
#'
#' @return a vector of sizes
#' @export
#'
risk_set_size <- function(size, ...) {

  identities <- expand.grid(..., stringsAsFactors = FALSE) |>
    apply(1, \(x) paste(x, collapse = ""))

  out <- purrr::map_dbl(size, \(k) choose(k + length(identities) - 1L, k)) |>
    purrr::set_names(size)

  return(out)
}


