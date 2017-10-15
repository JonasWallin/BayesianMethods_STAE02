library(NHANES)
data(NHANES)
index <- (NHANES$Age > 20) & (rowSums(is.na(NHANES[,c('Weight','Height',"Gender")]))==0)
NHANES <- NHANES[index,]

alpha <- 1
beta <- 1
sigma0  <- 10^6

modelString <- "
  data{
int<lower = 1> n;
vector[n]  gender;    
vector[n]  height;
real  weight[n];
real<lower =0> sigma0;
real<lower =0> alpha;
real<lower =0> beta;
}
parameters{
real  beta0;
real  beta1;
real  beta2;
real<lower = 0> sigma;
}
model{
beta0 ~ normal(0, sigma0);
beta1 ~ normal(0, sigma0);
beta2 ~ normal(0, sigma0);
sigma ~ gamma(alpha, beta);
weight ~ normal(beta0 + height * beta1 + gender * beta2, sigma);
}
generated quantities {
  real y_pred;
  y_pred = normal_rng(beta0 + 177 * beta1 + 1 * beta2, sigma);
}
"
data.list <- list(n  = length(NHANES$Weight),
                  alpha = alpha , 
                  beta = beta, 
                  sigma0 = sigma0,
                  gender = as.numeric(NHANES$Gender) -1,
                  height= NHANES$Height,
                  weight = NHANES$Weight)

library(rstan)
result_stan <-stan(model_code = modelString, 
                   data = data.list,
                   chains = 2,
                   iter   = 4000)
pairs(result_stan,pars = c("beta0","beta1","beta2","sigma"))
extract(result_stan,pars=c("beta0","beta1"))


