#' Monte Carlo Simulation Function
#'
#' Generates random (x, y) coordinates within user-specified bounds.
#'
#' @param n Number of points to generate
#' @param xmin Minimum x value
#' @param xmax Maximum x value
#' @param ymin Minimum y value
#' @param ymax Maximum y value
#'
#' @return A data frame containing x and y coordinates
monte_carlo_sim <- function(n, xmin, xmax, ymin, ymax) {
  x <- runif(n, xmin, xmax)
  y <- runif(n, ymin, ymax)
  df <- data.frame(x = x, y = y)
  
  return(df)
}
