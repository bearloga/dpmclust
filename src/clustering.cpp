#include <Rcpp.h>
#include "maths.h"
using namespace Rcpp;

NumericMatrix addCluster(NumericMatrix mu, NumericVector x) {
  int k = mu.rows();
  NumericMatrix new_mu(k + 1, mu.cols());
  for (int i = 0; i < k; i++) {
    new_mu(i,_) = mu(i,_);
  }
  new_mu(k,_) = x;
  return new_mu;
}

// [[Rcpp::export]]
NumericVector processInstances(NumericMatrix mu, NumericMatrix x, double lambda) {
  NumericVector z(x.rows());
  int k = mu.rows();
  NumericVector dic(k);
  for (int i = 0; i < x.rows(); i++) {
    dic = euclideanDistances(mu, x(i,_));
    if (min(dic) > lambda) {
      k++;
      z(i) = k;
      // update cluster centers:
      mu = addCluster(mu, x(i,_));
    } else {
      z(i) = which_min(dic) + 1;
    }
  }
  return z;
}
