  data{
    int<lower = 1> n;        // number of observations
    int<lower = 0> Y[n];     // the data
    real<lower = 0> alpha;   // prior parameter (fixed)
    real<lower = 0> beta;   //  prior parameter (fixed)
  }
  parameters{
    real<lower = 0> theta;

  }
  transformed parameters{
      real<lower = 0> exptheta;
      exptheta = exp(theta);
  }
  model {
    theta ~ normal(0,10);
    Y     ~ poisson(exptheta);
}