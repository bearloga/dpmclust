euclidean_distance <- function(u, v) {
  return(sqrt(sum((u - v) ^ 2)))
}

#' @title DP-means Clustering
#' @description Perform clustering on a data matrix using a pure R
#'   implementation of the DP-means algorithm.
#' @param x numeric matrix or data frame of features
#' @param lambda threshold distance for creating new clusters
#' @param max_iter maximum number of iterations
#' @param tol tolerance when checking for convergence
#' @param verbose whether to print status information after each iteration
#' @examples \dontrun{
#' x <- iris[, 1:4]
#' dp_means(x, lambda = 2)
#'
#' data("wine")
#' x <- wine[, -1]
#' dp_means(x, lambda = 500)
#' }
#' @return For convenience and ease of use with visualization and tidying
#'   packages, the returned object has same class (`kmeans`) and components
#'   as an object returned by [stats::kmeans()].
#' @export
dp_means <- function(x, lambda, max_iter = 100, tol = 1e-3, verbose = TRUE) {
  if (!is.data.frame(x)) x <- as.data.frame(x)
  k <- 1
  mu <- matrix(colMeans(x), ncol = ncol(x), nrow = k)
  colnames(mu) <- colnames(x)
  z <- rep(1, nrow(x))
  ss_total <- numeric(max_iter)
  for (iteration in 1:max_iter) {
    for (i in 1:nrow(x)) {
      d_ic <- numeric(k)
      for (c in 1:k) {
        d_ic[c] <- euclidean_distance(x[i,, drop = FALSE], mu[c,, drop = FALSE])
      }
      if (min(d_ic) > lambda) {
        k <- k + 1
        z[i] <- k
        mu <- rbind(mu, x[i, ])
      } else {
        z[i] <- which.min(d_ic)
      }
    }
    # Compute new cluster means:
    clusters <- split(x, z)
    mu <- do.call(rbind, lapply(clusters, colMeans))
    # Calculate the objective:
    ss_within <- numeric(k)
    for (c in 1:k) {
      ss_within[c] <- sum(apply(clusters[[c]], 1, euclidean_distance, v = mu[c,, drop = FALSE]))
    }
    ss_between <- sum(ss_within)
    ss_total[iteration] <- ss_between + lambda * k
    if (verbose) {
      msg <- sprintf("After iteration %i: clusters = %i, penalized sum of squares = %.4f",
                     iteration, k, ss_total[iteration])
      message(msg)
    }
    # Check for convergence:
    if (iteration > 1) {
      if ((ss_total[iteration - 1] - ss_total[iteration]) <= tol) {
        if (verbose) message("Reached convergence")
        break
      }
    }
    if (iteration == max_iter && verbose) message("Reached iteration limit")
  }
  return(structure(
    list(
      centers = mu, cluster = z,
      totss = ss_total[iteration],
      withinss = ss_within,
      betweenss = ss_between,
      tot.withinss = sum(ss_within),
      size = vapply(clusters, nrow, 1L),
      iter = iteration,
      ifault = 0L
    ),
    class = "kmeans"
  ))
}
