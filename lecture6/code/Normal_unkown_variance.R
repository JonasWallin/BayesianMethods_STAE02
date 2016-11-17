x <- c(-1,-4,-2,0,0.1,2,3)
alpha <- 6
beta  <- 10


modelString <- "
  data{
    int<lower = 1> n;
    real x[n];
    real<lower = 0> alpha;
    real<lower = 0> beta;

  }
  parameters{
    real<lower=0> theta;
  }
  model{
    theta ~ inv_gamma(alpha, beta);
    x ~ normal(0, sqrt(theta));
  }

"
data.list <- list(x = x,
                  n = length(x),
                  alpha = alpha,
                  beta  = beta)

library(rstan)
result_stan <-stan(model_code = modelString, 
                   data = data.list,
                   chains = 1,
                   iter   = 2000)
stan_hist(result_stan, bins = 30)

modelString2 <- "
  data{
int<lower = 1> n;
real x[n];
real<lower = 0> alpha;
real<lower = 0> beta;

}
parameters{
real<lower = 3, upper = 6> theta;
}
model{
x ~ normal(0, sqrt(theta));
}
"
result_stan2 <-stan(model_code = modelString2, 
                   data = data.list,
                   chains = 2,
                   iter   = 4000)
stan_hist(result_stan2, bins = 30)