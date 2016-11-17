 data{
int<lower = 1> n;   
vector[n]  x;
real  y[n];
real<lower =0> sigma0;
real<lower =0> alpha;
real<lower =0> beta;
}
parameters{
real  beta0;
real  beta1;
real<lower = 0> sigma;
}
model{
beta0 ~ normal(0, sigma0);
beta1 ~ normal(0, sigma0);
sigma ~ gamma(alpha, beta);
y ~ normal(beta0 + x * beta1, sigma);
}