#1
w = rbinom(1,1,0.3);
N = 10000;
Y = w * rnorm(N,0.1,1) + (1-w)*rnorm(N,0.5,3)
hist(Y)
MC_exp = sum(Y)/N;
MC_var = sum((Y-MC_exp)^2)/(N-1);

#2
#install.packages("rstan")
library(rstan)

N = 5;
X = c(7.66,10.14,8.59,9.47,9.49);

Model = "
data{
int<lower = 1> n;
real x[n];
real<lower = 0> mu0;
real<lower = 0> sigma0;
real<lower = 0> sigma;
}
parameters{
real<lower = 0> mu;
}
model{
mu ~ normal(mu0,sigma0);
x ~ normal(mu,sigma);
}"

male_data <- list(n = N, x = X, mu0 = 9.65, sigma0 = 2.41, sigma = 1.5);

Smale <- stan(model_code = Model, data = male_data, chains = 1, iter = 1000)



