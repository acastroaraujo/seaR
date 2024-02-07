

#' Calculate Risk Set
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
      apply(1, \(x) paste(sort(x), collapse = sep))
  })

  out <- tibble::tibble(.id = id, .size = size) |>
    tidyr::unnest_longer(.data[[".id"]])

  structure(out, class = c("risk_set", class(out)), identities = identities)

}

#' Risk Set Sizes
#'
#' @param size a numeric vector
#' @param ... vectors of identities
#'
#' @return a vector of sizes
#' @rdname risk_set
#' @export
#'
risk_set_size <- function(size, ...) {

  identities <- expand.grid(..., stringsAsFactors = FALSE) |>
    apply(1, \(x) paste(x, collapse = ""))

  out <- purrr::map_dbl(size, \(k) choose(k + length(identities) - 1L, k)) |>
    purrr::set_names(size)

  message("Total: ", format(sum(out), big.mark = ","))
  return(out)
}

#' Extract probabilities from data frame and risk set
#'
#' @param data data frame
#' @param identities identities from risk set
#' @param probs external vector of probabilities (optional)
#' @param log logical; if TRUE, probabilities p are given as log(p).
#'
#' @return a vector of conditional probabilities (or log-probabilities)
#' @export
#'
event_probs <- function(data, identities, probs = NULL, log = FALSE) {

  stopifnot(all(c(".id", ".size") %in% colnames(data)))
  s <- purrr::map(identities, rlang::sym)

  obj <- purrr::reduce(.init = data, identities, function(data, i) {
    dplyr::mutate(data, {{i}} := stringr::str_count(.data[[".id"]], i))
  })

  if (is.null(probs)) {
    stopifnot("n" %in% colnames(data))
    probs <- purrr::map_dbl(s, \(x) with(obj, sum(eval(x)*n) / sum(.size*n))) |>
      purrr::set_names(identities)
  } else {
    if (!all(names(probs) %in% identities)) stop(call. = FALSE, "\"probs\" vector is specified incorrectly")
    probs <- probs[identities]
  }

  out <- apply(dplyr::select(obj, dplyr::all_of(identities)), 1, \(x) stats::dmultinom(x, prob = probs, log = log))
  structure(out, class = c("eprobs", class(out)), identities_prob = probs)

}



#' Shannon Index of Diversity
#'
#' @param data data frame with .id column
#' @param identities vector of identity names
#'
#' @return a vector of diversity indicators (entropies)
#' @export
#'
H <- function(data, identities) {

  if (!(".id" %in% colnames(data))) stop(call. = FALSE, "data must have an \".id\" column")

  ## get counts from .id
  s <- purrr::map(identities, rlang::sym)
  obj <- purrr::reduce(.init = data, identities, function(data, i) {
    dplyr::mutate(data, {{i}} := stringr::str_count(.data[[".id"]], i))
  })

  apply(dplyr::select(obj, dplyr::all_of(identities)), 1, function(x) {
    freq <- x / sum(x)
    vec <- freq[freq > 0]
    return(-1 * sum(vec * log2(vec)))
  })

}

#' Numerically stable computation of log sums of exponentiated values.
#'
#' This helps to avoid rounding errors that occur when working with direct probabilities.
#'
#' @source Taken from Richard McElreath's `rethinking` package
#'
#' @param x vector of values
#'
#' @return a scalar
#' @export
#'
log_sum_exp <- function(x) {
  xmax <- max(x)
  xsum <- sum(exp(x - xmax))
  xmax + log(xsum)
}

#' Sort + Collapse
#'
#' This functions takes a set of character variables and collapses them into one
#' unique identifier after appropriate sorting. The resulting id will correspond
#' to the one produced by `risk_set()`
#'
#' @param ... a set of variables
#' @param sep defaults to "|"
#'
#' @return a new id variable
#' @export
#'
sort_collapse <- function(..., sep = "|") {

  M <- do.call(cbind, list(...))
  apply(M, 1, \(x) paste(sort(x), collapse = sep))

}


#' Extract Identities from risk set object
#'
#' @param rs a risk set object
#'
#' @return a character vector
#' @export
#'
get_identities <- function(rs) {
  stopifnot(inherits(rs, "risk_set"))
  attr(rs, "identities", exact = TRUE)
}


get_identity_probs <- function(data, identities) {

  stopifnot(all(c(".id", ".size", "n") %in% colnames(data)))
  s <- purrr::map(identities, rlang::sym)

  obj <- purrr::reduce(.init = data, identities, function(data, i) {
    dplyr::mutate(data, {{i}} := stringr::str_count(.data[[".id"]], i))
  })

  purrr::map_dbl(s, \(x) with(obj, sum(eval(x)*n) / sum(.size*n))) |>
    purrr::set_names(identities)
}

