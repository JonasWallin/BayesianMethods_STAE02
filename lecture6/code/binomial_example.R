modelString = "
  data {
  // comments in c++ are with double dash not # like in R.
  int<lower = 1> N; //integer value not less then one
   int y[N];        // a vector of N integer, y_1,y_2,y_3...,y_N
  }
  parameters {
    // HERE are the random parameters 
    real<lower = 0, upper = 1> theta; // theta must be in [0,1]
  }
  model{
    // here we set the model. 
    theta ~ beta(1, 1); // theta is beta distribuited
    y     ~ bernoulli(theta); // y_i is Bernoulli(theta) = Bin(1, theta)
  }
"
n <- 10
y <- rbinom(n, 1, 0.5) # n - bernoulli trials
data.list <- list(y = y,
                  N = n )

library(rstan)
result_stan <-stan(model_code = modelString, 
                  data = data.list,
                  chains = 1,
                  iter   = 1000)
print(summary(result_stan,par = "theta")$summary)