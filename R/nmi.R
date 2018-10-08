entropy <- function(p) {
  output <- p * log(p)
  output[p == 0] <- 0 # (Cover & Thomas, 1991, p. 13)
  return(sum(output))
}

#' @title Normalized Mutual Information (NMI)
#' @description NMI is a normalization of the Mutual Information (MI) score to
#'   scale the results between 0 (no mutual information) and 1
#'   (perfect correlation). Can also be used to assess agreement between two
#'   clusterings.
#' @param y actual class labels or predicted cluster labels to compare against
#' @param yhat predicted cluster labels (not necessarily the same absolute
#'   values; labels may be permuted)
#' @examples \dontrun{
#' set.seed(0)
#' clusters <- kmeans(iris[, 1:4], centers = 3)
#' y <- as.numeric(iris$Species)
#' yhat <- clusters$cluster
#' nmi(y, yhat) # 0.76
#'
#' data("wine")
#' set.seed(0)
#' clusters <- kmeans(wine[, -1], centers = 3)
#' y <- wine$class
#' yhat <- clusters$cluster
#' nmi(y, yhat) # 0.43
#' }
#' @source
#' - Cover, T. M. & Thomas, J. A. (1991) *Elements of Information Theory*. New York, NY: John Wiley & Sons.
#' - [Normalized variants of the mutual information](https://en.wikipedia.org/wiki/Mutual_information#Normalized_variants)
#' @importFrom stats setNames
#' @aliases NMI
#' @export
nmi <- function(y, yhat) {
  if (!is.factor(y)) y <- factor(y)
  if (!is.factor(yhat)) yhat <- factor(yhat)
  y_counts <- setNames(as.numeric(table(y)), levels(y))
  yhat_counts <- setNames(as.numeric(table(yhat)), levels(yhat))
  # Entropy of Class Labels:
  p_y <- y_counts / sum(y_counts)
  h_y <- -entropy(p_y)
  # Entropy of Cluster Labels:
  p_c <- yhat_counts / sum(yhat_counts)
  h_c <-  -entropy(p_c)
  # Conditional Entropy:
  p_yc <- as.data.frame.matrix(table(y, yhat)) # y as rows, yhat as columns
  p_yc <- apply(p_yc, 2, function(x) { return(x / sum(x)) })
  h_yc <- sum(-p_c * apply(p_yc, 2, entropy))
  # Mutual Information:
  i_yc <- h_y - h_yc
  # Normalized Mutual Information:
  nmi_yc <- (2 * i_yc) / (h_y + h_c)
  return(nmi_yc)
}
