n <- 10
x_rand <- runif(n,0,5)
y_rand <- 2*x_rand + 1 + 1*rnorm(n)

n2 <- 90
x_temp <- runif(n2,0,5)
x_rand2 <- c(x_rand,x_temp)
y_rand2 <- c(y_rand,2*x_temp + 1 + 1*rnorm(n2))


alpha = 0.01
beta  = 0.01
sigma0 = 10^2
data.list <- list(
  x  = x_rand,
  n  = length(x_rand),
  y  = y_rand,
  alpha = 0.01,
  beta = 0.01,
  sigma0 = sigma0
)

library(rstan)
result_stan <-stan(file = "regression.stan", 
                   data = data.list,
                   chains = 2,
                   iter   = 2000)
pairs(result_stan, pars=c("beta0", "beta1"))
stan_hist(result_stan, pars=c("beta0","beta1"), bins = 100) + xlim(-1, 5)