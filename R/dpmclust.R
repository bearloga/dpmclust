#' @title dpmclust: Bayesian Nonparametric Clustering Using DP-means
#' @description Implements the k-means-like clustering 'DP-means' algorithm by
#' Kulis and Jordan (2011) which enables Bayesian nonparametric clustering with
#' the unknown number of clusters determined automatically by setting a penalty
#' which controls when a new cluster should be created.
#' @references Kulis, B., & Jordan, M. I. (2011). Revisiting k-means: New
#'   Algorithms via Bayesian Nonparametrics.
#'   [arXiv:1111.0352](https://arxiv.org/abs/1111.0352)
#' @aliases dpmclust
#' @docType package
#' @name dpmclust-package
#' @useDynLib dpmclust
#' @importFrom Rcpp sourceCpp
NULL
