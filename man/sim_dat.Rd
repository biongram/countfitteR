% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{sim_dat}
\alias{sim_dat}
\title{Data created from simulation of NB Poiss}
\usage{
sim_dat
}
\description{
Data created from simulation of NB Poiss
}
\examples{
# code used to generate the data
# be warned: the simulations will take some time
\dontrun{
library(dplyr)
set.seed(15390)
sim_dat <- do.call(rbind, lapply(10^(-3L:2), function(single_theta)
  do.call(rbind, lapply(1L:10/2, function(single_lambda) 
    do.call(rbind, lapply(1L:100, function(single_rep) {
      
      foci <- lapply(1L:10, function(dummy) rnbinom(600, size = single_theta, mu = single_lambda))
      names(foci) <- paste0("C", 1L:10)
      
      fit_counts(foci, separate = TRUE, model = "all") \%>\%
        summary_fitlist \%>\% 
        mutate(between = single_lambda < upper & single_lambda > lower) \%>\%
        group_by(model) \%>\% 
        summarize(prop = mean(between)) \%>\%
        mutate(replicate = single_rep, lambda = single_lambda, theta = single_theta)
    }))
  ))
))
}
}
\keyword{datasets}
