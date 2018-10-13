#include <Rcpp.h>
#include <cmath>
#include <algorithm>
using namespace Rcpp;

static double square(double x) {
  return x * x;
}

static double sqrt_double( double x ){ return ::sqrt( x ); }

// [[Rcpp::export]]
double euclideanDistance(NumericVector u, NumericVector v) {
  NumericVector d = u - v;
  std::transform(d.begin(), d.end(), d.begin(), square);
  double ed = std::accumulate(d.begin(), d.end(), 0.0);
  return sqrt_double(ed);
}

// [[Rcpp::export]]
NumericVector euclideanDistances(NumericMatrix u, NumericVector v) {
  NumericVector distances(u.rows());
  for (int i = 0; i < u.rows(); i++) {
    distances(i) = euclideanDistance(u(i,_), v);
  }
  return distances;
}
