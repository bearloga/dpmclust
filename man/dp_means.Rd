% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dp_means.R
\name{dp_means}
\alias{dp_means}
\title{DP-means Clustering}
\usage{
dp_means(x, lambda, max_iter = 100, tol = 0.001, verbose = TRUE)
}
\arguments{
\item{x}{numeric matrix or data frame of features}

\item{lambda}{threshold distance for creating new clusters}

\item{max_iter}{maximum number of iterations}

\item{tol}{tolerance when checking for convergence}

\item{verbose}{whether to print status information after each iteration}
}
\value{
For convenience and ease of use with visualization and tidying
packages, the returned object has same class (\code{kmeans}) and components
as an object returned by \code{\link[stats:kmeans]{stats::kmeans()}}.
}
\description{
Perform clustering on a data matrix using a pure R
implementation of the DP-means algorithm.
}
\examples{
\dontrun{
x <- iris[, 1:4]
dp_means(x, lambda = 2)

data("wine")
x <- wine[, -1]
dp_means(x, lambda = 500)
}
}
